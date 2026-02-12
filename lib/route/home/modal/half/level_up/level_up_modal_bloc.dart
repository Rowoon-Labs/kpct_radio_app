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

part 'level_up_modal_event.dart';
part 'level_up_modal_state.dart';
part 'level_up_modal_bloc.freezed.dart';

class LevelUpModalBloc extends Bloc<LevelUpModalEvent, LevelUpModalState> {
  Timer? _timer;

  final Level currentLevel;
  final Level nextLevel;

  LevelUpModalBloc({required this.currentLevel, required this.nextLevel})
    : super(const LevelUpModalState()) {
    on<LevelUpModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const LevelUpModalEvent.onTick()),
          );

          emit(state.copyWith(initialized: true));
        },
        process: (event) async {
          if (state.status == LevelUpModalStatus.prepare) {
            emit(
              state.copyWith(
                status: LevelUpModalStatus.processing,
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
                } else if (user.radioSsp < nextLevel.costSsp) {
                  return TransactionResponse<void>.fail(error: "SSP가 부족 합니다");
                } else if (user.ep < nextLevel.costEp) {
                  return TransactionResponse<void>.fail(error: "EP가 부족 합니다");
                } else {
                  transaction.update(userReference, {
                    "level": nextLevel.level,
                    "stamina": nextLevel.stamina,
                    "maxStamina": nextLevel.stamina,
                    "exp": (user.exp - user.maxExp).clamp2(),
                    "maxExp": nextLevel.exp,
                    "accumulatedRadioSsp": FieldValue.increment(
                      nextLevel.rewardSsp,
                    ),
                    "accumulatedEp": FieldValue.increment(nextLevel.rewardEp),
                    "radioSsp":
                        (user.radioSsp -
                                nextLevel.costSsp +
                                nextLevel.rewardSsp)
                            .clamp2(),
                    "ep":
                        (user.ep - nextLevel.costEp + nextLevel.rewardEp)
                            .clamp2(),
                  });
                }

                return TransactionResponse<void>.success();
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
            case LevelUpModalStatus.processing:
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
                  emit(state.copyWith(status: LevelUpModalStatus.success));
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: LevelUpModalStatus.fail,
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
