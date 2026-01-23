part of 'listening_reward_modal_bloc.dart';

enum ListeningRewardModalStatus {
  processing,
  success,
  fail,
}

@freezed
class ListeningRewardModalState with _$ListeningRewardModalState {
  const factory ListeningRewardModalState({
    @Default(false) bool initialized,
    @Default(ListeningRewardModalStatus.processing)
    ListeningRewardModalStatus status,
    @Default(null) String? result,

    // reward
    @Default(0) int rewardSsp,
    @Default(0) int rewardEp,
  }) = _ListeningRewardModalState;
}
