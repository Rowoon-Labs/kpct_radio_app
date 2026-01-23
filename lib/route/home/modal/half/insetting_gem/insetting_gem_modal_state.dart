part of 'insetting_gem_modal_bloc.dart';

enum InsettingGemModalStatus {
  prepare,
  insetting,
  success,
  fail,
}

extension InsettingGemModalStatusExtension on InsettingGemModalStatus {
  String get title {
    switch (this) {
      case InsettingGemModalStatus.prepare:
        return "GEM";

      case InsettingGemModalStatus.insetting:
        return "GEM";

      case InsettingGemModalStatus.success:
        return "삽입성공";

      case InsettingGemModalStatus.fail:
        return "삽입실패";
    }
  }
}

@freezed
class InsettingGemModalState with _$InsettingGemModalState {
  const factory InsettingGemModalState({
    @Default(false) bool initialized,
    @Default(0) int elapsedDuration,
    @Default(InsettingGemModalStatus.prepare) InsettingGemModalStatus status,
    @Default(null) String? result,
  }) = _InsettingGemModalState;
}
