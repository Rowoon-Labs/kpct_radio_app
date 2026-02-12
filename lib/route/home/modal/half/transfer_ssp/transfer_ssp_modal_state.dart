part of 'transfer_ssp_modal_bloc.dart';

enum TransferSspModalStatus {
  prepare,
  processing,
  success,
  fail,
}

extension TransferSspModalStatusExtension on TransferSspModalStatus {
  String get result {
    switch (this) {
      case TransferSspModalStatus.success:
        return "성공";

      case TransferSspModalStatus.fail:
        return "실패";

      default:
        return "";
    }
  }
}

@freezed
class TransferSspModalState with _$TransferSspModalState {
  const factory TransferSspModalState({
    @Default(0) int elapsedDuration,
    @Default(TransferSspModalStatus.prepare) TransferSspModalStatus status,
    @Default(null) String? result,
  }) = _TransferSspModalState;
}
