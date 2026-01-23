part of 'chat_modal_bloc.dart';

@freezed
class ChatModalState with _$ChatModalState {
  const factory ChatModalState({
    @Default(false) bool initialized,
    @Default("") String input,
    @Default(true) bool hasMore,
    @Default(false) bool loading,
    @Default([]) List<Chat> chats,
  }) = _ChatModalState;
}
