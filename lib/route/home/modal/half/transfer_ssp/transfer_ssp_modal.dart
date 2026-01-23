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
import 'package:kpct_radio_app/route/home/modal/half/transfer_ssp/transfer_ssp_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/transfer_ssp/transfer_ssp_modal_misc.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';

enum TransferSspModalResponse { success }

class TransferSspModal extends StatelessWidget {
  final int ssp;

  static Future<dynamic> launch({
    required BuildContext context,
    required int ssp,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TransferSspModal(ssp: ssp),
    );
  }

  const TransferSspModal({required this.ssp, super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            TransferSspModalBloc(ssp: ssp)
              ..add(const TransferSspModalEvent.initialize()),
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
                          TransferSspModalBloc,
                          TransferSspModalState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  (previous.status != current.status),
                          builder:
                              (context, state) => WithAuth(
                                builder: (user) {
                                  return Stack(
                                    children: [
                                      KpctSwitcher(
                                        builder:
                                            () => Assets.background.halfModal
                                                .image(
                                                  key: ValueKey<
                                                    TransferSspModalStatus
                                                  >(state.status),
                                                  width:
                                                      converter.realSize.width,
                                                  height:
                                                      converter.realSize.height,
                                                  fit: BoxFit.contain,
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
                                                      TransferSspModalStatus
                                                          .prepare)
                                                  ? 0
                                                  : 1,
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
                                            "TRANSFER SSP",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              letterSpacing: 0,
                                              fontStyle: FontStyle.italic,
                                              color: const Color(0xFF13BE13),
                                              fontWeight: FontWeightAlias.bold,
                                              fontSize: converter.h(20),
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      PositionedDirectional(
                                        top: converter.h(64),
                                        start: 0,
                                        end: 0,
                                        child: AnimatedOpacity(
                                          opacity:
                                              (state.status ==
                                                      TransferSspModalStatus
                                                          .prepare)
                                                  ? 1
                                                  : 0,
                                          duration: defaultAnimationDuration,
                                          curve: defaultAnimationCurve,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              "HOD로 SSP를 전송하시겠습니까?",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                letterSpacing: 0,
                                                fontStyle: FontStyle.normal,
                                                color: const Color(0xFF24E85B),
                                                fontWeight:
                                                    FontWeightAlias.bold,
                                                fontSize: converter.h(16),
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      PositionedDirectional(
                                        top: converter.h(136),
                                        start: converter.w(35),
                                        end: converter.w(34),
                                        height: converter.h(20),
                                        child: AnimatedOpacity(
                                          opacity:
                                              (state.status ==
                                                          TransferSspModalStatus
                                                              .success) ||
                                                      (state.status ==
                                                          TransferSspModalStatus
                                                              .fail)
                                                  ? 1
                                                  : 0,
                                          duration: defaultAnimationDuration,
                                          curve: defaultAnimationCurve,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              switch (state.result) {
                                                null => '',
                                                '' => '완료',
                                                _ => state.result ?? '',
                                              },
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                letterSpacing: 0,
                                                fontStyle: FontStyle.normal,
                                                color: const Color(0xFF24E85B),
                                                fontWeight:
                                                    FontWeightAlias.bold,
                                                fontSize: converter.h(16),
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
                                                TransferSspModalStatus
                                                    .prepare) {
                                              return SizedBox(
                                                key: ValueKey<bool>(
                                                  state.status ==
                                                      TransferSspModalStatus
                                                          .prepare,
                                                ),
                                              );
                                            } else {
                                              return Align(
                                                key: ValueKey<bool>(
                                                  state.status ==
                                                      TransferSspModalStatus
                                                          .prepare,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        converter.radius(4),
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
                                                        stops: const [0.49, 1],
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
                                                      TransferSspModalBloc,
                                                      TransferSspModalState
                                                    >(
                                                      buildWhen:
                                                          (previous, current) =>
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
                                                            height: converter.h(
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
                                        top: converter.h(146),
                                        start: converter.hcx(42),
                                        width: converter.w(42),
                                        height: converter.h(57),
                                        child: KpctSwitcher(
                                          builder: () {
                                            if (state.status ==
                                                TransferSspModalStatus
                                                    .prepare) {
                                              return Stack(
                                                key: ValueKey<bool>(
                                                  state.status ==
                                                      TransferSspModalStatus
                                                          .prepare,
                                                ),
                                                children: [
                                                  Assets.component.sspIcon
                                                      .image(
                                                        width: converter.w(42),
                                                        height: converter.h(42),
                                                        fit: BoxFit.contain,
                                                      ),
                                                  PositionedDirectional(
                                                    end: converter.w(3),
                                                    bottom: converter.h(17),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: OutlinedText(
                                                        ssp.toString(),
                                                        strokeColor:
                                                            Colors.black,
                                                        strokeWidth: converter
                                                            .h(1),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.inter(
                                                          letterSpacing: 0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeightAlias
                                                                  .semiBold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: converter.h(
                                                            8,
                                                          ),
                                                          height: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "SSP",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        letterSpacing: 0,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: const Color(
                                                          0xFF24BD24,
                                                        ),
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .regular,
                                                        fontSize: converter.h(
                                                          10,
                                                        ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return SizedBox(
                                                key: ValueKey<bool>(
                                                  state.status ==
                                                      TransferSspModalStatus
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
                                                TransferSspModalStatus
                                                    .prepare) {
                                              return KpctCupertinoButton.solid(
                                                key: ValueKey<bool>(
                                                  state.status ==
                                                      TransferSspModalStatus
                                                          .prepare,
                                                ),
                                                onPressed:
                                                    () => context
                                                        .read<
                                                          TransferSspModalBloc
                                                        >()
                                                        .add(
                                                          const TransferSspModalEvent.action(),
                                                        ),
                                                child: Assets
                                                    .component
                                                    .transferCircleButton
                                                    .image(
                                                      width: converter.w(54),
                                                      height: converter.h(57),
                                                      fit: BoxFit.contain,
                                                    ),
                                              );
                                            } else {
                                              return SizedBox(
                                                key: ValueKey<bool>(
                                                  state.status ==
                                                      TransferSspModalStatus
                                                          .prepare,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      AnimatedPositionedDirectional(
                                        duration: defaultAnimationDuration,
                                        curve: defaultAnimationCurve,
                                        end:
                                            state.status ==
                                                    TransferSspModalStatus
                                                        .prepare
                                                ? converter.w(89)
                                                : converter.hcx(54),
                                        bottom: converter.h(7),
                                        width: converter.w(54),
                                        height: converter.h(57),
                                        child: KpctSwitcher(
                                          builder: () {
                                            if (state.status ==
                                                TransferSspModalStatus
                                                    .prepare) {
                                              return KpctCupertinoButton.solid(
                                                key: ValueKey<
                                                  TransferSspModalStatus
                                                >(state.status),
                                                onPressed:
                                                    () =>
                                                        Navigator.pop(context),
                                                child: Assets
                                                    .component
                                                    .cancelCircleButton
                                                    .image(
                                                      width: converter.w(54),
                                                      height: converter.h(57),
                                                      fit: BoxFit.contain,
                                                    ),
                                              );
                                            } else {
                                              if (state.status ==
                                                  TransferSspModalStatus
                                                      .processing) {
                                                return KpctCupertinoButton.solid(
                                                  key: ValueKey<
                                                    TransferSspModalStatus
                                                  >(state.status),
                                                  onPressed: null,
                                                  child: Assets
                                                      .component
                                                      .closeCircleButtonDisabled
                                                      .image(
                                                        width: converter.w(54),
                                                        height: converter.h(57),
                                                        fit: BoxFit.contain,
                                                      ),
                                                );
                                              } else {
                                                return KpctCupertinoButton.solid(
                                                  key: ValueKey<
                                                    TransferSspModalStatus
                                                  >(state.status),
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                      ),
                                                  child: Assets
                                                      .component
                                                      .closeCircleButtonEnabled
                                                      .image(
                                                        width: converter.w(54),
                                                        height: converter.h(57),
                                                        fit: BoxFit.contain,
                                                      ),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  );
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
