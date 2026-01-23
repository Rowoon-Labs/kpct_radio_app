part of 'decomposition_modal_bloc.dart';

@freezed
class DecompositionModalEvent with _$DecompositionModalEvent {
  const factory DecompositionModalEvent.initialize() = _initialize;

  const factory DecompositionModalEvent.decompositionPressed({
    required String equipmentId,
    required String decompositionId,
  }) = _decompositionPressed;

  const factory DecompositionModalEvent.onTick() = _onTick;
}
