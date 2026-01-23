import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app_common/models/remote/play_list.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late bool _dropAbnormalFrame;

  final YoutubePlayerController youtubePlayerController;

  AppLifecycleListener? _appLifecycleListener;
  StreamSubscription<YoutubeVideoState>? _youtubeVideoStateChanges;
  StreamSubscription<YoutubePlayerValue>? _youtubePlayerValueChanges;

  HomeBloc()
    : _dropAbnormalFrame = true,
      youtubePlayerController = YoutubePlayerController(
        params: const YoutubePlayerParams(
          loop: false,
          mute: false,
          showControls: false,
          enableCaption: false,
          enableKeyboard: false,
          showFullscreenButton: false,
          showVideoAnnotations: false,
          enableJavaScript: true,
          playsInline: true,
          pointerEvents: PointerEvents.none,
        ),
      ),
      super(const HomeState()) {
    on<_signOut>((event, emit) {
      App.instance.overlay.cover(on: true);

      App.instance.auth.signOut().then((value) {
        if (value != null) {
          App.instance.overlay.cover(on: false, message: value);
        }
      });
    });
    on<_switchPage>((event, emit) {
      if (state.page != event.page) {
        DefaultTabController.of(
          event.context,
        ).animateTo(HomePage.values.indexOf(event.page));

        emit(state.copyWith(page: event.page));
      }
    });

    on<_initialize>((event, emit) {
      emit(state.copyWith(status: HomeStatus.normal));

      _youtubeVideoStateChanges = youtubePlayerController.videoStateStream.listen((
        event,
      ) {
        // App.instance.log.d("State : " + event.position.toString() + " / " + event.loadedFraction.toString() + " / " + _dropAbnormalFrame.toString());

        // 첫 프레임보다, 두번째 프레임보다 position이 크기때문에 앱 최초 실행시 첫 프레임은 버려야함
        // 근데 그 이후에는 rewind 돼든 곡을 바꾸든 해당 문제는 발생하지 않으니 상관 업음
        if (_dropAbnormalFrame) {
          _dropAbnormalFrame = false;
        } else {
          add(
            HomeEvent.videoStateChanges(
              position: event.position,
              loadedFraction: event.loadedFraction,
            ),
          );
          // App.instance.log.d(event.position.toString() + " / " + event.loadedFraction.toString());
        }
      });

      // _youtubePlayerValueChanges = youtubePlayerController.stream.listen((event) {
      _youtubePlayerValueChanges = youtubePlayerController.listen((event) {
        // App.instance.log.d("Value : " + event.playerState.toString() + " / " + event.metaData.toString() + " / " + event.error.toString() + " / "  + event.hasError.toString());

        add(
          HomeEvent.playerValueChanges(
            playerState: event.playerState,
            metaData: event.metaData,
            hasError: event.hasError,
            error: event.error,
            fullScreenOption: event.fullScreenOption,
            playbackQuality: event.playbackQuality,
            playbackRate: event.playbackRate,
          ),
        );
      });

      _appLifecycleListener = AppLifecycleListener(
        onPause: () => add(const HomeEvent.onPause()),
        onResume: () => add(const HomeEvent.onResume()),
      );
    });
    on<_selectVideo>((event, emit) async {
      if ((event.playList != null) &&
          (event.video != null) &&
          (event.video?.id != null) &&
          (event.video != state.selectedVideo)) {
        await youtubePlayerController
            .cueVideoById(videoId: event.video!.id, startSeconds: 0)
            .then((value) async {
              App.instance.log.d("_selectVideo");
              emit(
                state.copyWith(
                  selectedPlayList: event.playList,
                  selectedVideo: event.video,
                ),
              );
            })
            .catchError((error) {
              App.instance.log.d(error);
            });
      }
    });
    on<_videoStateChanges>((event, emit) {
      final Video? selectedVideo = state.selectedVideo;

      if ((selectedVideo != null) &&
          (state.customPlayerState.value == PlayerState.playing) &&
          (event.position >= state.customPlayerState.currentPosition)) {
        final Duration deltaDuration =
            (event.position - state.customPlayerState.currentPosition);

        ///
        /// TICK
        ///
        final Duration sinceLastTickDuration;
        final Duration temporalSinceLastTickDuration =
            state.sinceLastTickDuration + deltaDuration;

        // App.instance.log.d("TICK ${event.position} / ${state.customPlayerState.currentPosition} / ${state.sinceLastTickDuration} / $deltaDuration");

        if (temporalSinceLastTickDuration <
            App.instance.reserved.global.configuration.tickSeconds) {
          sinceLastTickDuration = temporalSinceLastTickDuration;
        } else {
          sinceLastTickDuration =
              temporalSinceLastTickDuration -
              App.instance.reserved.global.configuration.tickSeconds;

          if (!App.instance.auth.tick) {
            unawaited(youtubePlayerController.pauseVideo());
          }
        }

        emit(
          state.copyWith(
            customPlayerState: state.customPlayerState.copyWith(
              elapsedDuration:
                  state.customPlayerState.elapsedDuration + deltaDuration,
              currentPosition: event.position,
            ),
            sinceLastTickDuration: sinceLastTickDuration,
          ),
        );
      }
    });
    on<_playerValueChanges>((event, emit) async {
      switch (event.playerState) {
        case PlayerState.cued:
        case PlayerState.ended:
          emit(
            state.copyWith(
              customPlayerState: state.customPlayerState.copyWith(
                currentPosition: Duration.zero,
                value: event.playerState,
              ),
            ),
          );

          add(const HomeEvent.tryPlayVideo());
          break;

        case PlayerState.unStarted:
        case PlayerState.paused:
        case PlayerState.unknown:
        case PlayerState.buffering:
          emit(
            state.copyWith(
              customPlayerState: state.customPlayerState.copyWith(
                value: event.playerState,
              ),
            ),
          );
          break;

        case PlayerState.playing:
          if ((state.customPlayerState.value == PlayerState.buffering) &&
              (event.metaData.videoId == state.selectedVideo?.id)) {
            emit(
              state.copyWith(
                customPlayerState: state.customPlayerState.copyWith(
                  videoDuration: event.metaData.duration,
                  value: event.playerState,
                ),
              ),
            );
          }
          break;
      }

      // switch (event.playerState) {
      //
      //   case PlayerState.unStarted:
      //     // App.instance.log.d(event.playerState);
      //     emit(state.copyWith(
      //       customPlayerState: state.customPlayerState.copyWith(
      //         // status: CustomPlayerStatus.idle,
      //         currentPosition: Duration.zero,
      //       ),
      //     ));
      //     break;
      //
      //   case PlayerState.cued:
      //     // App.instance.log.d("${event.playerState}");
      //     emit(state.copyWith(
      //       customPlayerState: state.customPlayerState.copyWith(
      //         status: CustomPlayerStatus.idle,
      //       ),
      //     ));
      //     add(const HomeEvent.tryPlayVideo());
      //     break;
      //
      //   case PlayerState.playing:
      //     // App.instance.log.d("${event.playerState} ${event.error} ${event.hasError} ${event.metaData.duration} ${event.metaData.videoId}");
      //
      //     if (event.hasError) {
      //       // App.instance.log.d("${event.playerState} - error : ${event.error}");
      //       emit(state.copyWith(
      //         customPlayerState: state.customPlayerState.copyWith(
      //           status: CustomPlayerStatus.idle,
      //           currentPosition: Duration.zero,
      //         ),
      //       ));
      //     } else {
      //
      //       final String videoId = event.metaData.videoId.trim();
      //       final Duration videoDuration = event.metaData.duration;
      //
      //       if (videoId.isNotEmpty && (videoDuration > Duration.zero)) {
      //
      //         emit(state.copyWith(
      //           customPlayerState: state.customPlayerState.copyWith(
      //             status: CustomPlayerStatus.playing,
      //             videoDuration: videoDuration,
      //           ),
      //         ));
      //
      //         // if (state.customPlayerState.status != CustomPlayerStatus.playing) {
      //         //   // if (state.customPlayerState.status == CustomPlayerStatus.idle) {
      //         //   App.instance.log.d("${event.playerState}");
      //         //   emit(state.copyWith(
      //         //     customPlayerState: state.customPlayerState.copyWith(
      //         //       status: CustomPlayerStatus.playing,
      //         //       videoDuration: videoDuration,
      //         //     ),
      //         //   ));
      //         // } else {
      //         //   emit(state.copyWith(
      //         //     customPlayerState: state.customPlayerState.copyWith(
      //         //       status: CustomPlayerStatus.idle,
      //         //       currentPosition: Duration.zero,
      //         //     ),
      //         //   ));
      //         // }
      //       } else {
      //         emit(state.copyWith(
      //           customPlayerState: state.customPlayerState.copyWith(
      //             status: CustomPlayerStatus.idle,
      //             currentPosition: Duration.zero,
      //           ),
      //         ));
      //       }
      //     }
      //     break;
      //
      //   case PlayerState.ended:
      //     // App.instance.log.d(event.playerState);
      //     emit(state.copyWith(
      //       customPlayerState: state.customPlayerState.copyWith(
      //         // status: CustomPlayerStatus.idle,
      //         currentPosition: Duration.zero,
      //       ),
      //     ));
      //
      //     if (event.playerState == PlayerState.ended) {
      //       add(const HomeEvent.tryPlayVideo());
      //       // await youtubePlayerController.seekTo(seconds: 0, allowSeekAhead: true);
      //     }
      //     break;
      //
      //   case PlayerState.paused:
      //     // App.instance.log.d(event.playerState);
      //     emit(state.copyWith(
      //       customPlayerState: state.customPlayerState.copyWith(
      //         status: CustomPlayerStatus.paused,
      //       ),
      //     ));
      //     break;
      //   default:
      //   // nop
      //   // App.instance.log.d("${event.playerState}");
      //     break;
      // }
    });

    on<_tryPlayVideo>((event, emit) async {
      if (App.instance.auth.canPlay) {
        await youtubePlayerController.playVideo();
        // if (event.videoId != null) {
        //
        //   await youtubePlayerController.loadVideoById(
        //     videoId: event.videoId ?? "",
        //   ).then((value) {
        //
        //   }).catchError((error) {
        //     App.instance.log.d(error);
        //   });
        // } else {
        //
        //   await youtubePlayerController.playVideo();
        // }
      }
    });
    on<_togglePlay>((event, emit) async {
      switch (state.customPlayerState.value) {
        case PlayerState.paused:
        case PlayerState.cued:
          add(const HomeEvent.tryPlayVideo());
          break;

        case PlayerState.playing:
          await youtubePlayerController.pauseVideo();
          break;

        default:
          break;
      }
    });
    on<_toggleMute>((event, emit) async {
      if (state.customPlayerState.muted) {
        await youtubePlayerController.unMute().then((value) {
          emit(
            state.copyWith(
              customPlayerState: state.customPlayerState.copyWith(muted: false),
            ),
          );
        });
      } else {
        await youtubePlayerController.mute().then((value) {
          emit(
            state.copyWith(
              customPlayerState: state.customPlayerState.copyWith(muted: true),
            ),
          );
        });
      }
    });
    on<_onResume>((event, emit) {});
    on<_onPause>((event, emit) {});
  }

  @override
  Future<void> close() {
    _youtubePlayerValueChanges?.cancel();
    _youtubeVideoStateChanges?.cancel();
    _appLifecycleListener?.dispose();
    return super.close();
  }
}
