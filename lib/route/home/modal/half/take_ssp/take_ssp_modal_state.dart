part of 'take_ssp_modal_bloc.dart';

enum TakeSspModalStatus {
  prepare,
  processing,
  success,
  fail,
}

extension TakeSspModalStatusExtension on TakeSspModalStatus {
  String get result {
    switch (this) {
      case TakeSspModalStatus.success:
        return "성공";

      case TakeSspModalStatus.fail:
        return "실패";

      default:
        return "";
    }
  }
}

@freezed
class TakeSspModalState with _$TakeSspModalState {
  const factory TakeSspModalState({
    @Default(0) int elapsedDuration,
    @Default(0) int amount,
    @Default(TakeSspModalStatus.prepare) TakeSspModalStatus status,
    @Default(null) String? result,
  }) = _TakeSspModalState;
}
