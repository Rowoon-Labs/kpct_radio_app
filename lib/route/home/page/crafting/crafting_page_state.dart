part of 'crafting_page_bloc.dart';

@freezed
class CraftingPageState with _$CraftingPageState {
  const factory CraftingPageState({
    @Default(GearCategory.radioSkin) GearCategory selectedGearCategory,
    @Default(null) Kit? selectedKit,
    @Default([]) List<Kit> kits,
  }) = _CraftingPageState;
}
