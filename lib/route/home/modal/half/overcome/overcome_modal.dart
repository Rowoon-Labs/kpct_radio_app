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
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/level.dart';
import 'package:kpct_radio_app/route/home/modal/half/overcome/overcome_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_misc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';

enum OvercomeModalResponse { cancel, success }

class OvercomeModal extends StatelessWidget {
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
            (context) => OvercomeModal._(
              currentLevel: currentLevel,
              nextLevel: nextLevel,
            ),
      );
    }
  }

  final Level currentLevel;
  final Level nextLevel;

  const OvercomeModal._({required this.currentLevel, required this.nextLevel});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            OvercomeModalBloc(currentLevel: currentLevel, nextLevel: nextLevel)
              ..add(const OvercomeModalEvent.initialize()),
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
                        ) => BlocBuilder<OvercomeModalBloc, OvercomeModalState>(
                          buildWhen:
                              (previous, current) =>
                                  (previous.initialized != current.initialized),
                          builder:
                              (context, state) => KpctSwitcher(
                                builder: () {
                                  if (state.initialized) {
                                    return BlocBuilder<
                                      OvercomeModalBloc,
                                      OvercomeModalState
                                    >(
                                      key: ValueKey<bool>(state.initialized),
                                      buildWhen:
                                          (previous, current) =>
                                              (previous.status !=
                                                  current.status),
                                      builder:
                                          (context, state) => WithAuth(
                                            builder: (user) {
                                              final Level? nextLevel = App
                                                  .instance
                                                  .reserved
                                                  .nextLevel(level: user.level);

                                              if (nextLevel != null) {
                                                return Stack(
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
                                                                    OvercomeModalStatus
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
                                                                        OvercomeModalStatus
                                                                            .processing) ||
                                                                    (state.status ==
                                                                        OvercomeModalStatus
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
                                                    AnimatedPositionedDirectional(
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      // top: converter.h(40),
                                                      top:
                                                          state.status ==
                                                                  OvercomeModalStatus
                                                                      .prepare
                                                              ? converter.h(40)
                                                              : converter.h(98),
                                                      start: 0,
                                                      end: 0,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          state.status.title,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.inter(
                                                            letterSpacing: 0,
                                                            // fontStyle: FontStyle.italic,
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
                                                      top: converter.h(135),
                                                      start: 0,
                                                      end: 0,
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                        OvercomeModalStatus
                                                                            .success) ||
                                                                    (state.status ==
                                                                        OvercomeModalStatus
                                                                            .fail)
                                                                ? 1
                                                                : 0,
                                                        duration:
                                                            defaultAnimationDuration,
                                                        curve:
                                                            defaultAnimationCurve,
                                                        child: Center(
                                                          child: Text(
                                                            state.status.result,
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  const Color(
                                                                    0xFF24E85B,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .semiBold,
                                                              fontSize:
                                                                  converter.h(
                                                                    10,
                                                                  ),
                                                              // fontStyle: FontStyle.italic,
                                                              height: 1,
                                                            ),
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
                                                                    OvercomeModalStatus
                                                                        .prepare)
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
                                                      start: converter.w(
                                                        11 + 89,
                                                      ),
                                                      end: converter.w(12 + 82),
                                                      top: converter.h(145),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: AnimatedOpacity(
                                                          opacity:
                                                              (state.status ==
                                                                      OvercomeModalStatus
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
                                                            children: [
                                                              Text(
                                                                "플레이타임",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: const Color(
                                                                    0xFF24BD24,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .semiBold,
                                                                  // fontStyle: FontStyle.italic,
                                                                  fontSize:
                                                                      converter
                                                                          .h(8),
                                                                  height: 1,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    "${user.accumulatedPlayDuration.formatUnderHourSingleMax} / ${nextLevel.condition1.formatUnderHourSingleMax}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: GoogleFonts.inter(
                                                                      letterSpacing:
                                                                          0,
                                                                      color: const Color(
                                                                        0xFF06FF98,
                                                                      ),
                                                                      fontWeight:
                                                                          FontWeightAlias
                                                                              .regular,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontSize:
                                                                          converter.h(
                                                                            15,
                                                                          ),
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      start: converter.w(
                                                        11 + 89,
                                                      ),
                                                      end: converter.w(12 + 82),
                                                      top: converter.h(172),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: AnimatedOpacity(
                                                          opacity:
                                                              (state.status ==
                                                                      OvercomeModalStatus
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
                                                            children: [
                                                              Text(
                                                                "성공확률",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: const Color(
                                                                    0xFF24BD24,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .semiBold,
                                                                  // fontStyle: FontStyle.italic,
                                                                  fontSize:
                                                                      converter
                                                                          .h(8),
                                                                  height: 1,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    "${nextLevel.limitProbability}%",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: GoogleFonts.inter(
                                                                      letterSpacing:
                                                                          0,
                                                                      color: const Color(
                                                                        0xFF06FF98,
                                                                      ),
                                                                      fontWeight:
                                                                          FontWeightAlias
                                                                              .regular,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      fontSize:
                                                                          converter.h(
                                                                            15,
                                                                          ),
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
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
                                                                    OvercomeModalStatus
                                                                        .processing) ||
                                                                (state.status ==
                                                                    OvercomeModalStatus
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
                                                                    OvercomeModalBloc,
                                                                    OvercomeModalState
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
                                                    PositionedDirectional(
                                                      top: converter.h(211),
                                                      start: 0,
                                                      end: 0,
                                                      height: converter.h(22),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          if (state.status ==
                                                              OvercomeModalStatus
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
                                                                  "${user.radioSsp}/${nextLevel.limitSsp}",
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
                                                                  "${user.ep}/${nextLevel.limitEp}",
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
                                                              OvercomeModalStatus
                                                                  .prepare) {
                                                            final bool
                                                            canProcess =
                                                                (user.radioSsp >=
                                                                    nextLevel
                                                                        .limitSsp) &&
                                                                (user.ep >=
                                                                    nextLevel
                                                                        .limitEp) &&
                                                                (user.accumulatedPlayDuration >=
                                                                    nextLevel
                                                                        .condition1);

                                                            return KpctCupertinoButton.solid(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    OvercomeModalStatus
                                                                        .prepare,
                                                              ),
                                                              onPressed:
                                                                  !canProcess
                                                                      ? null
                                                                      : () => context
                                                                          .read<
                                                                            OvercomeModalBloc
                                                                          >()
                                                                          .add(
                                                                            OvercomeModalEvent.process(
                                                                              nextLevel:
                                                                                  nextLevel.level,
                                                                            ),
                                                                          ),
                                                              child: KpctSwitcher(
                                                                builder:
                                                                    () => (canProcess
                                                                            ? Assets.component.overcomeCircleButtonEnabled
                                                                            : Assets.component.overcomeCircleButtonDisabled)
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
                                                                    OvercomeModalStatus
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
                                                                  OvercomeModalStatus
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
                                                                    OvercomeModalStatus
                                                                        .processing,
                                                              ),
                                                              onPressed:
                                                                  (state.status ==
                                                                          OvercomeModalStatus
                                                                              .processing)
                                                                      ? null
                                                                      : () => Navigator.pop(
                                                                        context,
                                                                      ),
                                                              child: (state.status ==
                                                                          OvercomeModalStatus
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
                                                );
                                              } else {
                                                return SizedBox.shrink(
                                                  key: ValueKey<Level?>(
                                                    nextLevel,
                                                  ),
                                                );
                                              }
                                            },
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
}
