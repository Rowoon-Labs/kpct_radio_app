part of 'level_up_modal_bloc.dart';

enum LevelUpModalStatus {
  prepare,
  processing,
  success,
  fail,
}

extension LevelUpModalStatusExtension on LevelUpModalStatus {
  String get result {
    switch (this) {
      case LevelUpModalStatus.success:
        return "성공";

      case LevelUpModalStatus.fail:
        return "실패";

      default:
        return "";
    }
  }
}

@freezed
class LevelUpModalState with _$LevelUpModalState {
  const factory LevelUpModalState({
    @Default(false) bool initialized,
    @Default(0) int elapsedDuration,
    @Default(LevelUpModalStatus.prepare) LevelUpModalStatus status,
    @Default(null) String? result,
  }) = _LevelUpModalState;
}
