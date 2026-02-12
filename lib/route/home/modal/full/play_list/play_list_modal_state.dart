part of 'play_list_modal_bloc.dart';

@freezed
class PlayListModalState with _$PlayListModalState {
  const factory PlayListModalState({
    @Default([]) List<PlayList> playLists,
    @Default(null) PlayList? selectedPlayList,
    @Default(null) Video? selectedVideo,
  }) = _PlayListModalState;
}
