import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'listening_pod_event.dart';
part 'listening_pod_state.dart';
part 'listening_pod_bloc.freezed.dart';

class ListeningPodBloc extends Bloc<ListeningPodEvent, ListeningPodState> {
  ListeningPodBloc() : super(const ListeningPodState()) {
    on<ListeningPodEvent>((event, emit) async {
      event.map(
        onTapUpRandomBoxButton: (event) {
          emit(state.copyWith(
            randomBoxButtonPressed: false,
          ));
        },
        onTapCancelRandomBoxButton: (event) {
          emit(state.copyWith(
            randomBoxButtonPressed: false,
          ));
        },
        onTapDownRandomBoxButton: (event) {
          emit(state.copyWith(
            randomBoxButtonPressed: true,
          ));
        },
        onTapUpListeningRewardButton: (event) {
          emit(state.copyWith(
            listeningRewardButtonPressed: false,
          ));
        },
        onTapCancelListeningRewardButton: (event) {
          emit(state.copyWith(
            listeningRewardButtonPressed: false,
          ));
        },
        onTapDownListeningRewardButton: (event) {
          emit(state.copyWith(
            listeningRewardButtonPressed: true,
          ));
        },
      );
    });
  }
}
