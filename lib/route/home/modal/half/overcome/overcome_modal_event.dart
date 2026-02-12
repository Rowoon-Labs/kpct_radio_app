part of 'overcome_modal_bloc.dart';

@freezed
class OvercomeModalEvent with _$OvercomeModalEvent {
  const factory OvercomeModalEvent.initialize() = _initialize;

  const factory OvercomeModalEvent.process({
    required int nextLevel,
  }) = _process;

  const factory OvercomeModalEvent.onTick() = _onTick;
}
