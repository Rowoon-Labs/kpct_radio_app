part of 'listening_pod_bloc.dart';

@freezed
class ListeningPodState with _$ListeningPodState {
  const factory ListeningPodState({
    @Default(false) randomBoxButtonPressed,
    @Default(false) listeningRewardButtonPressed,
  }) = _ListeningPodState;
}
