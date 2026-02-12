import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/app/misc/custom_extensions.dart';
import 'package:kpct_radio_app/model/recipe.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

enum WorkbenchModalResponse {
  cancel,
  noTargetGear,
  noTargetRecipe,
  noStuffGear,
}

class WorkbenchModal extends StatelessWidget {
  final List<Stuff> stuffs;
  final Recipe recipe;
  final Gear gear;

  static Future<dynamic> launch({
    required BuildContext context,
    required Kit? kit,
  }) async {
    if (kit != null) {
      final Recipe? recipe = App.instance.reserved.recipe(id: kit.gear.id);

      if (recipe != null) {
        final List<String?> stuffIds = [
          recipe.stuff1,
          recipe.stuff2,
          recipe.stuff3,
          recipe.stuff4,
          recipe.stuff5,
        ];

        final List<Stuff> stuffs = List.empty(growable: true);

        for (String? stuffId in stuffIds) {
          if (stuffId != null) {
            final Gear? gear = App.instance.reserved.gear(id: stuffId);

            if (gear != null) {
              stuffs.add(Stuff(gear: gear, equipment: null));
            } else {
              //return WorkbenchModalResponse.noStuffGear;
            }
          }
        }

        return await showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => WorkbenchModal(
                stuffs: stuffs,
                recipe: recipe,
                gear: kit.gear,
              ),
        );
      } else {
        return WorkbenchModalResponse.noTargetRecipe;
      }
    } else {
      return WorkbenchModalResponse.noTargetGear;
    }
  }

  const WorkbenchModal({
    required this.stuffs,
    required this.recipe,
    required this.gear,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            WorkbenchModalBloc(stuffs: stuffs, recipe: recipe, gear: gear)
              ..add(const WorkbenchModalEvent.initialize()),
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
                          WorkbenchModalBloc,
                          WorkbenchModalState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  (previous.initialized != current.initialized),
                          builder:
                              (context, state) => KpctSwitcher(
                                builder: () {
                                  if (state.initialized) {
                                    return WithAuth(
                                      key: ValueKey<bool>(state.initialized),
                                      builder:
                                          (user) => BlocBuilder<
                                            WorkbenchModalBloc,
                                            WorkbenchModalState
                                          >(
                                            buildWhen:
                                                (previous, current) =>
                                                    (previous.status !=
                                                        current.status) ||
                                                    (previous.stuffs !=
                                                        current.stuffs),
                                            builder:
                                                (context, state) => Stack(
                                                  children: [
                                                    KpctSwitcher(
                                                      builder:
                                                          () => Assets
                                                              .background
                                                              .halfModal
                                                              .image(
                                                                key: ValueKey<
                                                                  WorkbenchModalStatus
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
                                                      top: converter.h(140),
                                                      width: converter.w(306),
                                                      height: converter.h(20),
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                    WorkbenchModalStatus
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
                                                      top: converter.h(162),
                                                      width: converter.w(306),
                                                      height: converter.h(43),
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                    WorkbenchModalStatus
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
                                                      top: converter.h(207),
                                                      width: converter.w(306),
                                                      height: converter.h(30),
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                    WorkbenchModalStatus
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
                                                            (state.status ==
                                                                    WorkbenchModalStatus
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
                                                      top: converter.h(
                                                        state.status ==
                                                                WorkbenchModalStatus
                                                                    .prepare
                                                            ? 40
                                                            : 39,
                                                      ),
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
                                                            fontSize: converter
                                                                .h(20),
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
                                                      top: converter.h(
                                                        state.status ==
                                                                WorkbenchModalStatus
                                                                    .prepare
                                                            ? 69 - 1
                                                            : 89 - 1,
                                                      ),
                                                      start: converter.hcx(49),
                                                      width: converter.w(49),
                                                      height: converter.h(49),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          gear
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
                                                          gear.category
                                                              .assetGenImage(
                                                                icon: gear.icon,
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
                                                                        WorkbenchModalStatus
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
                                                    AnimatedPositionedDirectional(
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      top: converter.h(
                                                        state.status ==
                                                                WorkbenchModalStatus
                                                                    .prepare
                                                            ? 121
                                                            : 142,
                                                      ),
                                                      start: 0,
                                                      end: 0,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          gear.name,
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
                                                    PositionedDirectional(
                                                      top: converter.h(161),
                                                      start: converter.w(
                                                        11 + 35,
                                                      ),
                                                      end: converter.w(12 + 34),
                                                      height: converter.h(6),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          if (state.status ==
                                                              WorkbenchModalStatus
                                                                  .prepare) {
                                                            return SizedBox(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
                                                                        .prepare,
                                                              ),
                                                            );
                                                          } else {
                                                            return Align(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
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
                                                                    WorkbenchModalBloc,
                                                                    WorkbenchModalState
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
                                                      top: converter.h(142),
                                                      start: 0,
                                                      end: 0,
                                                      height: converter.h(18),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          if (state.status ==
                                                              WorkbenchModalStatus
                                                                  .prepare) {
                                                            return Row(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
                                                                        .prepare,
                                                              ),
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
                                                                          .center,
                                                                  style: GoogleFonts.inter(
                                                                    letterSpacing:
                                                                        0,
                                                                    color: const Color(
                                                                      0xFF13BE13,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeightAlias
                                                                            .semiBold,
                                                                    fontSize:
                                                                        converter
                                                                            .h(
                                                                              8,
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
                                                                          .w(4),
                                                                  thickness: 0,
                                                                ),
                                                                Text(
                                                                  "${recipe.probability}%",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.inter(
                                                                    letterSpacing:
                                                                        0,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    color: const Color(
                                                                      0xFF06FF98,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeightAlias
                                                                            .regular,
                                                                    fontSize:
                                                                        converter
                                                                            .h(
                                                                              15,
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
                                                                    WorkbenchModalStatus
                                                                        .prepare,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    PositionedDirectional(
                                                      top: converter.h(
                                                        165.5 - 1,
                                                      ),
                                                      start: 0,
                                                      end: 0,
                                                      height: converter.h(40),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          if (state.status ==
                                                              WorkbenchModalStatus
                                                                  .prepare) {
                                                            return Center(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
                                                                        .prepare,
                                                              ),
                                                              child: ListView.separated(
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    state
                                                                        .stuffs
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
                                                                          Colors
                                                                              .transparent,
                                                                      width: converter
                                                                          .w(
                                                                            12,
                                                                          ),
                                                                      thickness:
                                                                          0,
                                                                    ),
                                                                itemBuilder:
                                                                    (
                                                                      context,
                                                                      index,
                                                                    ) => AnimatedOpacity(
                                                                      opacity:
                                                                          (state.stuffs[index].equipment !=
                                                                                  null)
                                                                              ? 1
                                                                              : 0.3,
                                                                      // opacity: (kits.firstWhereOrNull((element) => (element.gear.id == stuffs[index].id)) != null) ? 1 : 0.3,
                                                                      curve:
                                                                          defaultAnimationCurve,
                                                                      duration:
                                                                          defaultAnimationDuration,
                                                                      child: Stack(
                                                                        children: [
                                                                          state.stuffs[index].gear.tier.assetGenImage.image(
                                                                            width: converter.w(
                                                                              38,
                                                                            ),
                                                                            height: converter.h(
                                                                              38,
                                                                            ),
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                          state
                                                                              .stuffs[index]
                                                                              .gear
                                                                              .category
                                                                              .assetGenImage(
                                                                                icon:
                                                                                    state.stuffs[index].gear.icon,
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
                                                                      ),
                                                                    ),
                                                              ),
                                                            );
                                                          } else {
                                                            return SizedBox(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
                                                                        .prepare,
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
                                                              WorkbenchModalStatus
                                                                  .prepare) {
                                                            return Row(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
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
                                                                  "${user.radioSsp}/${recipe.costSsp}",
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
                                                                  "${user.ep}/${recipe.costEp}",
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
                                                                    WorkbenchModalStatus
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
                                                              WorkbenchModalStatus
                                                                  .prepare) {
                                                            final bool
                                                            canCraft =
                                                                (state.stuffs.firstWhereOrNull(
                                                                      (
                                                                        element,
                                                                      ) =>
                                                                          (element.equipment ==
                                                                              null),
                                                                    ) ==
                                                                    null) &&
                                                                (user.radioSsp >=
                                                                    recipe
                                                                        .costSsp) &&
                                                                (user.ep >=
                                                                    recipe
                                                                        .costEp);

                                                            return KpctCupertinoButton.solid(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
                                                                        .prepare,
                                                              ),
                                                              onPressed:
                                                                  !canCraft
                                                                      ? null
                                                                      : () => context
                                                                          .read<
                                                                            WorkbenchModalBloc
                                                                          >()
                                                                          .add(
                                                                            WorkbenchModalEvent.craftPressed(
                                                                              gearId:
                                                                                  gear.id,
                                                                              equipmentIds:
                                                                                  state.stuffs
                                                                                      .map(
                                                                                        (
                                                                                          element,
                                                                                        ) =>
                                                                                            element.equipment!.id,
                                                                                      )
                                                                                      .toList(),
                                                                            ),
                                                                          ),
                                                              child: KpctSwitcher(
                                                                builder: () {
                                                                  if (canCraft) {
                                                                    return Assets.component.craftingCircleButtonEnabled.image(
                                                                      key: ValueKey<
                                                                        bool
                                                                      >(
                                                                        canCraft,
                                                                      ),
                                                                      width: converter
                                                                          .w(
                                                                            54,
                                                                          ),
                                                                      height:
                                                                          converter.h(
                                                                            57,
                                                                          ),
                                                                      fit:
                                                                          BoxFit
                                                                              .contain,
                                                                    );
                                                                  } else {
                                                                    return Assets.component.craftingCircleButtonDisabled.image(
                                                                      key: ValueKey<
                                                                        bool
                                                                      >(
                                                                        canCraft,
                                                                      ),
                                                                      width: converter
                                                                          .w(
                                                                            54,
                                                                          ),
                                                                      height:
                                                                          converter.h(
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
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
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
                                                                  WorkbenchModalStatus
                                                                      .prepare
                                                              ? converter.w(89)
                                                              : converter.hcx(
                                                                54,
                                                              ),
                                                      bottom: converter.h(7),
                                                      width: converter.w(54),
                                                      height: converter.h(57),
                                                      child: KpctSwitcher(
                                                        builder: () {
                                                          if (state.status ==
                                                              WorkbenchModalStatus
                                                                  .crafting) {
                                                            return KpctCupertinoButton.solid(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
                                                                        .crafting,
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
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.status ==
                                                                    WorkbenchModalStatus
                                                                        .crafting,
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
}
