part of 'chat_modal_bloc.dart';

@freezed
class ChatModalEvent with _$ChatModalEvent {
  const factory ChatModalEvent.initialize() = _initialize;

  const factory ChatModalEvent.load({
    Completer<void>? completer,
  }) = _load;

  const factory ChatModalEvent.onChanged({
    required String value,
  }) = _onChanged;

  const factory ChatModalEvent.send() = _send;

  const factory ChatModalEvent.receive({
    required Chat value,
  }) = _receive;
}
