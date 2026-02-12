part of 'level_up_modal_bloc.dart';

@freezed
class LevelUpModalEvent with _$LevelUpModalEvent {
  const factory LevelUpModalEvent.initialize() = _initialize;

  const factory LevelUpModalEvent.process({
    required int nextLevel,
  }) = _process;

  const factory LevelUpModalEvent.onTick() = _onTick;
}
