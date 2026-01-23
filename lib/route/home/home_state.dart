part of 'home_bloc.dart';

enum HomePage {
  idle,
  status,
  gear,
  crafting,
  shop,
  chat,
}

enum HomeStatus {
  initializing,
  abnormal,
  normal,
}

extension PlayerStateExtension on PlayerState {
  bool get active =>
      (this == PlayerState.playing) ||
      (this == PlayerState.paused) ||
      (this == PlayerState.cued);
}

@freezed
class CustomPlayerState with _$CustomPlayerState {
  const factory CustomPlayerState({
    @Default(false) bool muted,
    @Default(PlayerState.unStarted) PlayerState value,
    @Default(Duration.zero) Duration currentPosition,
    @Default(Duration.zero) Duration videoDuration,
    @Default(Duration.zero) Duration elapsedDuration,
  }) = _CustomPlayerState;
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initializing) HomeStatus status,
    @Default(HomePage.idle) HomePage page,
    @Default(null) PlayList? selectedPlayList,
    @Default(null) Video? selectedVideo,
    @Default(CustomPlayerState()) CustomPlayerState customPlayerState,
    @Default(Duration.zero) Duration sinceLastTickDuration,
    // @Default(Duration.zero) Duration sinceLastSyncDuration,
  }) = _HomeState;
}
