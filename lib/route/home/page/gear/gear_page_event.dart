part of 'gear_page_bloc.dart';

@freezed
class GearPageEvent with _$GearPageEvent {
  const factory GearPageEvent.initialize() = _initialize;

  const factory GearPageEvent.tabPressed({
    required GearCategory gearCategory,
  }) = _tabPressed;

  const factory GearPageEvent.gemPressed({
    required Pack pack,
  }) = _gemPressed;

  const factory GearPageEvent.elementPressed({
    required Pack pack,
  }) = _elementPressed;

  const factory GearPageEvent.onPacksChanges({
    required List<Pack> packs,
  }) = _onKitsChanges;

  const factory GearPageEvent.socketPressed({
    required int index,
  }) = _socketPressed;

  const factory GearPageEvent.releaseSocket() = _releaseSocket;

  const factory GearPageEvent.install({
    required String equipmentId,
  }) = _mount;

  const factory GearPageEvent.uninstall({
    required String equipmentId,
  }) = _unmount;
}
