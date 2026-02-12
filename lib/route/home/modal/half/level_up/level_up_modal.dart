import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/model/level.dart';
import 'package:kpct_radio_app/route/home/modal/half/level_up/level_up_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_misc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';

enum LevelUpModalResponse { cancel, success }

class LevelUpModal extends StatelessWidget {
  static Future<dynamic> launch({required BuildContext context}) async {
    final Level? currentLevel = App.instance.reserved.level(
      level: App.instance.auth.customUser?.level,
    );
    final Level? nextLevel = App.instance.reserved.nextLevel(
      level: App.instance.auth.customUser?.level,
    );

    if ((currentLevel != null) && (nextLevel != null)) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => LevelUpModal._(
              currentLevel: currentLevel,
              nextLevel: nextLevel,
            ),
      );
    }
  }

  final Level currentLevel;
  final Level nextLevel;

  const LevelUpModal._({required this.currentLevel, required this.nextLevel});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            LevelUpModalBloc(currentLevel: currentLevel, nextLevel: nextLevel)
              ..add(const LevelUpModalEvent.initialize()),
    child: Builder(
      builder:
          (context) => SafeArea(
            child: PopScope(
              canPop: false,
              child: Scaffold(
                backgroundColor: Colors.black.withOpacity(0.7),
                body: Center(
                  child: KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 329,
                    designPadding: const EdgeInsets.symmetric(horizontal: 11),
                    builder:
                        (
                          converter,
                        ) => BlocBuilder<LevelUpModalBloc, LevelUpModalState>(
                          buildWhen:
                              (previous, current) =>
                                  (previous.initialized != current.initialized),
                          builder:
                              (context, state) => KpctSwitcher(
                                builder: () {
                                  if (state.initialized) {
                                    return BlocBuilder<
                                      LevelUpModalBloc,
                                      LevelUpModalState
                                    >(
                                      key: ValueKey<bool>(state.initialized),
                                      buildWhen:
                                          (previous, current) =>
                                              (previous.status !=
                                                  current.status),
                                      builder:
                                          (context, state) => WithAuth(
                                            builder:
                                                (user) => Stack(
                                                  key: ValueKey<Level?>(
                                                    nextLevel,
                                                  ),
                                                  children: [
                                                    Assets.background.halfModal
                                                        .image(
                                                          width:
                                                              converter
                                                                  .realSize
                                                                  .width,
                                                          height:
                                                              converter
                                                                  .realSize
                                                                  .height,
                                                          fit: BoxFit.contain,
                                                        ),
                                                    PositionedDirectional(
                                                      start: converter.hcx(306),
                                                      top: converter.h(207),
                                                      width: converter.w(306),
                                                      height: converter.h(30),
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                    LevelUpModalStatus
                                                                        .prepare)
                                                                ? 0.5
                                                                : 0,
                                                        duration:
                                                            defaultAnimationDuration,
                                                        curve:
                                                            defaultAnimationCurve,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  converter
                                                                      .radius(
                                                                        5,
                                                                      ),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      start: converter.hcx(306),
                                                      top: converter.h(161),
                                                      width: converter.w(306),
                                                      height: converter.h(6),
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            ((state.status ==
                                                                        LevelUpModalStatus
                                                                            .processing) ||
                                                                    (state.status ==
                                                                        LevelUpModalStatus
                                                                            .fail))
                                                                ? 1
                                                                : 0,
                                                        duration:
                                                            defaultAnimationDuration,
                                                        curve:
                                                            defaultAnimationCurve,
                                                        child: Assets
                                                            .component
                                                            .modalGauge
                                                            .image(
                                                              width: converter
                                                                  .w(306),
                                                              height: converter
                                                                  .h(6),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      top: converter.h(40),
                                                      start: 0,
                                                      end: 0,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          "LEVEL UP",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.inter(
                                                            letterSpacing: 0,
                                                            fontStyle:
                                                                FontStyle
                                                                    .italic,
                                                            color: const Color(
                                                              0xFF13BE13,
                                                            ),
                                                            fontWeight:
                                                                FontWeightAlias
                                                                    .bold,
                                                            fontSize: converter
                                                                .h(20),
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      top: converter.h(56),
                                                      start: 0,
                                                      end: 0,
                                                      height: converter.h(77),
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                    LevelUpModalStatus
                                                                        .prepare)
                                                                ? 1
                                                                : 0,
                                                        duration:
                                                            defaultAnimationDuration,
                                                        curve:
                                                            defaultAnimationCurve,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          key: ValueKey<bool>(
                                                            state.status ==
                                                                LevelUpModalStatus
                                                                    .prepare,
                                                          ),
                                                          children: [
                                                            Text(
                                                              user.level
                                                                  .toString()
                                                                  .padLeft(
                                                                    2,
                                                                    "0",
                                                                  ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts.inter(
                                                                letterSpacing:
                                                                    0,
                                                                color:
                                                                    const Color(
                                                                      0xFF13ED51,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeightAlias
                                                                        .extraBold,
                                                                fontSize:
                                                                    converter.h(
                                                                      64,
                                                                    ),
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                height: 1,
                                                              ),
                                                            ),
                                                            VerticalDivider(
                                                              color:
                                                                  Colors
                                                                      .transparent,
                                                              width: converter
                                                                  .w(16),
                                                              thickness: 0,
                                                            ),
                                                            Assets.icon.forward
                                                                .image(
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            23,
                                                                          ),
                                                                  height:
                                                                      converter
                                                                          .h(
                                                                            23,
                                                                          ),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  fit:
                                                                      BoxFit
                                                                          .contain,
                                                                ),
                                                            Text(
                                                              (user.level + 1)
                                                                  .toString()
                                                                  .padLeft(
                                                                    2,
                                                                    "0",
                                                                  ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts.inter(
                                                                letterSpacing:
                                                                    0,
                                                                color:
                                                                    const Color(
                                                                      0xFF13ED51,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeightAlias
                                                                        .extraBold,
                                                                fontSize:
                                                                    converter.h(
                                                                      64,
                                                                    ),
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                height: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      top: converter.h(56),
                                                      start: 0,
                                                      end: 0,
                                                      height: converter.h(77),
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                    LevelUpModalStatus
                                                                        .success)
                                                                ? 1
                                                                : 0,
                                                        duration:
                                                            defaultAnimationDuration,
                                                        curve:
                                                            defaultAnimationCurve,
                                                        child: Center(
                                                          child: Text(
                                                            nextLevel.level
                                                                .toString()
                                                                .padLeft(
                                                                  2,
                                                                  "0",
                                                                ),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  const Color(
                                                                    0xFF13ED51,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .extraBold,
                                                              fontSize:
                                                                  converter.h(
                                                                    64,
                                                                  ),
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              height: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      start: 0,
                                                      end: 0,
                                                      top: converter.h(145),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: AnimatedOpacity(
                                                          opacity:
                                                              (state.status ==
                                                                      LevelUpModalStatus
                                                                          .success)
                                                                  ? 1
                                                                  : 0,
                                                          duration:
                                                              defaultAnimationDuration,
                                                          curve:
                                                              defaultAnimationCurve,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  left: converter
                                                                      .w(
                                                                        11 + 42,
                                                                      ),
                                                                  right: converter
                                                                      .w(
                                                                        12 + 36,
                                                                      ),
                                                                ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "스테미너 최대치",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: GoogleFonts.inter(
                                                                    letterSpacing:
                                                                        0,
                                                                    color: const Color(
                                                                      0xFF24E85B,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeightAlias
                                                                            .semiBold,
                                                                    // fontStyle: FontStyle.italic,
                                                                    fontSize:
                                                                        converter
                                                                            .h(
                                                                              9,
                                                                            ),
                                                                    height: 1,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        currentLevel
                                                                            .stamina
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts.inter(
                                                                          letterSpacing:
                                                                              0,
                                                                          color: const Color(
                                                                            0xFF24BD24,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeightAlias.medium,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontSize:
                                                                              converter.h(
                                                                                8,
                                                                              ),
                                                                          height:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      VerticalDivider(
                                                                        color:
                                                                            Colors.transparent,
                                                                        width: converter
                                                                            .w(
                                                                              9,
                                                                            ),
                                                                        thickness:
                                                                            0,
                                                                      ),
                                                                      Assets.icon.forward.image(
                                                                        width: converter
                                                                            .w(
                                                                              8,
                                                                            ),
                                                                        height:
                                                                            converter.h(
                                                                              9,
                                                                            ),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        fit:
                                                                            BoxFit.contain,
                                                                      ),
                                                                      VerticalDivider(
                                                                        color:
                                                                            Colors.transparent,
                                                                        width: converter
                                                                            .w(
                                                                              9,
                                                                            ),
                                                                        thickness:
                                                                            0,
                                                                      ),
                                                                      Text(
                                                                        nextLevel
                                                                            .stamina
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts.inter(
                                                                          letterSpacing:
                                                                              0,
                                                                          color: const Color(
                                                                            0xFF06FF98,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeightAlias.bold,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                          fontSize: converter.h(
                                                                            15,
                                                                          ),
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
                                                        ),
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      top: converter.h(183),
                                                      start: converter.w(0),
                                                      end: converter.w(0),
                                                      height: converter.h(57.5),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          final ValueKey<bool>
                                                          key = ValueKey(
                                                            state.status ==
                                                                LevelUpModalStatus
                                                                    .success,
                                                          );
                                                          if (key.value) {
                                                            final List<Widget>
                                                            children = [
                                                              if (nextLevel
                                                                      .rewardSsp >
                                                                  0) ...[
                                                                _buildReward(
                                                                  context:
                                                                      context,
                                                                  converter:
                                                                      converter,
                                                                  image:
                                                                      Assets
                                                                          .component
                                                                          .sspIcon,
                                                                  label: "SSP",
                                                                  text:
                                                                      nextLevel
                                                                          .rewardSsp
                                                                          .toString(),
                                                                ),
                                                              ],
                                                              if (nextLevel
                                                                      .rewardEp >
                                                                  0) ...[
                                                                _buildReward(
                                                                  context:
                                                                      context,
                                                                  converter:
                                                                      converter,
                                                                  image:
                                                                      Assets
                                                                          .component
                                                                          .epIcon,
                                                                  label: "EP",
                                                                  text:
                                                                      nextLevel
                                                                          .rewardEp
                                                                          .toString(),
                                                                ),
                                                              ],
                                                            ];

                                                            return Center(
                                                              key: key,
                                                              child: ListView.separated(
                                                                padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      converter
                                                                          .w(
                                                                            52.5,
                                                                          ),
                                                                ),
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                // itemCount: (state.rewardSsp > 0 ? 1 : 0) + (state.rewardEp > 0 ? 1 : 0),
                                                                itemCount:
                                                                    children
                                                                        .length,
                                                                shrinkWrap:
                                                                    true,
                                                                separatorBuilder:
                                                                    (
                                                                      context,
                                                                      index,
                                                                    ) => VerticalDivider(
                                                                      color:
                                                                          Colors
                                                                              .transparent,
                                                                      width: converter
                                                                          .w(
                                                                            48,
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
                                                            );
                                                          } else {
                                                            return SizedBox(
                                                              key: key,
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      top: converter.h(161),
                                                      start: converter.w(
                                                        11 + 35,
                                                      ),
                                                      end: converter.w(12 + 34),
                                                      height: converter.h(6),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          final ValueKey<bool>
                                                          key = ValueKey(
                                                            (state.status ==
                                                                    LevelUpModalStatus
                                                                        .processing) ||
                                                                (state.status ==
                                                                    LevelUpModalStatus
                                                                        .fail),
                                                          );
                                                          if (key.value) {
                                                            return Align(
                                                              key: key,
                                                              alignment:
                                                                  Alignment
                                                                      .centerLeft,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                      converter
                                                                          .radius(
                                                                            4,
                                                                          ),
                                                                    ),
                                                                child: DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                      begin:
                                                                          Alignment
                                                                              .centerRight,
                                                                      end:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      stops:
                                                                          const [
                                                                            0.49,
                                                                            1,
                                                                          ],
                                                                      colors: [
                                                                        const Color(
                                                                          0xFF24BD24,
                                                                        ),
                                                                        const Color(
                                                                          0xFF24E85B,
                                                                        ).withOpacity(
                                                                          0.33,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  child: BlocBuilder<
                                                                    LevelUpModalBloc,
                                                                    LevelUpModalState
                                                                  >(
                                                                    buildWhen:
                                                                        (
                                                                          previous,
                                                                          current,
                                                                        ) =>
                                                                            (previous.elapsedDuration !=
                                                                                current.elapsedDuration),
                                                                    builder:
                                                                        (
                                                                          context,
                                                                          state,
                                                                        ) => SizedBox(
                                                                          // width: converter.w(261),
                                                                          height:
                                                                              converter.h(
                                                                                6,
                                                                              ),
                                                                          width: converter.w(
                                                                            261 *
                                                                                (state.elapsedDuration /
                                                                                    maximumElapsedDuration),
                                                                          ),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            return SizedBox(
                                                              key: key,
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    // PositionedDirectional(
                                                    //   top: converter.h(172),
                                                    //   start: 0,
                                                    //   end: 0,
                                                    //   height: converter.h(18),
                                                    //   child: KpctSwitcher(
                                                    //     builder: () {
                                                    //       if (state.status == LevelUpModalStatus.prepare) {
                                                    //         return Row(
                                                    //           key: ValueKey<bool>(state.status == LevelUpModalStatus.prepare),
                                                    //           crossAxisAlignment: CrossAxisAlignment.center,
                                                    //           mainAxisAlignment: MainAxisAlignment.center,
                                                    //           children: [
                                                    //             Text(
                                                    //               "성공확률",
                                                    //               textAlign: TextAlign.center,
                                                    //               style: GoogleFonts.inter(
                                                    //                 letterSpacing: 0,
                                                    //                 color: const Color(0xFF13BE13),
                                                    //                 fontWeight: FontWeightAlias.semiBold,
                                                    //                 fontSize: converter.h(8),
                                                    //                 height: 1,
                                                    //               ),
                                                    //             ),
                                                    //             VerticalDivider(
                                                    //               color: Colors.transparent,
                                                    //               width: converter.w(97),
                                                    //               thickness: 0,
                                                    //             ),
                                                    //             Text(
                                                    //               "${next.probability}%",
                                                    //               textAlign: TextAlign.center,
                                                    //               style: GoogleFonts.inter(
                                                    //                 letterSpacing: 0,
                                                    //                 fontStyle: FontStyle.italic,
                                                    //                 color: const Color(0xFF06FF98),
                                                    //                 fontWeight: FontWeightAlias.regular,
                                                    //                 fontSize: converter.h(15),
                                                    //                 height: 1,
                                                    //               ),
                                                    //             ),
                                                    //           ],
                                                    //         );
                                                    //       } else {
                                                    //         return SizedBox(
                                                    //           key: ValueKey<bool>(state.status == LevelUpModalStatus.prepare),
                                                    //         );
                                                    //       }
                                                    //     },
                                                    //   ),
                                                    // ),
                                                    // PositionedDirectional(
                                                    //   top: converter.h(211),
                                                    //   start: 0,
                                                    //   end: 0,
                                                    //   height: converter.h(22),
                                                    //   child: KpctSwitcher(
                                                    //     builder: () {
                                                    //       if (state.status == LevelUpModalStatus.prepare) {
                                                    //         return Row(
                                                    //           key: ValueKey<bool>(state.status == LevelUpModalStatus.prepare),
                                                    //           crossAxisAlignment: CrossAxisAlignment.center,
                                                    //           mainAxisAlignment: MainAxisAlignment.center,
                                                    //           children: [
                                                    //             Assets.component.sspIcon.image(
                                                    //               width: converter.w(21),
                                                    //               height: converter.h(21),
                                                    //               fit: BoxFit.contain,
                                                    //             ),
                                                    //             VerticalDivider(
                                                    //               color: Colors.transparent,
                                                    //               width: converter.w(4.6),
                                                    //               thickness: 0,
                                                    //             ),
                                                    //             Text(
                                                    //               "${user.radioSsp}/${next.sspCost}",
                                                    //               textAlign: TextAlign.center,
                                                    //               style: GoogleFonts.inter(
                                                    //                 letterSpacing: 0,
                                                    //                 color: const Color(0xFF13ED51),
                                                    //                 fontWeight: FontWeightAlias.regular,
                                                    //                 fontSize: converter.h(12),
                                                    //                 height: 1,
                                                    //               ),
                                                    //             ),
                                                    //             VerticalDivider(
                                                    //               color: Colors.transparent,
                                                    //               width: converter.w(42),
                                                    //               thickness: 0,
                                                    //             ),
                                                    //             Assets.component.epIcon.image(
                                                    //               width: converter.w(21),
                                                    //               height: converter.h(22),
                                                    //               fit: BoxFit.contain,
                                                    //             ),
                                                    //             VerticalDivider(
                                                    //               color: Colors.transparent,
                                                    //               width: converter.w(4.6),
                                                    //               thickness: 0,
                                                    //             ),
                                                    //             Text(
                                                    //               "${user.ep}/${next.epCost}",
                                                    //               textAlign: TextAlign.center,
                                                    //               style: GoogleFonts.inter(
                                                    //                 letterSpacing: 0,
                                                    //                 color: const Color(0xFF13ED51),
                                                    //                 fontWeight: FontWeightAlias.regular,
                                                    //                 fontSize: converter.h(12),
                                                    //                 height: 1,
                                                    //               ),
                                                    //             ),
                                                    //           ],
                                                    //         );
                                                    //       } else {
                                                    //         return SizedBox(
                                                    //           key: ValueKey<bool>(state.status == LevelUpModalStatus.prepare),
                                                    //         );
                                                    //       }
                                                    //     },
                                                    //   ),
                                                    // ),
                                                    PositionedDirectional(
                                                      top: converter.h(211),
                                                      start: 0,
                                                      end: 0,
                                                      height: converter.h(22),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          if (state.status ==
                                                              LevelUpModalStatus
                                                                  .prepare) {
                                                            return Row(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    SocketUnlockModalStatus
                                                                        .prepare,
                                                              ),
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Assets.component.sspIcon.image(
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            21,
                                                                          ),
                                                                  height:
                                                                      converter
                                                                          .h(
                                                                            21,
                                                                          ),
                                                                  fit:
                                                                      BoxFit
                                                                          .contain,
                                                                ),
                                                                VerticalDivider(
                                                                  color:
                                                                      Colors
                                                                          .transparent,
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            4.6,
                                                                          ),
                                                                  thickness: 0,
                                                                ),
                                                                Text(
                                                                  "${user.radioSsp}/${nextLevel.costSsp}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.inter(
                                                                    letterSpacing:
                                                                        0,
                                                                    color: const Color(
                                                                      0xFF13ED51,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeightAlias
                                                                            .regular,
                                                                    fontSize:
                                                                        converter
                                                                            .h(
                                                                              12,
                                                                            ),
                                                                    height: 1,
                                                                  ),
                                                                ),
                                                                VerticalDivider(
                                                                  color:
                                                                      Colors
                                                                          .transparent,
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            42,
                                                                          ),
                                                                  thickness: 0,
                                                                ),
                                                                Assets.component.epIcon.image(
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            21,
                                                                          ),
                                                                  height:
                                                                      converter
                                                                          .h(
                                                                            22,
                                                                          ),
                                                                  fit:
                                                                      BoxFit
                                                                          .contain,
                                                                ),
                                                                VerticalDivider(
                                                                  color:
                                                                      Colors
                                                                          .transparent,
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            4.6,
                                                                          ),
                                                                  thickness: 0,
                                                                ),
                                                                Text(
                                                                  "${user.ep}/${nextLevel.costEp}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.inter(
                                                                    letterSpacing:
                                                                        0,
                                                                    color: const Color(
                                                                      0xFF13ED51,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeightAlias
                                                                            .regular,
                                                                    fontSize:
                                                                        converter
                                                                            .h(
                                                                              12,
                                                                            ),
                                                                    height: 1,
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          } else {
                                                            return SizedBox(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    SocketUnlockModalStatus
                                                                        .prepare,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      start: converter.w(89),
                                                      bottom: converter.h(7),
                                                      width: converter.w(54),
                                                      height: converter.h(57),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          if (state.status ==
                                                              LevelUpModalStatus
                                                                  .prepare) {
                                                            final bool
                                                            canProcess =
                                                                (user.radioSsp >=
                                                                    nextLevel
                                                                        .costSsp) &&
                                                                (user.ep >=
                                                                    nextLevel
                                                                        .costEp);

                                                            return KpctCupertinoButton.solid(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    LevelUpModalStatus
                                                                        .prepare,
                                                              ),
                                                              onPressed:
                                                                  !canProcess
                                                                      ? null
                                                                      : () => context
                                                                          .read<
                                                                            LevelUpModalBloc
                                                                          >()
                                                                          .add(
                                                                            LevelUpModalEvent.process(
                                                                              nextLevel:
                                                                                  nextLevel.level,
                                                                            ),
                                                                          ),
                                                              child: KpctSwitcher(
                                                                builder:
                                                                    () => (canProcess
                                                                            ? Assets.component.levelUpCircleButtonEnabled
                                                                            : Assets.component.levelUpCircleButtonDisabled)
                                                                        .image(
                                                                          key: ValueKey<
                                                                            bool
                                                                          >(
                                                                            canProcess,
                                                                          ),
                                                                          width: converter.w(
                                                                            54,
                                                                          ),
                                                                          height: converter.h(
                                                                            57,
                                                                          ),
                                                                          fit:
                                                                              BoxFit.contain,
                                                                        ),
                                                              ),
                                                            );
                                                          } else {
                                                            return SizedBox(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    LevelUpModalStatus
                                                                        .prepare,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    AnimatedPositionedDirectional(
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      end:
                                                          state.status ==
                                                                  LevelUpModalStatus
                                                                      .prepare
                                                              ? converter.w(89)
                                                              : converter.hcx(
                                                                54,
                                                              ),
                                                      bottom: converter.h(7),
                                                      width: converter.w(54),
                                                      height: converter.h(57),
                                                      child: KpctSwitcher(
                                                        builder:
                                                            () => KpctCupertinoButton.solid(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    LevelUpModalStatus
                                                                        .processing,
                                                              ),
                                                              onPressed:
                                                                  (state.status ==
                                                                          LevelUpModalStatus
                                                                              .processing)
                                                                      ? null
                                                                      : () => Navigator.pop(
                                                                        context,
                                                                      ),
                                                              child: (state.status ==
                                                                          LevelUpModalStatus
                                                                              .processing
                                                                      ? Assets
                                                                          .component
                                                                          .closeCircleButtonDisabled
                                                                      : Assets
                                                                          .component
                                                                          .closeCircleButtonEnabled)
                                                                  .image(
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              54,
                                                                            ),
                                                                    height:
                                                                        converter
                                                                            .h(
                                                                              57,
                                                                            ),
                                                                    fit:
                                                                        BoxFit
                                                                            .contain,
                                                                  ),
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          ),
                                    );
                                  } else {
                                    return CustomCircularProgressIndicator(
                                      key: ValueKey<bool>(state.initialized),
                                    );
                                  }
                                },
                              ),
                        ),
                  ),
                ),
              ),
            ),
          ),
    ),
  );

  Widget _buildReward({
    required KpctConverter converter,
    required BuildContext context,
    required AssetGenImage image,
    required String label,
    String? text,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.all(converter.radius(8)),
          child: Stack(
            children: [
              image.image(
                width: converter.w(42),
                height: converter.h(42),
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
              if (text != null) ...[
                PositionedDirectional(
                  end: converter.w(4),
                  bottom: converter.h(6),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: OutlinedText(
                      strokeColor: Colors.black,
                      strokeWidth: converter.h(1),
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        letterSpacing: 0,
                        color: Colors.white,
                        fontWeight: FontWeightAlias.semiBold,
                        fontStyle: FontStyle.italic,
                        fontSize: converter.h(8),
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      SizedBox(
        height: converter.h(12),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              letterSpacing: 0,
              color: const Color(0xFF24BD24),
              fontWeight: FontWeightAlias.regular,
              // fontStyle: FontStyle.italic,
              fontSize: converter.h(10),
              height: 1,
            ),
          ),
        ),
      ),
    ],
  );
}
