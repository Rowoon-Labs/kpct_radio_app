part of 'workbench_modal_bloc.dart';

@freezed
class WorkbenchModalEvent with _$WorkbenchModalEvent {
  const factory WorkbenchModalEvent.initialize() = _initialize;

  const factory WorkbenchModalEvent.craftPressed({
    required String gearId,
    required List<String> equipmentIds,
  }) = _craftPressed;

  const factory WorkbenchModalEvent.onTick() = _onTick;

  const factory WorkbenchModalEvent.onEquipmentsChanges({
    required List<Equipment> equipments,
  }) = _onEquipmentsChanges;
}
