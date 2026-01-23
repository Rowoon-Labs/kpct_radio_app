part of 'crafting_page_bloc.dart';

@freezed
class CraftingPageEvent with _$CraftingPageEvent {
  const factory CraftingPageEvent.initialize() = _initialize;

  const factory CraftingPageEvent.tabPressed({
    required GearCategory gearCategory,
  }) = _tabPressed;

  const factory CraftingPageEvent.elementPressed({
    required Kit kit,
  }) = _elementPressed;

  const factory CraftingPageEvent.craftPressed() = _craftPressed;

  const factory CraftingPageEvent.onKitsChanges({
    required List<Kit> kits,
  }) = _onPacksChanges;
}
