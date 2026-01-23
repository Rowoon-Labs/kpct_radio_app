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
import 'package:kpct_radio_app/model/decomposition.dart';
import 'package:kpct_radio_app/route/home/modal/half/decomposition/decomposition_modal_bloc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';

import 'package:kpct_radio_app/route/home/modal/half/decomposition/decomposition_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

enum DecompositionModalResponse { cancel, noDecomposition, success }

class DecompositionModal extends StatelessWidget {
  final Decomposition decomposition;
  final Pack pack;

  static Future<dynamic> launch({
    required BuildContext context,
    required Decomposition? decomposition,
    required Pack pack,
  }) async {
    if (decomposition != null) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) =>
                DecompositionModal(decomposition: decomposition, pack: pack),
      );
    } else {
      return DecompositionModalResponse.noDecomposition;
    }
  }

  const DecompositionModal({
    required this.decomposition,
    required this.pack,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            DecompositionModalBloc(decomposition: decomposition, pack: pack)
              ..add(const DecompositionModalEvent.initialize()),
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
                          DecompositionModalBloc,
                          DecompositionModalState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  (previous.initialized != current.initialized),
                          builder:
                              (context, state) => KpctSwitcher(
                                builder: () {
                                  if (state.initialized) {
                                    return BlocBuilder<
                                      DecompositionModalBloc,
                                      DecompositionModalState
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
                                                                DecompositionModalStatus
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
                                                    top: converter.h(121),
                                                    width: converter.w(306),
                                                    height: converter.h(43),
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          (state.status ==
                                                                  DecompositionModalStatus
                                                                      .success)
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
                                                                    .radius(5),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    start: converter.hcx(306),
                                                    top: converter.h(207),
                                                    width: converter.w(306),
                                                    height: converter.h(30),
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          (state.status ==
                                                                  DecompositionModalStatus
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
                                                                    .radius(5),
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
                                                                      DecompositionModalStatus
                                                                          .prepare) ||
                                                                  (state.status ==
                                                                      DecompositionModalStatus
                                                                          .success))
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
                                                  AnimatedPositionedDirectional(
                                                    duration:
                                                        defaultAnimationDuration,
                                                    curve:
                                                        defaultAnimationCurve,
                                                    top: converter.h(69 - 1),
                                                    start: converter.hcx(49),
                                                    width: converter.w(49),
                                                    height: converter.h(49),
                                                    child: AnimatedOpacity(
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      opacity:
                                                          (state.status ==
                                                                  DecompositionModalStatus
                                                                      .prepare)
                                                              ? 1
                                                              : 0,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          pack
                                                              .gear
                                                              .tier
                                                              .assetGenImage
                                                              .image(
                                                                width: converter
                                                                    .w(49),
                                                                height:
                                                                    converter.h(
                                                                      49,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                              ),
                                                          pack.gear.category
                                                              .assetGenImage(
                                                                icon:
                                                                    pack
                                                                        .gear
                                                                        .icon,
                                                              )
                                                              .image(
                                                                width: converter
                                                                    .w(44),
                                                                height:
                                                                    converter.h(
                                                                      44,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                              ),
                                                          AnimatedOpacity(
                                                            opacity:
                                                                (state.status ==
                                                                        DecompositionModalStatus
                                                                            .fail)
                                                                    ? 0.6
                                                                    : 0,
                                                            duration:
                                                                defaultAnimationDuration,
                                                            curve:
                                                                defaultAnimationCurve,
                                                            child: Container(
                                                              width: converter
                                                                  .w(49),
                                                              height: converter
                                                                  .h(49),
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                      converter
                                                                          .radius(
                                                                            3,
                                                                          ),
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  AnimatedPositionedDirectional(
                                                    duration:
                                                        defaultAnimationDuration,
                                                    curve:
                                                        defaultAnimationCurve,
                                                    top: converter.h(121),
                                                    start: 0,
                                                    end: 0,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: AnimatedOpacity(
                                                        duration:
                                                            defaultAnimationDuration,
                                                        curve:
                                                            defaultAnimationCurve,
                                                        opacity:
                                                            (state.status ==
                                                                    DecompositionModalStatus
                                                                        .prepare)
                                                                ? 1
                                                                : 0,
                                                        child: Text(
                                                          pack.gear.name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.inter(
                                                            letterSpacing: 0,
                                                            color: const Color(
                                                              0xFF13BE13,
                                                            ),
                                                            fontWeight:
                                                                FontWeightAlias
                                                                    .regular,
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
                                                        if ((state.status ==
                                                                DecompositionModalStatus
                                                                    .prepare) ||
                                                            (state.status ==
                                                                DecompositionModalStatus
                                                                    .success)) {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
                                                                      .prepare,
                                                            ),
                                                          );
                                                        } else {
                                                          return Align(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
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
                                                                  DecompositionModalBloc,
                                                                  DecompositionModalState
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
                                                    top: converter.h(124.5 - 1),
                                                    start: 0,
                                                    end: 0,
                                                    height: converter.h(
                                                      1 + 36 + 1,
                                                    ),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            DecompositionModalStatus
                                                                .success) {
                                                          return Center(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
                                                                      .success,
                                                            ),
                                                            child: BlocBuilder<
                                                              DecompositionModalBloc,
                                                              DecompositionModalState
                                                            >(
                                                              buildWhen:
                                                                  (
                                                                    previous,
                                                                    current,
                                                                  ) =>
                                                                      (previous
                                                                              .results !=
                                                                          current
                                                                              .results),
                                                              builder:
                                                                  (
                                                                    context,
                                                                    state,
                                                                  ) => ListView.separated(
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemCount:
                                                                        state
                                                                            .results
                                                                            .length,
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    shrinkWrap:
                                                                        true,
                                                                    separatorBuilder:
                                                                        (
                                                                          context,
                                                                          index,
                                                                        ) => VerticalDivider(
                                                                          color:
                                                                              Colors.transparent,
                                                                          width: converter.w(
                                                                            12,
                                                                          ),
                                                                          thickness:
                                                                              0,
                                                                        ),
                                                                    itemBuilder: (
                                                                      context,
                                                                      index,
                                                                    ) {
                                                                      final Gear?
                                                                      gear = App
                                                                          .instance
                                                                          .reserved
                                                                          .gear(
                                                                            id:
                                                                                state.results[index],
                                                                          );

                                                                      return Stack(
                                                                        children: [
                                                                          if (gear !=
                                                                              null) ...[
                                                                            gear.tier.assetGenImage.image(
                                                                              width: converter.w(
                                                                                38,
                                                                              ),
                                                                              height: converter.h(
                                                                                38,
                                                                              ),
                                                                              fit:
                                                                                  BoxFit.contain,
                                                                            ),
                                                                            gear.category
                                                                                .assetGenImage(
                                                                                  icon:
                                                                                      gear.icon,
                                                                                )
                                                                                .image(
                                                                                  width: converter.w(
                                                                                    36,
                                                                                  ),
                                                                                  height: converter.h(
                                                                                    36,
                                                                                  ),
                                                                                  fit:
                                                                                      BoxFit.contain,
                                                                                ),
                                                                          ],
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                            ),
                                                          );
                                                        } else {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
                                                                      .success,
                                                            ),
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
                                                            DecompositionModalStatus
                                                                .prepare) {
                                                          return Row(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
                                                                      .prepare,
                                                            ),
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Assets
                                                                  .component
                                                                  .sspIcon
                                                                  .image(
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
                                                                width: converter
                                                                    .w(4.6),
                                                                thickness: 0,
                                                              ),
                                                              Text(
                                                                "${user.radioSsp}/${decomposition.costSsp}",
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
                                                                width: converter
                                                                    .w(42),
                                                                thickness: 0,
                                                              ),
                                                              Assets
                                                                  .component
                                                                  .epIcon
                                                                  .image(
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
                                                                width: converter
                                                                    .w(4.6),
                                                                thickness: 0,
                                                              ),
                                                              Text(
                                                                "${user.ep}/${decomposition.costEp}",
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
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
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
                                                            DecompositionModalStatus
                                                                .prepare) {
                                                          final bool
                                                          canDecomposing =
                                                              (user.radioSsp >=
                                                                  decomposition
                                                                      .costSsp) &&
                                                              (user.ep >=
                                                                  decomposition
                                                                      .costEp);

                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
                                                                      .prepare,
                                                            ),
                                                            onPressed:
                                                                !canDecomposing
                                                                    ? null
                                                                    : () => context
                                                                        .read<
                                                                          DecompositionModalBloc
                                                                        >()
                                                                        .add(
                                                                          DecompositionModalEvent.decompositionPressed(
                                                                            equipmentId:
                                                                                pack.equipments.first.id,
                                                                            decompositionId:
                                                                                decomposition.id,
                                                                          ),
                                                                        ),
                                                            child: KpctSwitcher(
                                                              builder: () {
                                                                if (canDecomposing) {
                                                                  return Assets.component.decompositionCircleButtonEnabled.image(
                                                                    key: ValueKey<
                                                                      bool
                                                                    >(
                                                                      canDecomposing,
                                                                    ),
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
                                                                  );
                                                                } else {
                                                                  return Assets.component.decompositionCircleButtonDisabled.image(
                                                                    key: ValueKey<
                                                                      bool
                                                                    >(
                                                                      canDecomposing,
                                                                    ),
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
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        } else {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
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
                                                                DecompositionModalStatus
                                                                    .prepare
                                                            ? converter.w(89)
                                                            : converter.hcx(54),
                                                    bottom: converter.h(7),
                                                    width: converter.w(54),
                                                    height: converter.h(57),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            DecompositionModalStatus
                                                                .decomposing) {
                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  DecompositionModalStatus
                                                                      .decomposing,
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
                                                                  DecompositionModalStatus
                                                                      .decomposing,
                                                            ),
                                                            onPressed:
                                                                () =>
                                                                    Navigator.pop(
                                                                      context,
                                                                    ),
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
