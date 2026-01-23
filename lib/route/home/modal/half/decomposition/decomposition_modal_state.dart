part of 'decomposition_modal_bloc.dart';

enum DecompositionModalStatus {
  prepare,
  decomposing,
  success,
  fail,
}

extension DecompositionModalStatusExtension on DecompositionModalStatus {
  String get title {
    switch (this) {
      case DecompositionModalStatus.prepare:
        return "분해";

      case DecompositionModalStatus.decomposing:
        return "분해중";

      case DecompositionModalStatus.success:
        return "분해완료";

      case DecompositionModalStatus.fail:
        return "분해실패";
    }
  }
}

@freezed
class DecompositionModalState with _$DecompositionModalState {
  const factory DecompositionModalState({
    @Default(false) bool initialized,
    @Default(0) int elapsedDuration,
    @Default(DecompositionModalStatus.prepare) DecompositionModalStatus status,
    @Default(null) String? result,
    @Default([]) List<String> results,
  }) = _DecompositionModalState;
}
