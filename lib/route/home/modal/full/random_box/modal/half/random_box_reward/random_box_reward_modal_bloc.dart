import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/draw.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app_common/app/misc/utils.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'random_box_reward_modal_event.dart';
part 'random_box_reward_modal_state.dart';
part 'random_box_reward_modal_bloc.freezed.dart';

class RandomBoxRewardModalBloc
    extends Bloc<RandomBoxRewardModalEvent, RandomBoxRewardModalState> {
  Timer? _timer;
  final DrawId drawId;
  final List<Equipment> results;

  RandomBoxRewardModalBloc({required this.drawId, required this.results})
    : super(const RandomBoxRewardModalState()) {
    on<RandomBoxRewardModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const RandomBoxRewardModalEvent.onTick()),
          );

          final DocumentReference<CustomUser> userReference = FirebaseFirestore
              .instance
              .collection("users")
              .doc(App.instance.auth.customUser?.id)
              .withConverter(
                fromFirestore: CustomUser.fromFirstore,
                toFirestore: CustomUser.toFirestore,
              );

          final bool success = await FirebaseFirestore.instance.runTransaction<
            bool
          >((transaction) async {
            final DocumentSnapshot<CustomUser> snapshot = await transaction
                .get<CustomUser>(userReference);

            final CustomUser? user = snapshot.exists ? snapshot.data() : null;

            if (user != null) {
              switch (drawId) {
                case DrawId.freeRadio:
                case DrawId.freeLg:
                  if (user.canOpenRandomBox) {
                    final DateTime now = koreaNow();

                    transaction.update(userReference, {
                      "nextRandomBoxAt": Timestamp.fromDate(
                        DateTime(now.year, now.month, now.day + 1),
                      ),
                    });
                  } else {
                    return false;
                  }
                  break;

                case DrawId.staminaRadio:
                case DrawId.staminaLg:
                  if (user.consumedStamina >=
                      App
                          .instance
                          .reserved
                          .global
                          .configuration
                          .staminaBoxRequirement) {
                    transaction.update(userReference, {"consumedStamina": 0});
                  } else {
                    return false;
                  }
                  break;

                case DrawId.sspRadio:
                case DrawId.sspLg:
                  if (user.radioSsp >=
                      App
                          .instance
                          .reserved
                          .global
                          .configuration
                          .sspBoxRequirement) {
                    transaction.update(userReference, {
                      "radioSsp":
                          (user.radioSsp -
                                  App
                                      .instance
                                      .reserved
                                      .global
                                      .configuration
                                      .sspBoxRequirement)
                              .clamp2(),
                    });
                  } else {
                    return false;
                  }
                  break;

                case DrawId.epBox:
                  if (user.ep >=
                      App
                          .instance
                          .reserved
                          .global
                          .configuration
                          .epBoxRequirement) {
                    transaction.update(userReference, {
                      "ep":
                          (user.ep -
                                  App
                                      .instance
                                      .reserved
                                      .global
                                      .configuration
                                      .epBoxRequirement)
                              .clamp2(),
                    });
                  } else {
                    return false;
                  }
                  break;

                default:
                  return false;
              }

              results.forEachIndexed(
                (index, element) => transaction.set(
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.id)
                      .collection("equipments")
                      .doc(),
                  element.toJson()..remove("id"),
                ),
              );

              return true;
            } else {
              return false;
            }
          });

          emit(state.copyWith(result: success ? "" : "Error"));
        },
        onTick: (event) {
          switch (state.status) {
            case RandomBoxRewardModalStatus.processing:
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
                  emit(
                    state.copyWith(status: RandomBoxRewardModalStatus.success),
                  );
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: RandomBoxRewardModalStatus.fail,
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
