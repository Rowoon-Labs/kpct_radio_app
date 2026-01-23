part of 'random_box_reward_modal_bloc.dart';

@freezed
class RandomBoxRewardModalEvent with _$RandomBoxRewardModalEvent {
  const factory RandomBoxRewardModalEvent.initialize() = _initialize;

  const factory RandomBoxRewardModalEvent.onTick() = _onTick;
}
