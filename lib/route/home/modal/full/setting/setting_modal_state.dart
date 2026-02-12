part of 'setting_modal_bloc.dart';

@freezed
class SettingModalState with _$SettingModalState {
  const factory SettingModalState({
    @Default(false) bool initialized,
  }) = _SettingModalState;
}
