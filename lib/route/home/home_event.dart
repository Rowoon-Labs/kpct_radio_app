part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initialize() = _initialize;

  const factory HomeEvent.signOut() = _signOut;

  const factory HomeEvent.switchPage({
    required BuildContext context,
    required HomePage page,
  }) = _switchPage;

  const factory HomeEvent.selectVideo({
    required BuildContext context,
    required PlayList? playList,
    required Video? video,
  }) = _selectVideo;

  const factory HomeEvent.videoStateChanges({
    required Duration position,
    required double loadedFraction,
  }) = _videoStateChanges;

  const factory HomeEvent.playerValueChanges({
    required bool hasError,
    required YoutubeError error,
    required FullScreenOption fullScreenOption,
    required PlayerState playerState,
    required YoutubeMetaData metaData,
    required String? playbackQuality,
    required double playbackRate,
  }) = _playerValueChanges;

  const factory HomeEvent.tryPlayVideo({
    String? videoId,
  }) = _tryPlayVideo;

  const factory HomeEvent.toggleMute() = _toggleMute;
  const factory HomeEvent.togglePlay() = _togglePlay;

  const factory HomeEvent.onResume() = _onResume;
  const factory HomeEvent.onPause() = _onPause;
}
