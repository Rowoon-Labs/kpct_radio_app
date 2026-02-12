import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/model/transaction_response.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'insetting_gem_modal_event.dart';
part 'insetting_gem_modal_state.dart';
part 'insetting_gem_modal_bloc.freezed.dart';

class InsettingGemModalBloc
    extends Bloc<InsettingGemModalEvent, InsettingGemModalState> {
  Timer? _timer;

  final Equipment targetEquipment;
  final Pack gemPack;
  final int socketIndex;

  InsettingGemModalBloc({
    required bool substitution,
    required this.socketIndex,
    required this.targetEquipment,
    required this.gemPack,
  }) : super(const InsettingGemModalState()) {
    on<InsettingGemModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const InsettingGemModalEvent.onTick()),
          );

          if (substitution) {
            emit(state.copyWith(initialized: true));
          } else {
            add(
              const InsettingGemModalEvent.insettingPressed(immediately: true),
            );
          }
        },
        insettingPressed: (event) async {
          if (state.status == InsettingGemModalStatus.prepare) {
            if (event.immediately) {
              emit(
                state.copyWith(
                  status: InsettingGemModalStatus.insetting,
                  elapsedDuration: 0,
                  initialized: true,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  status: InsettingGemModalStatus.insetting,
                  elapsedDuration: 0,
                ),
              );
            }

            final DocumentReference<CustomUser> userReference =
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(App.instance.auth.customUser?.id)
                    .withConverter(
                      fromFirestore: CustomUser.fromFirstore,
                      toFirestore: CustomUser.toFirestore,
                    );
            final DocumentReference<Equipment> targetEquipmentReference =
                userReference
                    .collection("equipments")
                    .doc(targetEquipment.id)
                    .withConverter(
                      fromFirestore: Equipment.fromFirstore,
                      toFirestore: Equipment.toFirestore,
                    );
            final DocumentReference<Equipment> gemEquipmentReference =
                userReference
                    .collection("equipments")
                    .doc(gemPack.equipments.first.id)
                    .withConverter(
                      fromFirestore: Equipment.fromFirstore,
                      toFirestore: Equipment.toFirestore,
                    );

            final TransactionResponse<void> response = await FirebaseFirestore
                .instance
                .runTransaction<TransactionResponse<void>>((transaction) async {
                  final DocumentSnapshot<CustomUser> userSnapshot =
                      await transaction.get<CustomUser>(userReference);
                  final DocumentSnapshot<Equipment> targetEquipmentSnapshot =
                      await transaction.get<Equipment>(
                        targetEquipmentReference,
                      );
                  final DocumentSnapshot<Equipment> gemEquipmentSnapshot =
                      await transaction.get<Equipment>(gemEquipmentReference);

                  final CustomUser? user =
                      userSnapshot.exists ? userSnapshot.data() : null;
                  final Equipment? targetEquipment =
                      targetEquipmentSnapshot.exists
                          ? targetEquipmentSnapshot.data()
                          : null;
                  final Equipment? gemEquipment =
                      gemEquipmentSnapshot.exists
                          ? gemEquipmentSnapshot.data()
                          : null;

                  if ((user != null) &&
                      (targetEquipment != null) &&
                      (gemEquipment != null)) {
                    if (targetEquipment.mounted || gemEquipment.mounted) {
                      return TransactionResponse<void>.fail(
                        error: "장착중인 장비입니다",
                      );
                    } else if (socketIndex >= targetEquipment.sockets.length) {
                      return TransactionResponse<void>.fail(
                        error: "소켓 범위가 옳바르지 않습니다",
                      );
                    } else if (targetEquipment.sockets[socketIndex].gearId ==
                        null) {
                      return TransactionResponse<void>.fail(
                        error: "Unlock이 필요한 소켓입니다",
                      );
                    } else {
                      transaction.delete(gemEquipmentReference);

                      transaction.update(targetEquipmentReference, {
                        "sockets":
                            (List.of(targetEquipment.sockets)
                              ..[socketIndex] = Socket(
                                gearId: gemPack.gear.gearId,
                                getExp: (gemPack.gear.getExp ?? 0),
                                staminaUse: (gemPack.gear.staminaUse ?? 0),
                                listeningEp: (gemPack.gear.listeningEp ?? 0),
                                listeningSsp: (gemPack.gear.listeningSsp ?? 0),
                              )).map((e) => e.toJson()).toList(),
                      });

                      return TransactionResponse<void>.success();
                    }
                  } else {
                    return TransactionResponse<void>.fail(
                      error: "유저 정보를 가져올 수 없습니다",
                    );
                  }
                });

            if (response.error == null) {
              emit(state.copyWith(result: ""));
            } else {
              emit(state.copyWith(result: response.error));
            }
          }
        },
        onTick: (event) {
          switch (state.status) {
            case InsettingGemModalStatus.insetting:
              if (state.elapsedDuration < maximumElapsedDuration) {
                emit(
                  state.copyWith(
                    elapsedDuration: (state.elapsedDuration + tickDuration),
                  ),
                );
              } else {
                if (state.result == null) {
                  // exceed maximumElapsedDuration, but api call not completed
                } else if (state.result == "") {
                  // success
                  emit(state.copyWith(status: InsettingGemModalStatus.success));
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: InsettingGemModalStatus.fail,
                      elapsedDuration: 0,
                    ),
                  );
                }
              }
              break;

            default:
              break;
          }
        },
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
