part of 'socket_unlock_modal_bloc.dart';

enum SocketUnlockModalStatus {
  prepare,
  unlocking,
  success,
  fail,
}

extension SocketUnlockModalStatusExtension on SocketUnlockModalStatus {
  String get result {
    switch (this) {
      case SocketUnlockModalStatus.success:
        return "성공";

      case SocketUnlockModalStatus.fail:
        return "실패";

      default:
        return "";
    }
  }
}

@freezed
class SocketUnlockModalState with _$SocketUnlockModalState {
  const factory SocketUnlockModalState({
    @Default(false) bool initialized,
    @Default(0) int elapsedDuration,
    @Default(SocketUnlockModalStatus.prepare) SocketUnlockModalStatus status,
    @Default(null) String? result,
  }) = _SocketUnlockModalState;
}
