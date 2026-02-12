part of 'insetting_gem_modal_bloc.dart';

@freezed
class InsettingGemModalEvent with _$InsettingGemModalEvent {
  const factory InsettingGemModalEvent.initialize() = _initialize;

  const factory InsettingGemModalEvent.insettingPressed({
    @Default(false) bool immediately,
  }) = _insettingPressed;

  const factory InsettingGemModalEvent.onTick() = _onTick;
}
