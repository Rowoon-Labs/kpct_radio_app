import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/shop_item.dart';

part 'shop_page_event.dart';
part 'shop_page_state.dart';
part 'shop_page_bloc.freezed.dart';

class ShopPageBloc extends Bloc<ShopPageEvent, ShopPageState> {
  final ScrollController scrollController;

  ShopPageBloc()
    : scrollController = ScrollController(),
      super(const ShopPageState()) {
    on<ShopPageEvent>((event, emit) async {
      await event.map(
        tryBuy: (event) async {
          emit(
            state.copyWith(
              processing: List.of(state.processing)..add(event.shopItem.id),
            ),
          );

          final DocumentReference<CustomUser> userReference = FirebaseFirestore
              .instance
              .collection("users")
              .doc(App.instance.auth.customUser?.id)
              .withConverter(
                fromFirestore: CustomUser.fromFirstore,
                toFirestore: CustomUser.toFirestore,
              );

          await FirebaseFirestore.instance.runTransaction<bool>((
            transaction,
          ) async {
            final DocumentSnapshot<CustomUser> snapshot = await transaction
                .get<CustomUser>(userReference);

            final CustomUser? user = snapshot.exists ? snapshot.data() : null;

            if (user != null) {
              final AdjustedItem adjustedItem = event.shopItem.adjust(
                user: user,
              );

              if (adjustedItem.canBuy) {
                final Map<String, dynamic> data = {
                  "radioSsp": (user.radioSsp - event.shopItem.costSsp).clamp2(),
                  "ep": (user.ep - event.shopItem.costEp).clamp2(),
                  if (adjustedItem.id == ShopItemId.shopItem01) ...{
                    "stamina": user.adjustedStaminaMax,
                  },
                };

                if (adjustedItem.exist) {
                  data["items"] =
                      user.items.map((element) {
                        if (element.id == event.shopItem.id) {
                          if (adjustedItem.todayBuyCount > 0) {
                            return Item(
                              id: event.shopItem.id,
                              todayBuyCount: element.todayBuyCount + 1,
                              effectEndAt: event.shopItem.effectEndAt(
                                now: adjustedItem.now,
                              ),
                              lastBuyAt: adjustedItem.now,
                            ).toJson();
                          } else {
                            return Item(
                              id: event.shopItem.id,
                              todayBuyCount: 1,
                              effectEndAt: event.shopItem.effectEndAt(
                                now: adjustedItem.now,
                              ),
                              lastBuyAt: adjustedItem.now,
                            ).toJson();
                          }
                        } else {
                          return element.toJson();
                        }
                      }).toList();
                } else {
                  data["items"] = FieldValue.arrayUnion([
                    Item(
                      id: event.shopItem.id,
                      todayBuyCount: 1,
                      effectEndAt: event.shopItem.effectEndAt(
                        now: adjustedItem.now,
                      ),
                      lastBuyAt: adjustedItem.now,
                    ).toJson(),
                  ]);
                }

                transaction.update(userReference, data);

                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          });

          emit(
            state.copyWith(
              processing: List.of(state.processing)..remove(event.shopItem.id),
            ),
          );
        },
      );
    });
  }
}
