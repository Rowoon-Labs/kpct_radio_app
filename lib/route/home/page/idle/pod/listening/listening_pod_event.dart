part of 'listening_pod_bloc.dart';

@freezed
class ListeningPodEvent with _$ListeningPodEvent {
  const factory ListeningPodEvent.onTapCancelRandomBoxButton() =
      _onTapCancelRandomBoxButton;
  const factory ListeningPodEvent.onTapUpRandomBoxButton() =
      _onTapUpRandomBoxButton;
  const factory ListeningPodEvent.onTapDownRandomBoxButton() =
      _onTapDownRandomBoxButton;

  const factory ListeningPodEvent.onTapCancelListeningRewardButton() =
      _onTapCancelListeningRewardButton;
  const factory ListeningPodEvent.onTapUpListeningRewardButton() =
      _onTapUpListeningRewardButton;
  const factory ListeningPodEvent.onTapDownListeningRewardButton() =
      _onTapDownListeningRewardButton;
}
