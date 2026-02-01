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
      youtubePlayerController = YoutubePlayerController.fromVideoId(
        videoId: 'ScMzIvxBSi4',
        autoPlay: true, // 자동 재생
        params: const YoutubePlayerParams(
          loop: false,
          mute: false, // 소리 켬
          showControls: false, // 컨트롤 숨김 (원래 설정)
          enableCaption: false,
          enableKeyboard: false,
          showFullscreenButton: false,
          showVideoAnnotations: false,
          enableJavaScript: true,
          playsInline: true,
          pointerEvents: PointerEvents.none, // 원래 설정
          // iOS WKWebView Error 150/152 해결: youtube-nocookie.com 사용
          origin: 'https://www.youtube-nocookie.com',
        ),
      ),
      super(const HomeState()) {
    on<_signOut>((event, emit) {
      App.instance.overlay.cover(on: true);

      App.instance.auth.signOut().then((value) {
        // 성공(null)이든 실패(에러 메시지)든 스피너를 꺼야 합니다.
        App.instance.overlay.cover(on: false, message: value);
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

    on<_initialize>((event, emit) async {
      emit(state.copyWith(status: HomeStatus.normal));

      _youtubeVideoStateChanges = youtubePlayerController.videoStateStream
          .listen((event) {
            if (_dropAbnormalFrame) {
              _dropAbnormalFrame = false;
            } else {
              add(
                HomeEvent.videoStateChanges(
                  position: event.position,
                  loadedFraction: event.loadedFraction,
                ),
              );
            }
          });

      _youtubePlayerValueChanges = youtubePlayerController.listen((event) {
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
        unawaited(App.instance.auth.sync());

        App.instance.log.d("Selecting video: ${event.video!.id}");
        await youtubePlayerController
            .loadVideoById(videoId: event.video!.id, startSeconds: 0)
            .then((value) async {
              App.instance.log.d("_selectVideo success: ${event.video!.id}");
              emit(
                state.copyWith(
                  selectedPlayList: event.playList,
                  selectedVideo: event.video,
                  customPlayerState: state.customPlayerState.copyWith(
                    currentPosition: Duration.zero,
                    elapsedDuration: Duration.zero,
                  ),
                ),
              );
            })
            .catchError((error) {
              App.instance.log.e("Error loading video: $error");
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

        final Duration sinceLastTickDuration;
        final Duration temporalSinceLastTickDuration =
            state.sinceLastTickDuration + deltaDuration;

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
          final currentPlayList = state.selectedPlayList;
          final currentVideo = state.selectedVideo;
          final allPlayLists = App.instance.reserved.playLists;

          if (currentPlayList != null &&
              currentVideo != null &&
              allPlayLists.isNotEmpty) {
            final videos = currentPlayList.videos;
            final currentVideoIndex = videos.indexWhere(
              (v) => v.id == currentVideo.id,
            );

            PlayList? nextPlayList;
            Video? nextVideo;

            if (currentVideoIndex != -1 &&
                currentVideoIndex + 1 < videos.length) {
              nextPlayList = currentPlayList;
              nextVideo = videos[currentVideoIndex + 1];
            } else {
              final currentPlayListIndex = allPlayLists.indexWhere(
                (p) => p.id == currentPlayList.id,
              );
              final nextPlayListIndex =
                  (currentPlayListIndex + 1) % allPlayLists.length;
              nextPlayList = allPlayLists[nextPlayListIndex];
              nextVideo =
                  nextPlayList.videos.isNotEmpty
                      ? nextPlayList.videos.first
                      : null;
            }

            if (nextPlayList != null && nextVideo != null) {
              unawaited(App.instance.auth.sync());

              App.instance.log.d("Auto-playing next video: ${nextVideo.id}");
              await youtubePlayerController
                  .loadVideoById(videoId: nextVideo.id, startSeconds: 0)
                  .then((value) {
                    emit(
                      state.copyWith(
                        selectedPlayList: nextPlayList,
                        selectedVideo: nextVideo,
                        customPlayerState: state.customPlayerState.copyWith(
                          currentPosition: Duration.zero,
                          elapsedDuration: Duration.zero,
                          value: PlayerState.playing,
                        ),
                      ),
                    );
                  })
                  .catchError((error) {
                    App.instance.log.e("Error auto-playing next video: $error");
                  });
              return;
            }
          }

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
    });

    on<_tryPlayVideo>((event, emit) async {
      if (App.instance.auth.canPlay) {
        await youtubePlayerController.playVideo();
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
    _youtubeVideoStateChanges?.cancel();
    _youtubePlayerValueChanges?.cancel();
    _appLifecycleListener?.dispose();
    return super.close();
  }
}
