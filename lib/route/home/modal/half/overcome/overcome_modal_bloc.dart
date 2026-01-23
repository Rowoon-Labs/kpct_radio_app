import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/level.dart';
import 'package:kpct_radio_app/model/transaction_response.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';

part 'overcome_modal_event.dart';
part 'overcome_modal_state.dart';
part 'overcome_modal_bloc.freezed.dart';

class OvercomeModalBloc extends Bloc<OvercomeModalEvent, OvercomeModalState> {
  Timer? _timer;

  final Level currentLevel;
  final Level nextLevel;

  OvercomeModalBloc({required this.currentLevel, required this.nextLevel})
    : super(const OvercomeModalState()) {
    on<OvercomeModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const OvercomeModalEvent.onTick()),
          );

          emit(state.copyWith(initialized: true));
        },
        process: (event) async {
          if (state.status == OvercomeModalStatus.prepare) {
            emit(
              state.copyWith(
                status: OvercomeModalStatus.processing,
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

            final TransactionResponse<void>
            response = await FirebaseFirestore.instance.runTransaction<
              TransactionResponse<void>
            >((transaction) async {
              final DocumentSnapshot<CustomUser> snapshot = await transaction
                  .get<CustomUser>(userReference);

              final CustomUser? user = snapshot.exists ? snapshot.data() : null;

              if (user != null) {
                if (user.exp < user.maxExp) {
                  return TransactionResponse<void>.fail(error: "EXP가 부족 합니다");
                } else if (user.radioSsp < nextLevel.limitSsp) {
                  return TransactionResponse<void>.fail(error: "SSP가 부족 합니다");
                } else if (user.ep < nextLevel.limitEp) {
                  return TransactionResponse<void>.fail(error: "EP가 부족 합니다");
                } else if (user.accumulatedPlayDuration <
                    nextLevel.condition1) {
                  return TransactionResponse<void>.fail(error: "플레이타임이 부족 합니다");
                } else {
                  if (user.inAdjustedLuckRange(
                    App.instance.reserved.global.luck,
                    nextLevel.limitProbability,
                  )) {
                    transaction.update(userReference, {
                      "radioSsp": (user.radioSsp - nextLevel.limitSsp).clamp2(),
                      "ep": (user.ep - nextLevel.limitEp).clamp2(),
                      "overcomeLevels": FieldValue.arrayUnion([
                        nextLevel.level,
                      ]),
                    });

                    return TransactionResponse<void>.success();
                  } else {
                    transaction.update(userReference, {
                      "radioSsp": (user.radioSsp - nextLevel.limitSsp).clamp2(),
                      "ep": (user.ep - nextLevel.limitEp).clamp2(),
                      "exp": currentLevel.exp,
                    });

                    return TransactionResponse<void>.fail(error: "경험치가 리셋됩니다.");
                  }
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
            case OvercomeModalStatus.processing:
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
                  emit(state.copyWith(status: OvercomeModalStatus.success));
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: OvercomeModalStatus.fail,
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
