import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/route/home/modal/half/insetting_gem/insetting_gem_modal_bloc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';

import 'package:kpct_radio_app/route/home/modal/half/decomposition/decomposition_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

enum InsettingGemModalResponse {
  cancel,
  noSocketIndex,
  noTargetPack,
  stackableTargetPack,
  lockedSocket,
  noGemPack,
  emptyGem,
  success,
  fail,
}

class InsettingGemModal extends StatelessWidget {
  final bool substitution;
  final int socketIndex;

  final Equipment targetEquipment;
  final Pack gemPack;
  // final Equipment gemEquipment;

  static Future<dynamic> launch({
    required BuildContext context,
    required int? socketIndex,
    required Pack? targetPack,
    required Pack? gemPack,
  }) async {
    if (targetPack != null) {
      if (!targetPack.stackable) {
        if (socketIndex != null) {
          if (targetPack.equipments.first.sockets[socketIndex].gearId != null) {
            if (gemPack != null) {
              if (gemPack.equipments.isNotEmpty) {
                return await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (context) => InsettingGemModal(
                        substitution:
                            (targetPack
                                    .equipments
                                    .first
                                    .sockets[socketIndex]
                                    .gearId !=
                                ""),
                        targetEquipment: targetPack.equipments.first,
                        gemPack: gemPack,
                        socketIndex: socketIndex,
                      ),
                );
              } else {
                return InsettingGemModalResponse.emptyGem;
              }
            } else {
              return InsettingGemModalResponse.noGemPack;
            }
          } else {
            return InsettingGemModalResponse.lockedSocket;
          }
        } else {
          return InsettingGemModalResponse.noSocketIndex;
        }
      } else {
        return InsettingGemModalResponse.stackableTargetPack;
      }
    } else {
      return InsettingGemModalResponse.noTargetPack;
    }
  }

  const InsettingGemModal({
    required this.substitution,
    required this.socketIndex,
    required this.targetEquipment,
    required this.gemPack,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) => InsettingGemModalBloc(
          substitution: substitution,
          socketIndex: socketIndex,
          gemPack: gemPack,
          targetEquipment: targetEquipment,
        )..add(const InsettingGemModalEvent.initialize()),
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
                        (converter) => BlocBuilder<
                          InsettingGemModalBloc,
                          InsettingGemModalState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  (previous.initialized != current.initialized),
                          builder:
                              (context, state) => KpctSwitcher(
                                builder: () {
                                  if (state.initialized) {
                                    return BlocBuilder<
                                      InsettingGemModalBloc,
                                      InsettingGemModalState
                                    >(
                                      key: ValueKey<bool>(state.initialized),
                                      buildWhen:
                                          (previous, current) =>
                                              (previous.status !=
                                                  current.status),
                                      builder:
                                          (context, state) => WithAuth(
                                            builder: (user) {
                                              return Stack(
                                                children: [
                                                  KpctSwitcher(
                                                    builder:
                                                        () => Assets
                                                            .background
                                                            .halfModal
                                                            .image(
                                                              key: ValueKey<
                                                                InsettingGemModalStatus
                                                              >(state.status),
                                                              width:
                                                                  converter
                                                                      .realSize
                                                                      .width,
                                                              height:
                                                                  converter
                                                                      .realSize
                                                                      .height,
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                  ),
                                                  PositionedDirectional(
                                                    start: converter.hcx(306),
                                                    top: converter.h(161),
                                                    width: converter.w(306),
                                                    height: converter.h(6),
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          (state.status ==
                                                                  InsettingGemModalStatus
                                                                      .prepare)
                                                              ? 0
                                                              : 1,
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      child: Assets
                                                          .component
                                                          .modalGauge
                                                          .image(
                                                            width: converter.w(
                                                              306,
                                                            ),
                                                            height: converter.h(
                                                              6,
                                                            ),
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            fit: BoxFit.contain,
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
                                                        state.status.title,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.inter(
                                                          letterSpacing: 0,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: const Color(
                                                            0xFF13BE13,
                                                          ),
                                                          fontWeight:
                                                              FontWeightAlias
                                                                  .bold,
                                                          fontSize: converter.h(
                                                            20,
                                                          ),
                                                          height: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    top: converter.h(130),
                                                    start: 0,
                                                    end: 0,
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          ((state.status ==
                                                                      InsettingGemModalStatus
                                                                          .prepare) &&
                                                                  substitution)
                                                              ? 1
                                                              : 0,
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          "이미 소켓에 삽입된 GEM이 존재합니다.\n그래도 삽입하시겠습니까?",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.inter(
                                                            letterSpacing: 0,
                                                            color: const Color(
                                                              0xFF24E85B,
                                                            ),
                                                            fontWeight:
                                                                FontWeightAlias
                                                                    .bold,
                                                            fontSize: converter
                                                                .h(16),
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    top: converter.h(172),
                                                    start: 0,
                                                    end: 0,
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          ((state.status ==
                                                                      InsettingGemModalStatus
                                                                          .prepare) &&
                                                                  substitution)
                                                              ? 1
                                                              : 0,
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          "기존의 GEM은 삭제됩니다.",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.inter(
                                                            letterSpacing: 0,
                                                            color: const Color(
                                                              0xFF13BE13,
                                                            ),
                                                            fontWeight:
                                                                FontWeightAlias
                                                                    .semiBold,
                                                            fontSize: converter
                                                                .h(10),
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    top: converter.h(161),
                                                    start: converter.w(11 + 35),
                                                    end: converter.w(12 + 34),
                                                    height: converter.h(6),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            InsettingGemModalStatus
                                                                .prepare) {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  InsettingGemModalStatus
                                                                      .prepare,
                                                            ),
                                                          );
                                                        } else {
                                                          return Align(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  InsettingGemModalStatus
                                                                      .prepare,
                                                            ),
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
                                                              // borderRadius: BorderRadius.only(
                                                              //   topLeft: converter.radius(4),
                                                              //   bottomLeft: converter.radius(4),
                                                              // ),
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
                                                                  InsettingGemModalBloc,
                                                                  InsettingGemModalState
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
                                                            InsettingGemModalStatus
                                                                .prepare) {
                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  InsettingGemModalStatus
                                                                      .prepare,
                                                            ),
                                                            onPressed:
                                                                () => context
                                                                    .read<
                                                                      InsettingGemModalBloc
                                                                    >()
                                                                    .add(
                                                                      const InsettingGemModalEvent.insettingPressed(),
                                                                    ),
                                                            child: Assets
                                                                .component
                                                                .insettingGemCircleButtonEnabled
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
                                                          );
                                                        } else {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  InsettingGemModalStatus
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
                                                                InsettingGemModalStatus
                                                                    .prepare
                                                            ? converter.w(89)
                                                            : converter.hcx(54),
                                                    bottom: converter.h(7),
                                                    width: converter.w(54),
                                                    height: converter.h(57),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            InsettingGemModalStatus
                                                                .insetting) {
                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  InsettingGemModalStatus
                                                                      .insetting,
                                                            ),
                                                            onPressed: null,
                                                            child: Assets
                                                                .component
                                                                .closeCircleButtonDisabled
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
                                                          );
                                                        } else {
                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  InsettingGemModalStatus
                                                                      .insetting,
                                                            ),
                                                            onPressed: () {
                                                              switch (state
                                                                  .status) {
                                                                case InsettingGemModalStatus
                                                                    .prepare:
                                                                  Navigator.pop(
                                                                    context,
                                                                    InsettingGemModalResponse
                                                                        .cancel,
                                                                  );
                                                                  break;

                                                                case InsettingGemModalStatus
                                                                    .success:
                                                                  Navigator.pop(
                                                                    context,
                                                                    InsettingGemModalResponse
                                                                        .success,
                                                                  );
                                                                  break;

                                                                case InsettingGemModalStatus
                                                                    .fail:
                                                                  Navigator.pop(
                                                                    context,
                                                                    InsettingGemModalResponse
                                                                        .fail,
                                                                  );
                                                                  break;

                                                                case InsettingGemModalStatus
                                                                    .insetting:
                                                                  break;
                                                              }
                                                            },
                                                            child: Assets
                                                                .component
                                                                .closeCircleButtonEnabled
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
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
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
