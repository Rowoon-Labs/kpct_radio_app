import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app_common/models/remote/play_list.dart';

part 'play_list_modal_event.dart';
part 'play_list_modal_state.dart';
part 'play_list_modal_bloc.freezed.dart';

class PlayListModalBloc extends Bloc<PlayListModalEvent, PlayListModalState> {
  final ScrollController scrollController;

  static List<PlayList> _initialPlayLists({
    required PlayList? selectedPlayList,
  }) {
    if (selectedPlayList != null) {
      final List<PlayList> playLists = List.of(App.instance.reserved.playLists);

      final int index = playLists.indexWhere(
        (element) => (element.id == selectedPlayList.id),
      );

      if (index != -1) {
        playLists.insert(0, playLists.removeAt(index));
      }

      return playLists;
    } else {
      return List.of(App.instance.reserved.playLists);
    }
  }

  PlayListModalBloc({
    required PlayList? selectedPlayList,
    required Video? selectedVideo,
  }) : scrollController = ScrollController(),
       super(
         PlayListModalState(
           playLists: _initialPlayLists(selectedPlayList: selectedPlayList),
           selectedPlayList: selectedPlayList,
           selectedVideo: selectedVideo,
         ),
       ) {
    on<PlayListModalEvent>((event, emit) async {
      await event.map(
        onPlayListPressed: (event) async {
          if (event.playList.id != state.selectedPlayList?.id) {
            emit(
              state.copyWith(
                playLists:
                    List.of(state.playLists)
                      ..removeWhere(
                        (element) => (element.id == event.playList.id),
                      )
                      ..insert(0, event.playList),
                selectedPlayList: event.playList,
                selectedVideo: null,
              ),
            );
          } else {
            emit(state.copyWith(selectedPlayList: null, selectedVideo: null));
          }
        },
      );
    });
  }
}
