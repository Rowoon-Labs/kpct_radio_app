part of 'gear_page_bloc.dart';

@freezed
class GearPageState with _$GearPageState {
  const factory GearPageState({
    @Default(GearCategory.radioSkin) GearCategory selectedGearCategory,
    @Default(null) int? selectedSocketIndex,
    @Default(null) Pack? selectedGemPack,
    @Default(null) Pack? selectedPack,
    @Default([]) List<Pack> packs,
  }) = _GearPageState;
}
