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
import 'package:kpct_radio_app/app/misc/custom_extensions.dart';
import 'package:kpct_radio_app/model/draw.dart';
import 'package:kpct_radio_app/model/level.dart';
import 'package:kpct_radio_app/route/home/modal/full/random_box/modal/half/random_box_reward/random_box_reward_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_misc.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

enum RandomBoxRewardModalResponse { cancel, noGearDraws, noGemDraws, success }

class RandomBoxRewardModal extends StatelessWidget {
  static Future<dynamic> launch({
    required BuildContext context,
    required DrawId drawId,
  }) async {
    final List<Equipment> results = App.instance.factory
        .generateBoxRewardEquipments(drawId: drawId);

    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => RandomBoxRewardModal._(drawId: drawId, results: results),
    );
  }

  final DrawId drawId;
  final List<Equipment> results;

  const RandomBoxRewardModal._({required this.drawId, required this.results});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            RandomBoxRewardModalBloc(drawId: drawId, results: results)
              ..add(const RandomBoxRewardModalEvent.initialize()),
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
                          RandomBoxRewardModalBloc,
                          RandomBoxRewardModalState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  (previous.status != current.status),
                          builder:
                              (context, state) => WithAuth(
                                builder: (user) {
                                  final Level? nextLevel = App.instance.reserved
                                      .nextLevel(level: user.level);

                                  if (nextLevel != null) {
                                    return Stack(
                                      key: ValueKey<Level?>(nextLevel),
                                      children: [
                                        Assets.background.halfModal.image(
                                          width: converter.realSize.width,
                                          height: converter.realSize.height,
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
                                                        RandomBoxRewardModalStatus
                                                            .prepare)
                                                    ? 0.5
                                                    : 0,
                                            duration: defaultAnimationDuration,
                                            curve: defaultAnimationCurve,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.all(
                                                  converter.radius(5),
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
                                                            RandomBoxRewardModalStatus
                                                                .processing) ||
                                                        (state.status ==
                                                            RandomBoxRewardModalStatus
                                                                .fail))
                                                    ? 1
                                                    : 0,
                                            duration: defaultAnimationDuration,
                                            curve: defaultAnimationCurve,
                                            child: Assets.component.modalGauge
                                                .image(
                                                  width: converter.w(306),
                                                  height: converter.h(6),
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          top: converter.h(40),
                                          start: 0,
                                          end: 0,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              "REWARD",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                letterSpacing: 0,
                                                // fontStyle: FontStyle.italic,
                                                color: const Color(0xFF13BE13),
                                                fontWeight:
                                                    FontWeightAlias.bold,
                                                fontSize: converter.h(20),
                                                height: 1,
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
                                              final ValueKey<bool>
                                              key = ValueKey(
                                                (state.status ==
                                                        RandomBoxRewardModalStatus
                                                            .processing) ||
                                                    (state.status ==
                                                        RandomBoxRewardModalStatus
                                                            .fail),
                                              );
                                              if (key.value) {
                                                return Align(
                                                  key: key,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          converter.radius(4),
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
                                                          stops: const [
                                                            0.49,
                                                            1,
                                                          ],
                                                          colors: [
                                                            const Color(
                                                              0xFF24BD24,
                                                            ),
                                                            const Color(
                                                              0xFF24E85B,
                                                            ).withOpacity(0.33),
                                                          ],
                                                        ),
                                                      ),
                                                      child: BlocBuilder<
                                                        RandomBoxRewardModalBloc,
                                                        RandomBoxRewardModalState
                                                      >(
                                                        buildWhen:
                                                            (
                                                              previous,
                                                              current,
                                                            ) =>
                                                                (previous
                                                                        .elapsedDuration !=
                                                                    current
                                                                        .elapsedDuration),
                                                        builder:
                                                            (
                                                              context,
                                                              state,
                                                            ) => SizedBox(
                                                              // width: converter.w(261),
                                                              height: converter
                                                                  .h(6),
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
                                                return SizedBox(key: key);
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
                                                  RandomBoxRewardModalStatus
                                                      .prepare) {
                                                return Row(
                                                  key: ValueKey<bool>(
                                                    state.status ==
                                                        RandomBoxRewardModalStatus
                                                            .prepare,
                                                  ),
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Assets.component.sspIcon
                                                        .image(
                                                          width: converter.w(
                                                            21,
                                                          ),
                                                          height: converter.h(
                                                            21,
                                                          ),
                                                          fit: BoxFit.contain,
                                                        ),
                                                    VerticalDivider(
                                                      color: Colors.transparent,
                                                      width: converter.w(4.6),
                                                      thickness: 0,
                                                    ),
                                                    Text(
                                                      "${user.radioSsp}/${nextLevel.limitSsp}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        letterSpacing: 0,
                                                        color: const Color(
                                                          0xFF13ED51,
                                                        ),
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .regular,
                                                        fontSize: converter.h(
                                                          12,
                                                        ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                    VerticalDivider(
                                                      color: Colors.transparent,
                                                      width: converter.w(42),
                                                      thickness: 0,
                                                    ),
                                                    Assets.component.epIcon
                                                        .image(
                                                          width: converter.w(
                                                            21,
                                                          ),
                                                          height: converter.h(
                                                            22,
                                                          ),
                                                          fit: BoxFit.contain,
                                                        ),
                                                    VerticalDivider(
                                                      color: Colors.transparent,
                                                      width: converter.w(4.6),
                                                      thickness: 0,
                                                    ),
                                                    Text(
                                                      "${user.ep}/${nextLevel.limitEp}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        letterSpacing: 0,
                                                        color: const Color(
                                                          0xFF13ED51,
                                                        ),
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .regular,
                                                        fontSize: converter.h(
                                                          12,
                                                        ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return SizedBox(
                                                  key: ValueKey<bool>(
                                                    state.status ==
                                                        RandomBoxRewardModalStatus
                                                            .prepare,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        PositionedDirectional(
                                          top: converter.h(121),
                                          start: converter.w(0),
                                          end: converter.w(0),
                                          height: converter.h(57),
                                          child: KpctSwitcher(
                                            builder: () {
                                              final ValueKey<bool>
                                              key = ValueKey(
                                                state.status ==
                                                    RandomBoxRewardModalStatus
                                                        .success,
                                              );
                                              if (key.value) {
                                                final Map<String, int>
                                                rewardMap = {};

                                                for (final Equipment equipment
                                                    in results) {
                                                  rewardMap[equipment.gearId] =
                                                      (rewardMap[equipment
                                                              .gearId] ??
                                                          0) +
                                                      1;
                                                }

                                                final List<Widget> children =
                                                    rewardMap.keys.map((
                                                      element,
                                                    ) {
                                                      final Gear? gear = App
                                                          .instance
                                                          .reserved
                                                          .gear(id: element);

                                                      if (gear != null) {
                                                        return Stack(
                                                          alignment:
                                                              Alignment
                                                                  .topCenter,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: SizedBox(
                                                                width: converter
                                                                    .w(42),
                                                                height:
                                                                    converter.h(
                                                                      42,
                                                                    ),
                                                                child: Stack(
                                                                  children: [
                                                                    gear.tier.assetGenImage.image(
                                                                      width: converter
                                                                          .w(
                                                                            42,
                                                                          ),
                                                                      height:
                                                                          converter.h(
                                                                            42,
                                                                          ),
                                                                      fit:
                                                                          BoxFit
                                                                              .contain,
                                                                    ),
                                                                    gear.category
                                                                        .assetGenImage(
                                                                          icon:
                                                                              gear.icon,
                                                                        )
                                                                        .image(
                                                                          width: converter.w(
                                                                            42,
                                                                          ),
                                                                          height: converter.h(
                                                                            42,
                                                                          ),
                                                                          fit:
                                                                              BoxFit.contain,
                                                                        ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(
                                                                          right:
                                                                              converter.w(
                                                                                4,
                                                                              ),
                                                                          bottom:
                                                                              converter.h(
                                                                                2,
                                                                              ),
                                                                        ),
                                                                        child: OutlinedText(
                                                                          rewardMap[gear.gearId]
                                                                              .toString(),
                                                                          strokeColor:
                                                                              Colors.black,
                                                                          strokeWidth:
                                                                              converter.h(
                                                                                1,
                                                                              ),
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style: GoogleFonts.inter(
                                                                            letterSpacing:
                                                                                0,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeightAlias.semiBold,
                                                                            fontSize: converter.h(
                                                                              8,
                                                                            ),
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                            height:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .bottomCenter,
                                                              child: Text(
                                                                gear.name,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: const Color(
                                                                    0xFF24BD24,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .regular,
                                                                  fontSize:
                                                                      converter
                                                                          .h(
                                                                            10,
                                                                          ),
                                                                  height: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    }).toList();

                                                return Center(
                                                  key: key,
                                                  child: ListView.separated(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: converter
                                                              .w(52.5),
                                                        ),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: children.length,
                                                    shrinkWrap: true,
                                                    separatorBuilder:
                                                        (
                                                          context,
                                                          index,
                                                        ) => VerticalDivider(
                                                          color:
                                                              Colors
                                                                  .transparent,
                                                          width: converter.w(
                                                            48,
                                                          ),
                                                          thickness: 0,
                                                        ),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            children[index],
                                                  ),
                                                );
                                              } else {
                                                return SizedBox(key: key);
                                              }
                                            },
                                          ),
                                        ),
                                        PositionedDirectional(
                                          start: converter.hcx(54),
                                          bottom: converter.h(7),
                                          width: converter.w(54),
                                          height: converter.h(57),
                                          child: KpctSwitcher(
                                            builder:
                                                () => KpctCupertinoButton.solid(
                                                  key: ValueKey<bool>(
                                                    state.status ==
                                                        RandomBoxRewardModalStatus
                                                            .processing,
                                                  ),
                                                  onPressed:
                                                      (state.status ==
                                                              RandomBoxRewardModalStatus
                                                                  .processing)
                                                          ? null
                                                          : () => Navigator.pop(
                                                            context,
                                                          ),
                                                  child: (state.status ==
                                                              RandomBoxRewardModalStatus
                                                                  .processing
                                                          ? Assets
                                                              .component
                                                              .closeCircleButtonDisabled
                                                          : Assets
                                                              .component
                                                              .closeCircleButtonEnabled)
                                                      .image(
                                                        width: converter.w(54),
                                                        height: converter.h(57),
                                                        fit: BoxFit.contain,
                                                      ),
                                                ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return SizedBox.shrink(
                                      key: ValueKey<Level?>(nextLevel),
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
