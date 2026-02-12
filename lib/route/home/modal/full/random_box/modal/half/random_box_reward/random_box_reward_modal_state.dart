part of 'random_box_reward_modal_bloc.dart';

enum RandomBoxRewardModalStatus {
  prepare,
  processing,
  success,
  fail,
}

@freezed
class RandomBoxRewardModalState with _$RandomBoxRewardModalState {
  const factory RandomBoxRewardModalState({
    @Default(0) int elapsedDuration,
    @Default(RandomBoxRewardModalStatus.processing)
    RandomBoxRewardModalStatus status,
    @Default(null) String? result,
  }) = _RandomBoxRewardModalState;
}
