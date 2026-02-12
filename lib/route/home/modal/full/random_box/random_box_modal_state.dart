part of 'random_box_modal_bloc.dart';

@freezed
class RandomBoxModalState with _$RandomBoxModalState {
  const factory RandomBoxModalState({
    @Default(false) bool initialized,
  }) = _RandomBoxModalState;
}
