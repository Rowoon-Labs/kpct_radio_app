part of 'socket_unlock_modal_bloc.dart';

@freezed
class SocketUnlockModalEvent with _$SocketUnlockModalEvent {
  const factory SocketUnlockModalEvent.initialize() = _initialize;

  const factory SocketUnlockModalEvent.unlockPressed({
    required String gearId,
    required String unlockId,
    required String equipmentId,
  }) = _craftPressed;

  const factory SocketUnlockModalEvent.onTick() = _onTick;
}
