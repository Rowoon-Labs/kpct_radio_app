import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/route/home/home_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/full/play_list/play_list_modal.dart';
import 'package:kpct_radio_app/route/home/page/idle/pod/item_slot/item_slot_pod.dart';
import 'package:kpct_radio_app/route/home/page/idle/pod/listening/listening_pod.dart';
import 'package:kpct_radio_app/route/home/page/idle/pod/user_info/user_info_pod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IdlePage extends StatefulWidget {
  const IdlePage({super.key});

  @override
  State<StatefulWidget> createState() => _IdlePageState();
}

class _IdlePageState extends State<IdlePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _IdlePage();
  }
}

class _IdlePage extends StatelessWidget {
  const _IdlePage();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: KpctAspectRatio(
      designWidth: designWidth,
      designHeight: 689.37,
      builder:
          (converter) => Stack(
            children: [
              _buildPod(
                top: 0,
                context: context,
                converter: converter,
                child: const UserInfoPod(),
              ),
              _buildPod(
                top: 85.24,
                context: context,
                converter: converter,
                child: KpctAspectRatio(
                  designWidth: designWidth,
                  designHeight: 272.92,
                  builder:
                      (converter) => Stack(
                        children: [
                          PositionedDirectional(
                            top: converter.h(5.76),
                            start: 0,
                            end: 0,
                            height: converter.h(227.53),
                            child: BlocBuilder<HomeBloc, HomeState>(
                              buildWhen:
                                  (previous, current) =>
                                      (previous.customPlayerState !=
                                          current.customPlayerState),
                              builder:
                                  (context, state) => AnimatedOpacity(
                                    duration: defaultAnimationDuration,
                                    curve: defaultAnimationCurve,
                                    opacity:
                                        state.customPlayerState.value.active
                                            ? 1
                                            : 0.1,
                                    child: Stack(
                                      children: [
                                        if (state.selectedPlayList?.thumbnail !=
                                            null) ...[
                                          CachedNetworkImage(
                                            key: const ValueKey<String>(
                                              "hasProfileImage",
                                            ),
                                            imageUrl:
                                                state
                                                    .selectedPlayList
                                                    ?.thumbnail ??
                                                "",
                                            width: converter.realSize.width,
                                            height: converter.realSize.height,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                        PositionedDirectional(
                                          top: converter.h(199),
                                          start: converter.hcx(350),
                                          width: converter.w(350),
                                          height: converter.h(2),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD9D9D9),
                                              borderRadius: BorderRadius.all(
                                                converter.radius(10),
                                              ),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.centerLeft,
                                              children: [
                                                AnimatedPositionedDirectional(
                                                  duration:
                                                      defaultAnimationDuration,
                                                  curve: defaultAnimationCurve,
                                                  start: 0,
                                                  top: 0,
                                                  bottom: 0,
                                                  width:
                                                      (state
                                                                  .customPlayerState
                                                                  .videoDuration ==
                                                              Duration.zero)
                                                          ? 0
                                                          : converter.w(
                                                            350 *
                                                                (state
                                                                        .customPlayerState
                                                                        .currentPosition
                                                                        .inMilliseconds /
                                                                    state
                                                                        .customPlayerState
                                                                        .videoDuration
                                                                        .inMilliseconds),
                                                          ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFFFF656E,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            converter.radius(
                                                              10,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ),
                          ),
                          Assets.component.playerPod.image(
                            width: converter.realSize.width,
                            height: converter.realSize.height,
                            fit: BoxFit.cover,
                          ),
                          PositionedDirectional(
                            top: converter.h(5.76),
                            start: 0,
                            end: 0,
                            height: converter.h(227.53),
                            child: BlocBuilder<HomeBloc, HomeState>(
                              buildWhen:
                                  (previous, current) =>
                                      (previous.customPlayerState !=
                                          current.customPlayerState),
                              builder:
                                  (context, state) => AnimatedOpacity(
                                    duration: defaultAnimationDuration,
                                    curve: defaultAnimationCurve,
                                    opacity:
                                        state.customPlayerState.value.active
                                            ? 1
                                            : 0,
                                    child: Stack(
                                      children: [
                                        PositionedDirectional(
                                          bottom: converter.h(0),
                                          start: converter.w(12.5),
                                          width: converter.w(26.5),
                                          height: converter.h(26.5),
                                          child: KpctSwitcher(
                                            builder: () {
                                              if (state
                                                  .customPlayerState
                                                  .value
                                                  .active) {
                                                return KpctSwitcher(
                                                  key: ValueKey<bool>(
                                                    state
                                                        .customPlayerState
                                                        .value
                                                        .active,
                                                  ),
                                                  builder:
                                                      () => IconButton(
                                                        key: ValueKey<
                                                          PlayerState
                                                        >(
                                                          state
                                                              .customPlayerState
                                                              .value,
                                                        ),
                                                        onPressed:
                                                            () => context
                                                                .read<
                                                                  HomeBloc
                                                                >()
                                                                .add(
                                                                  const HomeEvent.togglePlay(),
                                                                ),
                                                        iconSize: converter
                                                            .average(19),
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        color: Colors.white,
                                                        icon: Icon(
                                                          (state
                                                                      .customPlayerState
                                                                      .value ==
                                                                  PlayerState
                                                                      .playing)
                                                              ? Icons
                                                                  .pause_rounded
                                                              : Icons
                                                                  .play_arrow_rounded,
                                                        ),
                                                      ),
                                                );
                                              } else {
                                                return SizedBox(
                                                  key: ValueKey<bool>(
                                                    state
                                                        .customPlayerState
                                                        .value
                                                        .active,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        PositionedDirectional(
                                          bottom: converter.h(0),
                                          start: converter.w(12.5 + 26.5 + 8),
                                          width: converter.w(26.5),
                                          height: converter.h(26.5),
                                          child: KpctSwitcher(
                                            builder: () {
                                              if (state
                                                  .customPlayerState
                                                  .value
                                                  .active) {
                                                return KpctSwitcher(
                                                  builder:
                                                      () => IconButton(
                                                        key: ValueKey<bool>(
                                                          state
                                                              .customPlayerState
                                                              .muted,
                                                        ),
                                                        onPressed:
                                                            () => context
                                                                .read<
                                                                  HomeBloc
                                                                >()
                                                                .add(
                                                                  const HomeEvent.toggleMute(),
                                                                ),
                                                        iconSize: converter
                                                            .average(19),
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        color: Colors.white,
                                                        icon: Icon(
                                                          state
                                                                  .customPlayerState
                                                                  .muted
                                                              ? Icons
                                                                  .volume_off_rounded
                                                              : Icons
                                                                  .volume_up_rounded,
                                                        ),
                                                      ),
                                                );
                                              } else {
                                                return SizedBox(
                                                  key: ValueKey<bool>(
                                                    state
                                                        .customPlayerState
                                                        .value
                                                        .active,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ),
                          ),
                          // Center(
                          //   child: BlocBuilder<HomeBloc, HomeState>(
                          //     buildWhen: (previous, current) => (previous.customPlayerState != current.customPlayerState),
                          //     builder: (context, state) => Text(
                          //       // state.customPlayerState.elapsedDuration.toString(),
                          //       "${state.customPlayerState.currentPosition}\n\n${state.customPlayerState.elapsedDuration}",
                          //       style: GoogleFonts.inter(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                ),
              ),
              _buildPod(
                top: 358.15,
                context: context,
                converter: converter,
                child: const ItemSlotPod(),
              ),
              _buildPod(
                top: 465.26,
                context: context,
                converter: converter,
                child: const ListeningPod(),
              ),
              _buildPod(
                top: 601.61,
                context: context,
                converter: converter,
                // child: const PlayListPod(),
                child: KpctAspectRatio(
                  designWidth: designWidth,
                  designHeight: 87.76,
                  builder:
                      (converter) => Stack(
                        children: [
                          Assets.component.playListPod.image(
                            width: converter.realSize.width,
                            height: converter.realSize.height,
                            fit: BoxFit.cover,
                          ),
                          PositionedDirectional(
                            top: converter.h(10),
                            end: converter.w(42),
                            child: BlocBuilder<HomeBloc, HomeState>(
                              buildWhen:
                                  (previous, current) =>
                                      (previous.selectedPlayList !=
                                          current.selectedPlayList) ||
                                      (previous.selectedVideo !=
                                          current.selectedVideo),
                              builder:
                                  (context, state) => KpctCupertinoButton(
                                    onPressed:
                                        () async =>
                                            await showMaterialModalBottomSheet(
                                              context: context,
                                              enableDrag: false,
                                              isDismissible: false,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder:
                                                  (context) => PlayListModal(
                                                    selectedPlayList:
                                                        state.selectedPlayList,
                                                    selectedVideo:
                                                        state.selectedVideo,
                                                  ),
                                            ).then((value) {
                                              if ((value != null) &&
                                                  (value
                                                      is PlayListModalResponse)) {
                                                context.read<HomeBloc>().add(
                                                  HomeEvent.selectVideo(
                                                    playList:
                                                        value.selectedPlayList,
                                                    video: value.selectedVideo,
                                                    context: context,
                                                  ),
                                                );
                                              }
                                            }),
                                    child: Assets.component.playListPodButton
                                        .image(
                                          width: converter.w(50),
                                          height: converter.h(52.69),
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ],
          ),
    ),
  );

  Widget _buildPod({
    required double top,
    required Widget child,
    required BuildContext context,
    required KpctConverter converter,
  }) => PositionedDirectional(
    top: converter.h(top),
    start: 0,
    end: 0,
    child: child,
  );
}
