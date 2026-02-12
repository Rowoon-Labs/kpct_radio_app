import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/route/home/modal/full/play_list/play_list_modal_bloc.dart';
import 'package:kpct_radio_app_common/models/remote/play_list.dart';

class PlayListModalResponse {
  final PlayList? selectedPlayList;
  final Video? selectedVideo;

  PlayListModalResponse({
    required this.selectedPlayList,
    required this.selectedVideo,
  });
}

class PlayListModal extends StatelessWidget {
  final PlayList? _selectedPlayList;
  final Video? _selectedVideo;

  const PlayListModal({
    required PlayList? selectedPlayList,
    required Video? selectedVideo,
    super.key,
  }) : _selectedPlayList = selectedPlayList,
       _selectedVideo = selectedVideo;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) => PlayListModalBloc(
          selectedPlayList: _selectedPlayList,
          selectedVideo: _selectedVideo,
        ),
    child: SafeArea(
      child: LayoutBuilder(
        builder:
            (context, constraints) => Stack(
              children: [
                Assets.background.common.image(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    KpctAspectRatio(
                      designWidth: designWidth,
                      designHeight: 44,
                      builder:
                          (converter) => Stack(
                            children: [
                              PositionedDirectional(
                                top: converter.h(6),
                                start: converter.w(5),
                                width: converter.w(126),
                                height: converter.h(21),
                                child: Assets.component.consoleTypeTitlePlayList
                                    .image(
                                      width: converter.w(126),
                                      height: converter.h(21),
                                      // fit: BoxFit.cover,
                                    ),
                              ),
                              PositionedDirectional(
                                top: converter.h(2),
                                end: converter.w(6.49),
                                width: converter.w(30.51),
                                height: converter.h(30),
                                child: KpctCupertinoButton(
                                  onPressed: () => Navigator.pop(context),
                                  alignment: Alignment.topCenter,
                                  child: Assets.component.closeButton.image(
                                    width: converter.w(30.51),
                                    height: converter.h(30),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),
                    Expanded(
                      child: BlocBuilder<PlayListModalBloc, PlayListModalState>(
                        buildWhen:
                            (previous, current) =>
                                (previous.playLists != current.playLists) ||
                                (previous.selectedPlayList !=
                                    current.selectedPlayList) ||
                                (previous.selectedVideo !=
                                    current.selectedVideo),
                        builder:
                            (context, state) => KpctSwitcher(
                              builder: () {
                                if (state.playLists.isNotEmpty) {
                                  return ListView.separated(
                                    controller:
                                        context
                                            .read<PlayListModalBloc>()
                                            .scrollController,
                                    itemCount: state.playLists.length,
                                    separatorBuilder:
                                        (context, index) => const KpctSeparator(
                                          designWidth: designWidth,
                                          designHeight: 2,
                                        ),
                                    itemBuilder:
                                        (
                                          context,
                                          playListIndex,
                                        ) => AnimatedSize(
                                          key: ValueKey<int>(playListIndex),
                                          duration: defaultAnimationDuration,
                                          curve: defaultAnimationCurve,
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            children: [
                                              KpctCupertinoButton.solid(
                                                pressedOpacity: 1,
                                                onPressed: () {
                                                  context.read<PlayListModalBloc>().add(
                                                    PlayListModalEvent.onPlayListPressed(
                                                      playList:
                                                          state
                                                              .playLists[playListIndex],
                                                    ),
                                                  );
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback(
                                                        (timeStamp) => context
                                                            .read<
                                                              PlayListModalBloc
                                                            >()
                                                            .scrollController
                                                            .animateTo(
                                                              0,
                                                              duration:
                                                                  defaultAnimationDuration,
                                                              curve:
                                                                  defaultAnimationCurve,
                                                            ),
                                                      );
                                                },
                                                child: KpctAspectRatio(
                                                  designWidth: designWidth,
                                                  designHeight: 82.92,
                                                  builder:
                                                      (converter) => Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  converter.w(
                                                                    7,
                                                                  ),
                                                            ),
                                                        child: Stack(
                                                          children: [
                                                            Assets
                                                                .component
                                                                .playListModalTile
                                                                .image(
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            360,
                                                                          ),
                                                                  height:
                                                                      converter.h(
                                                                        82.92,
                                                                      ),
                                                                ),
                                                            PositionedDirectional(
                                                              top: converter.h(
                                                                10,
                                                              ),
                                                              start: converter
                                                                  .w(14),
                                                              width: converter
                                                                  .w(53),
                                                              height: converter
                                                                  .h(52),
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                    state
                                                                        .playLists[playListIndex]
                                                                        .thumbnail,
                                                                width: converter
                                                                    .w(53),
                                                                height:
                                                                    converter.h(
                                                                      52,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                              ),
                                                            ),
                                                            PositionedDirectional(
                                                              top: converter.h(
                                                                15,
                                                              ),
                                                              start: converter
                                                                  .w(82),
                                                              end: converter.w(
                                                                24,
                                                              ),
                                                              height: converter
                                                                  .h(19),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .centerLeft,
                                                                child: Text(
                                                                  state
                                                                      .playLists[playListIndex]
                                                                      .title,
                                                                  maxLines: 1,
                                                                  softWrap:
                                                                      false,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style: GoogleFonts.inter(
                                                                    letterSpacing:
                                                                        0,
                                                                    color: const Color(
                                                                      0xFF02D7FF,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeightAlias
                                                                            .semiBold,
                                                                    fontSize:
                                                                        converter
                                                                            .h(
                                                                              16,
                                                                            ),
                                                                    height: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            PositionedDirectional(
                                                              top: converter.h(
                                                                42.15,
                                                              ),
                                                              start: converter
                                                                  .w(89),
                                                              height: converter
                                                                  .h(12),
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                      bottom:
                                                                          converter.h(
                                                                            1,
                                                                          ),
                                                                    ),
                                                                    child: Assets
                                                                        .icon
                                                                        .clock
                                                                        .image(
                                                                          width:
                                                                              converter.w(
                                                                                9,
                                                                              ),
                                                                          height:
                                                                              converter.h(
                                                                                9,
                                                                              ),
                                                                        ),
                                                                  ),
                                                                  VerticalDivider(
                                                                    color:
                                                                        Colors
                                                                            .transparent,
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              1,
                                                                            ),
                                                                    thickness:
                                                                        0,
                                                                  ),
                                                                  Text(
                                                                    " ${state.playLists[playListIndex].totalDuration.formatHMS(separator: ":")}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: GoogleFonts.inter(
                                                                      letterSpacing:
                                                                          0,
                                                                      color: const Color(
                                                                        0xFF00B2E0,
                                                                      ),
                                                                      fontWeight:
                                                                          FontWeightAlias
                                                                              .regular,
                                                                      fontSize:
                                                                          converter.h(
                                                                            10,
                                                                          ),
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            PositionedDirectional(
                                                              top: converter.h(
                                                                42,
                                                              ),
                                                              end: converter.w(
                                                                26,
                                                              ),
                                                              height: converter
                                                                  .h(12),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Assets.icon.note.image(
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              10,
                                                                            ),
                                                                    height:
                                                                        converter
                                                                            .h(
                                                                              10,
                                                                            ),
                                                                  ),
                                                                  VerticalDivider(
                                                                    color:
                                                                        Colors
                                                                            .transparent,
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              1,
                                                                            ),
                                                                    thickness:
                                                                        0,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                        .playLists[playListIndex]
                                                                        .videos
                                                                        .length
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: GoogleFonts.inter(
                                                                      letterSpacing:
                                                                          0,
                                                                      color: const Color(
                                                                        0xFF00B2E0,
                                                                      ),
                                                                      fontWeight:
                                                                          FontWeightAlias
                                                                              .regular,
                                                                      fontSize:
                                                                          converter.h(
                                                                            10,
                                                                          ),
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                ),
                                              ),
                                              if (state.selectedPlayList?.id ==
                                                  state
                                                      .playLists[playListIndex]
                                                      .id) ...[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        KpctConverter.aboutScreenWidth(
                                                          designWidth:
                                                              designWidth,
                                                          designHeight: 8,
                                                          context: context,
                                                        ).w(8),
                                                  ),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            KpctConverter.aboutScreenWidth(
                                                              designWidth:
                                                                  designWidth -
                                                                  16,
                                                              designHeight: 6,
                                                              context: context,
                                                            ).radius(5),
                                                          ),
                                                    ),
                                                    child: ListView.separated(
                                                      padding: EdgeInsets.symmetric(
                                                        vertical:
                                                            KpctConverter.aboutScreenWidth(
                                                              designWidth:
                                                                  designWidth -
                                                                  16,
                                                              designHeight: 6,
                                                              context: context,
                                                            ).realSize.height,
                                                      ),
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          state
                                                              .playLists[playListIndex]
                                                              .videos
                                                              .length,
                                                      itemBuilder:
                                                          (
                                                            context,
                                                            videoIndex,
                                                          ) => KpctAspectRatio(
                                                            designWidth:
                                                                designWidth -
                                                                16,
                                                            designHeight: 25,
                                                            builder:
                                                                (
                                                                  converter,
                                                                ) => Container(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        converter
                                                                            .w(
                                                                              5,
                                                                            ),
                                                                  ),
                                                                  child: WithAuth(
                                                                    builder: (
                                                                      user,
                                                                    ) {
                                                                      final List<
                                                                        Widget
                                                                      >
                                                                      children = [
                                                                        if (user.accumulatedPlayDuration <
                                                                            state.playLists[playListIndex].videos[videoIndex].limitPlayDuration) ...[
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Assets.icon.lock.image(
                                                                                width: converter.w(
                                                                                  12.67,
                                                                                ),
                                                                                height: converter.h(
                                                                                  16,
                                                                                ),
                                                                                color:
                                                                                    Colors.white,
                                                                                fit:
                                                                                    BoxFit.contain,
                                                                                alignment:
                                                                                    Alignment.center,
                                                                              ),
                                                                              VerticalDivider(
                                                                                color:
                                                                                    Colors.transparent,
                                                                                width: converter.w(
                                                                                  8.33,
                                                                                ),
                                                                                thickness:
                                                                                    0,
                                                                              ),
                                                                              Text(
                                                                                "플레이타임 ",
                                                                                style: GoogleFonts.inter(
                                                                                  letterSpacing:
                                                                                      0,
                                                                                  color:
                                                                                      Colors.white,
                                                                                  fontWeight:
                                                                                      FontWeightAlias.semiBold,
                                                                                  fontSize: converter.h(
                                                                                    10,
                                                                                  ),
                                                                                  height:
                                                                                      1,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                state.playLists[playListIndex].videos[videoIndex].limitPlayDuration.formatUnderHourSingleMax,
                                                                                style: GoogleFonts.inter(
                                                                                  letterSpacing:
                                                                                      0,
                                                                                  color:
                                                                                      Colors.white,
                                                                                  fontWeight:
                                                                                      FontWeightAlias.regular,
                                                                                  fontSize: converter.h(
                                                                                    10,
                                                                                  ),
                                                                                  height:
                                                                                      1,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                        if (user.level <
                                                                            state.playLists[playListIndex].videos[videoIndex].limitLevel) ...[
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Assets.icon.lock.image(
                                                                                width: converter.w(
                                                                                  12.67,
                                                                                ),
                                                                                height: converter.h(
                                                                                  16,
                                                                                ),
                                                                                color:
                                                                                    Colors.white,
                                                                                fit:
                                                                                    BoxFit.contain,
                                                                                alignment:
                                                                                    Alignment.center,
                                                                              ),
                                                                              VerticalDivider(
                                                                                color:
                                                                                    Colors.transparent,
                                                                                width: converter.w(
                                                                                  8.33,
                                                                                ),
                                                                                thickness:
                                                                                    0,
                                                                              ),
                                                                              Text(
                                                                                "레벨 ",
                                                                                softWrap:
                                                                                    false,
                                                                                style: GoogleFonts.inter(
                                                                                  letterSpacing:
                                                                                      0,
                                                                                  color:
                                                                                      Colors.white,
                                                                                  fontWeight:
                                                                                      FontWeightAlias.semiBold,
                                                                                  fontSize: converter.h(
                                                                                    10,
                                                                                  ),
                                                                                  height:
                                                                                      1,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "${state.playLists[playListIndex].videos[videoIndex].limitLevel}",
                                                                                style: GoogleFonts.inter(
                                                                                  letterSpacing:
                                                                                      0,
                                                                                  color:
                                                                                      Colors.white,
                                                                                  fontWeight:
                                                                                      FontWeightAlias.regular,
                                                                                  fontSize: converter.h(
                                                                                    10,
                                                                                  ),
                                                                                  height:
                                                                                      1,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ];

                                                                      return KpctCupertinoButton.solid(
                                                                        onPressed:
                                                                            children.isNotEmpty
                                                                                ? null
                                                                                : () {
                                                                                  if (state.playLists[playListIndex].videos[videoIndex].id !=
                                                                                      state.selectedVideo?.id) {
                                                                                    Navigator.pop(
                                                                                      context,
                                                                                      PlayListModalResponse(
                                                                                        selectedPlayList:
                                                                                            state.playLists[playListIndex],
                                                                                        selectedVideo:
                                                                                            state.playLists[playListIndex].videos[videoIndex],
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                        child: Stack(
                                                                          children: [
                                                                            Container(
                                                                              alignment:
                                                                                  Alignment.center,
                                                                              decoration: BoxDecoration(
                                                                                color: const Color(
                                                                                  0xFF003519,
                                                                                ),
                                                                                borderRadius: BorderRadius.all(
                                                                                  converter.radius(
                                                                                    6,
                                                                                  ),
                                                                                ),
                                                                                border: Border.all(
                                                                                  strokeAlign:
                                                                                      BorderSide.strokeAlignInside,
                                                                                  style:
                                                                                      BorderStyle.solid,
                                                                                  width: converter.h(
                                                                                    1,
                                                                                  ),
                                                                                  color:
                                                                                      (state.selectedVideo?.id ==
                                                                                              state.playLists[playListIndex].videos[videoIndex].id)
                                                                                          ? const Color(
                                                                                            0xFF06FF98,
                                                                                          )
                                                                                          : Colors.transparent,
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.only(
                                                                                left: converter.w(
                                                                                  10.75,
                                                                                ),
                                                                                right: converter.w(
                                                                                  6.84,
                                                                                ),
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    state.playLists[playListIndex].videos[videoIndex].title,
                                                                                    maxLines:
                                                                                        1,
                                                                                    softWrap:
                                                                                        false,
                                                                                    textAlign:
                                                                                        TextAlign.start,
                                                                                    overflow:
                                                                                        TextOverflow.clip,
                                                                                    style: GoogleFonts.inter(
                                                                                      letterSpacing:
                                                                                          0,
                                                                                      color: const Color(
                                                                                        0xFF13BE13,
                                                                                      ),
                                                                                      fontWeight:
                                                                                          FontWeightAlias.regular,
                                                                                      fontSize: converter.h(
                                                                                        11,
                                                                                      ),
                                                                                      height:
                                                                                          1,
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Row(
                                                                                      crossAxisAlignment:
                                                                                          CrossAxisAlignment.center,
                                                                                      mainAxisAlignment:
                                                                                          MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Text(
                                                                                          state.playLists[playListIndex].videos[videoIndex].duration.formatHMS(
                                                                                            separator:
                                                                                                ":",
                                                                                          ),
                                                                                          maxLines:
                                                                                              1,
                                                                                          textAlign:
                                                                                              TextAlign.end,
                                                                                          style: GoogleFonts.inter(
                                                                                            letterSpacing:
                                                                                                0,
                                                                                            color: const Color(
                                                                                              0xFF13BE13,
                                                                                            ),
                                                                                            fontWeight:
                                                                                                FontWeightAlias.regular,
                                                                                            fontSize: converter.h(
                                                                                              11,
                                                                                            ),
                                                                                            fontStyle:
                                                                                                FontStyle.italic,
                                                                                            height:
                                                                                                1,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            if (children.isNotEmpty) ...[
                                                                              Container(
                                                                                alignment:
                                                                                    Alignment.center,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.black.withOpacity(
                                                                                    0.56,
                                                                                  ),
                                                                                  // color: Colors.red,
                                                                                  borderRadius: BorderRadius.all(
                                                                                    converter.radius(
                                                                                      6,
                                                                                    ),
                                                                                  ),
                                                                                  border: Border.all(
                                                                                    strokeAlign:
                                                                                        BorderSide.strokeAlignInside,
                                                                                    style:
                                                                                        BorderStyle.solid,
                                                                                    width: converter.h(
                                                                                      1,
                                                                                    ),
                                                                                    color:
                                                                                        children.isNotEmpty ||
                                                                                                (state.selectedVideo?.id !=
                                                                                                    state.playLists[playListIndex].videos[videoIndex].id)
                                                                                            ? Colors.transparent
                                                                                            : const Color(
                                                                                              0xFF06FF98,
                                                                                            ),
                                                                                  ),
                                                                                ),
                                                                                padding: EdgeInsets.only(
                                                                                  left: converter.w(
                                                                                    10.75,
                                                                                  ),
                                                                                  right: converter.w(
                                                                                    6.84,
                                                                                  ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: ListView.separated(
                                                                                    itemCount:
                                                                                        children.length,
                                                                                    scrollDirection:
                                                                                        Axis.horizontal,
                                                                                    padding:
                                                                                        EdgeInsets.zero,
                                                                                    shrinkWrap:
                                                                                        true,
                                                                                    physics:
                                                                                        const NeverScrollableScrollPhysics(),
                                                                                    separatorBuilder:
                                                                                        (
                                                                                          context,
                                                                                          index,
                                                                                        ) => VerticalDivider(
                                                                                          color:
                                                                                              Colors.transparent,
                                                                                          width: converter.w(
                                                                                            42,
                                                                                          ),
                                                                                          thickness:
                                                                                              0,
                                                                                        ),
                                                                                    itemBuilder:
                                                                                        (
                                                                                          context,
                                                                                          index,
                                                                                        ) =>
                                                                                            children[index],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                          ),
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              const KpctSeparator(
                                                                designWidth:
                                                                    designWidth -
                                                                    16,
                                                                designHeight: 4,
                                                              ),
                                                      shrinkWrap: true,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                  );
                                } else {
                                  return SizedBox(
                                    key: ValueKey<bool>(
                                      state.playLists.isNotEmpty,
                                    ),
                                  );
                                }
                              },
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    ),
  );
}
