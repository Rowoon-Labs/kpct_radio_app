part of 'transfer_ssp_modal_bloc.dart';

@freezed
class TransferSspModalEvent with _$TransferSspModalEvent {
  const factory TransferSspModalEvent.initialize() = _initialize;

  const factory TransferSspModalEvent.action() = _action;

  const factory TransferSspModalEvent.onTick() = _onTick;
}
