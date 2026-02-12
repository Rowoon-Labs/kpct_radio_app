part of 'take_ssp_modal_bloc.dart';

@freezed
class TakeSspModalEvent with _$TakeSspModalEvent {
  const factory TakeSspModalEvent.initialize() = _initialize;

  const factory TakeSspModalEvent.action() = _action;

  const factory TakeSspModalEvent.onTick() = _onTick;

  const factory TakeSspModalEvent.updateAmount({
    required int value,
  }) = _updateAmount;
}
