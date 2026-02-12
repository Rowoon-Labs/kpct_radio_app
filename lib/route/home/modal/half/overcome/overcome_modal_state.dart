part of 'overcome_modal_bloc.dart';

enum OvercomeModalStatus {
  prepare,
  processing,
  success,
  fail,
}

extension OvercomeModalStatusExtension on OvercomeModalStatus {
  String get title {
    switch (this) {
      case OvercomeModalStatus.prepare:
        return "한계돌파";

      case OvercomeModalStatus.processing:
        return "한계돌파 진행중";

      case OvercomeModalStatus.success:
        return "한계돌파 성공";

      case OvercomeModalStatus.fail:
        return "한계돌파 실패";
    }
  }

  String get result {
    switch (this) {
      case OvercomeModalStatus.success:
        return "이제 레벨업이 가능합니다.";

      case OvercomeModalStatus.fail:
        return "경험치가 리셋됩니다.";

      case OvercomeModalStatus.prepare:
      case OvercomeModalStatus.processing:
      default:
        return "";
    }
  }
}

@freezed
class OvercomeModalState with _$OvercomeModalState {
  const factory OvercomeModalState({
    @Default(false) bool initialized,
    @Default(0) int elapsedDuration,
    @Default(OvercomeModalStatus.prepare) OvercomeModalStatus status,
    @Default(null) String? result,
  }) = _OvercomeModalState;
}
