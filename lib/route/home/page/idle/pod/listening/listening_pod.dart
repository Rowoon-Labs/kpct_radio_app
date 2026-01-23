import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/route/home/modal/full/random_box/random_box_modal.dart';
import 'package:kpct_radio_app/route/home/modal/half/listening_reward/listening_reward_modal.dart';
import 'package:kpct_radio_app/route/home/page/idle/pod/listening/listening_pod_bloc.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';

class ListeningPod extends StatelessWidget {
  const ListeningPod({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => ListeningPodBloc(),
    child: Builder(
      builder:
          (context) => KpctAspectRatio(
            designWidth: designWidth,
            designHeight: 142.35,
            builder:
                (converter) => Stack(
                  children: [
                    Assets.component.listeningPod.image(
                      width: converter.realSize.width,
                      height: converter.realSize.height,
                      fit: BoxFit.cover,
                    ),
                    PositionedDirectional(
                      top: converter.h(16.26),
                      start: converter.w(128),
                      width: converter.w(230),
                      height: converter.h(14),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(converter.radius(4)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [0, 0.49],
                                    colors: [
                                      Color(0x0000FF84),
                                      Color(0xFF00FF84),
                                    ],
                                  ),
                                ),
                                child: WithAuth(
                                  builder:
                                      (user) => SizedBox(
                                        height: converter.h(14),
                                        width: converter.w(
                                          230 *
                                              ((user.stamina ==
                                                      user.adjustedStaminaMax)
                                                  ? 1
                                                  : (user.stamina /
                                                      user.adjustedStaminaMax)),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            start: converter.w(7),
                            top: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: WithAuth(
                                  builder:
                                      (user) => OutlinedText(
                                        "${user.stamina}/${user.adjustedStaminaMax}",
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: Colors.white,
                                          fontWeight: FontWeightAlias.semiBold,
                                          fontSize: converter.h(8),
                                          fontStyle: FontStyle.italic,
                                          height: 1,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PositionedDirectional(
                      top: converter.h(43.36),
                      start: converter.w(128),
                      width: converter.w(230),
                      height: converter.h(14),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(converter.radius(4)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [0, 0.49],
                                    colors: [
                                      Color(0x0012BAF3),
                                      Color(0xFF7FD6F3),
                                    ],
                                  ),
                                ),
                                child: WithAuth(
                                  builder:
                                      (user) => SizedBox(
                                        height: converter.h(14),
                                        width: converter.w(
                                          230 *
                                              ((user.listeningGauge ==
                                                      App
                                                          .instance
                                                          .reserved
                                                          .global
                                                          .listeningGauge)
                                                  ? 1
                                                  : (user.listeningGauge /
                                                      App
                                                          .instance
                                                          .reserved
                                                          .global
                                                          .listeningGauge)),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            start: converter.w(7),
                            top: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: WithAuth(
                                  builder:
                                      (user) => OutlinedText(
                                        "${user.listeningGauge}/${App.instance.reserved.global.listeningGauge}",
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: Colors.white,
                                          fontWeight: FontWeightAlias.semiBold,
                                          fontSize: converter.h(8),
                                          fontStyle: FontStyle.italic,
                                          height: 1,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PositionedDirectional(
                      top: converter.h(88.74),
                      start: converter.w(33),
                      width: converter.w(37 - 2),
                      height: converter.h(16),
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: WithAuth(
                          builder:
                              (user) => OutlinedText(
                                user
                                    .adjustedListeningPower(
                                      App.instance.reserved.global.staminaUse,
                                    )
                                    .toStringAsFixed(1),
                                strokeColor: Colors.black,
                                strokeWidth: converter.h(1),
                                textAlign: TextAlign.end,
                                style: GoogleFonts.inter(
                                  letterSpacing: 0,
                                  color: const Color(0xFF00FF00),
                                  fontWeight: FontWeightAlias.semiBold,
                                  fontSize: converter.h(16),
                                  fontStyle: FontStyle.italic,
                                  height: 1,
                                ),
                              ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: converter.h(68),
                      start: converter.w(124),
                      end: converter.w(133),
                      height: converter.h(22),
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: WithAuth(
                          builder:
                              (user) => OutlinedText(
                                user
                                    .adjustedListeningSsp(
                                      App
                                          .instance
                                          .reserved
                                          .global
                                          .listeningGetSsp,
                                    )
                                    .toString(),
                                strokeColor: Colors.black,
                                strokeWidth: converter.h(1),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  letterSpacing: 0,
                                  color: const Color(0xFF00AFF1),
                                  fontWeight: FontWeightAlias.semiBold,
                                  fontSize: converter.h(18),
                                  fontStyle: FontStyle.italic,
                                  height: 1,
                                ),
                              ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: converter.h(92),
                      start: converter.w(124),
                      end: converter.w(133),
                      height: converter.h(22),
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: WithAuth(
                          builder:
                              (user) => OutlinedText(
                                "${user.adjustedListeningEp(App.instance.reserved.global.listeningGetEp)} / ${user.adjustedListeningEpProb(App.instance.reserved.global.listeningGetEpProba)}%",
                                strokeColor: Colors.black,
                                strokeWidth: converter.h(1),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  letterSpacing: 0,
                                  color: const Color(0xFFE86628),
                                  fontWeight: FontWeightAlias.semiBold,
                                  fontSize: converter.h(18),
                                  fontStyle: FontStyle.italic,
                                  height: 1,
                                ),
                              ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: converter.h(52),
                      end: converter.w(53),
                      width: converter.w(78),
                      height: converter.h(78),
                      child: WithAuth(
                        builder: (user) {
                          final ValueKey<bool> canOpen = ValueKey<bool>(
                            user.canOpenRandomBox,
                          );

                          return Stack(
                            children: [
                              BlocBuilder<ListeningPodBloc, ListeningPodState>(
                                buildWhen:
                                    (previous, current) =>
                                        (previous.randomBoxButtonPressed !=
                                            current.randomBoxButtonPressed),
                                builder:
                                    (context, state) => AnimatedOpacity(
                                      duration: const Duration(
                                        milliseconds: 50,
                                      ),
                                      curve: Curves.easeInOutCubicEmphasized,
                                      opacity:
                                          state.randomBoxButtonPressed
                                              ? 0.4
                                              : 1,
                                      child: KpctSwitcher(
                                        builder:
                                            () => (canOpen.value
                                                    ? Assets
                                                        .component
                                                        .randomBoxCircleButtonEnabled
                                                    : Assets
                                                        .component
                                                        .randomBoxCircleButtonDisabled)
                                                .image(
                                                  key: canOpen,
                                                  width: converter.w(78),
                                                  height: converter.h(78),
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                ),
                                      ),
                                    ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: converter.w(52),
                                  height: converter.h(52),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTapDown:
                                        !canOpen.value
                                            ? null
                                            : (details) => context
                                                .read<ListeningPodBloc>()
                                                .add(
                                                  const ListeningPodEvent.onTapDownRandomBoxButton(),
                                                ),
                                    onTapCancel:
                                        !canOpen.value
                                            ? null
                                            : () => context
                                                .read<ListeningPodBloc>()
                                                .add(
                                                  const ListeningPodEvent.onTapCancelRandomBoxButton(),
                                                ),
                                    onTapUp: (details) async {
                                      context.read<ListeningPodBloc>().add(
                                        const ListeningPodEvent.onTapUpRandomBoxButton(),
                                      );
                                      await RandomBoxModal.show(
                                        context: context,
                                      );
                                    },
                                    // onTapUp: !canOpen.value ? null : (details) async {
                                    //   context.read<ListeningPodBloc>().add(const ListeningPodEvent.onTapUpRandomBoxButton());
                                    //   await RandomBoxModal.show(context: context);
                                    // },
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    PositionedDirectional(
                      top: converter.h(52),
                      end: converter.w(1),
                      width: converter.w(78),
                      height: converter.h(78),
                      child: WithAuth(
                        builder: (user) {
                          final ValueKey<bool> canProcess = ValueKey<bool>(
                            user.listeningGauge ==
                                App.instance.reserved.global.listeningGauge,
                          );

                          return Stack(
                            children: [
                              BlocBuilder<ListeningPodBloc, ListeningPodState>(
                                buildWhen:
                                    (previous, current) =>
                                        (previous
                                                .listeningRewardButtonPressed !=
                                            current
                                                .listeningRewardButtonPressed),
                                builder:
                                    (context, state) => AnimatedOpacity(
                                      duration: const Duration(
                                        milliseconds: 50,
                                      ),
                                      curve: Curves.easeInOutCubicEmphasized,
                                      opacity:
                                          state.randomBoxButtonPressed
                                              ? 0.4
                                              : 1,
                                      child: KpctSwitcher(
                                        builder:
                                            () => (canProcess.value
                                                    ? Assets
                                                        .component
                                                        .listeningGaugeRewardCircleButtonEnabled
                                                    : Assets
                                                        .component
                                                        .listeningGaugeRewardCircleButtonDisabled)
                                                .image(
                                                  key: canProcess,
                                                  width: converter.w(78),
                                                  height: converter.h(78),
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                ),
                                      ),
                                    ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: converter.w(52),
                                  height: converter.h(52),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTapDown:
                                        !canProcess.value
                                            ? null
                                            : (details) => context
                                                .read<ListeningPodBloc>()
                                                .add(
                                                  const ListeningPodEvent.onTapDownListeningRewardButton(),
                                                ),
                                    onTapCancel:
                                        !canProcess.value
                                            ? null
                                            : () => context
                                                .read<ListeningPodBloc>()
                                                .add(
                                                  const ListeningPodEvent.onTapCancelListeningRewardButton(),
                                                ),
                                    onTapUp:
                                        !canProcess.value
                                            ? null
                                            : (details) async {
                                              context.read<ListeningPodBloc>().add(
                                                const ListeningPodEvent.onTapUpListeningRewardButton(),
                                              );
                                              await ListeningRewardModal.launch(
                                                context: context,
                                              );
                                            },
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
          ),
    ),
  );
}
