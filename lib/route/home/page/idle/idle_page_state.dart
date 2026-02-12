part of 'idle_page_bloc.dart';

// extension PlayerStateExtension on PlayerState {
//   bool get active => (this == PlayerState.playing) || (this == PlayerState.paused) || (this == PlayerState.cued);
// }
//
// @freezed
// class CustomPlayerState with _$CustomPlayerState {
//   const factory CustomPlayerState({
//     @Default(false) bool muted,
//     @Default(PlayerState.unStarted) PlayerState value,
//     @Default(Duration.zero) Duration currentPosition,
//     @Default(Duration.zero) Duration videoDuration,
//     @Default(Duration.zero) Duration elapsedDuration,
//   }) = _CustomPlayerState;
// }

@freezed
class IdlePageState with _$IdlePageState {
  const factory IdlePageState({
    @Default(false) bool initialized,
  }) = _IdlePageState;
}
