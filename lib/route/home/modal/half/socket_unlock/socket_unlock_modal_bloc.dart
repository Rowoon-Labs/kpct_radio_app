import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/transaction_response.dart';
import 'package:kpct_radio_app/model/unlock.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'socket_unlock_modal_event.dart';
part 'socket_unlock_modal_state.dart';
part 'socket_unlock_modal_bloc.freezed.dart';

class SocketUnlockModalBloc
    extends Bloc<SocketUnlockModalEvent, SocketUnlockModalState> {
  Timer? _timer;
  final Unlock unlock;
  final Pack pack;

  SocketUnlockModalBloc({required this.unlock, required this.pack})
    : super(const SocketUnlockModalState()) {
    on<SocketUnlockModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const SocketUnlockModalEvent.onTick()),
          );

          emit(state.copyWith(initialized: true));
        },
        unlockPressed: (event) async {
          if (state.status == SocketUnlockModalStatus.prepare) {
            emit(
              state.copyWith(
                status: SocketUnlockModalStatus.unlocking,
                elapsedDuration: 0,
              ),
            );

            final DocumentReference<CustomUser> userReference =
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(App.instance.auth.customUser?.id)
                    .withConverter(
                      fromFirestore: CustomUser.fromFirstore,
                      toFirestore: CustomUser.toFirestore,
                    );
            final DocumentReference<Equipment> equipmentReference =
                userReference
                    .collection("equipments")
                    .doc(pack.id)
                    .withConverter(
                      fromFirestore: Equipment.fromFirstore,
                      toFirestore: Equipment.toFirestore,
                    );

            final TransactionResponse<void> response = await FirebaseFirestore
                .instance
                .runTransaction<TransactionResponse<void>>((transaction) async {
                  final DocumentSnapshot<CustomUser> userSnapshot =
                      await transaction.get<CustomUser>(userReference);
                  final DocumentSnapshot<Equipment> equipmentSnapshot =
                      await transaction.get<Equipment>(equipmentReference);

                  final CustomUser? user =
                      userSnapshot.exists ? userSnapshot.data() : null;
                  final Equipment? equipment =
                      equipmentSnapshot.exists
                          ? equipmentSnapshot.data()
                          : null;

                  if ((user != null) && (equipment != null)) {
                    if (equipment.mounted) {
                      return TransactionResponse<void>.fail(
                        error: "장착중인 장비입니다",
                      );
                    } else if (equipment.sockets.isEmpty) {
                      return TransactionResponse<void>.fail(
                        error: "소켓이 없는 장비입니다",
                      );
                    } else if (equipment.sockets.firstWhereOrNull(
                          (element) => (element.gearId == null),
                        ) ==
                        null) {
                      return TransactionResponse<void>.fail(
                        error: "모든 소켓이 Unlock된 장비입니다",
                      );
                    } else {
                      final int indexOfSocket = equipment.sockets.indexWhere(
                        (element) => (element.gearId == null),
                      );

                      if ((indexOfSocket < unlock.sspCosts.length) &&
                          (indexOfSocket < unlock.epCosts.length) &&
                          (indexOfSocket < unlock.probabilities.length)) {
                        final int sspCost = unlock.sspCosts[indexOfSocket];
                        final int epCost = unlock.epCosts[indexOfSocket];
                        final int probability =
                            unlock.probabilities[indexOfSocket];

                        if (user.radioSsp < sspCost) {
                          return TransactionResponse<void>.fail(
                            error: "SSP가 부족합니다",
                          );
                        } else if (user.ep < epCost) {
                          return TransactionResponse<void>.fail(
                            error: "EP가 부족합니다",
                          );
                        } else {
                          transaction.update(userReference, {
                            "radioSsp": (user.radioSsp - sspCost).clamp2(),
                            "ep": (user.ep - epCost).clamp2(),
                          });

                          if (user.inAdjustedLuckRange(
                            App.instance.reserved.global.luck,
                            probability,
                          )) {
                            transaction.update(equipmentReference, {
                              "sockets": (List.of(equipment.sockets)
                                ..[indexOfSocket] = const Socket(
                                  gearId: "",
                                  getExp: 0,
                                  staminaUse: 0,
                                  listeningEp: 0,
                                  listeningSsp: 0,
                                )).map((e) => e.toJson()),
                            });

                            return TransactionResponse<void>.success();
                          } else {
                            return TransactionResponse<void>.fail(
                              error: "소켓 언락 실패",
                            );
                          }
                        }
                      } else {
                        return TransactionResponse<void>.fail(error: "오류");
                      }
                    }
                  } else {
                    return TransactionResponse<void>.fail(
                      error: "유저 정보를 가져올 수 없습니다",
                    );
                  }
                })
                .catchError((error) {
                  return TransactionResponse<void>.fail(error: "소켓 언락 실패");
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
            case SocketUnlockModalStatus.unlocking:
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
                  emit(state.copyWith(status: SocketUnlockModalStatus.success));
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: SocketUnlockModalStatus.fail,
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
