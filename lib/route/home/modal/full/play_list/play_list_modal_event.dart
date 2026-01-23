part of 'play_list_modal_bloc.dart';

@freezed
class PlayListModalEvent with _$PlayListModalEvent {
  const factory PlayListModalEvent.onPlayListPressed({
    required PlayList playList,
  }) = _onPlayListPressed;
}
