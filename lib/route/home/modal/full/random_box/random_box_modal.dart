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
import 'package:kpct_radio_app/model/draw.dart';
import 'package:kpct_radio_app/route/home/modal/full/random_box/modal/half/random_box_reward/random_box_reward_modal.dart';
import 'package:kpct_radio_app/route/home/modal/full/random_box/random_box_modal_bloc.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:kpct_radio_app_common/app/misc/utils.dart';

class RandomBoxModal extends StatelessWidget {
  static Future<dynamic> show({required BuildContext context}) async {
    await showMaterialModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const RandomBoxModal._(),
    );
  }

  const RandomBoxModal._();

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            RandomBoxModalBloc()..add(const RandomBoxModalEvent.initialize()),
    child: Builder(
      builder:
          (context) => SafeArea(
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
                                      child: Assets
                                          .component
                                          .consoleTypeTitleRandomBox
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
                                        child: Assets.component.closeButton
                                            .image(
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
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  KpctAspectRatio.padding(
                                    designWidth: designWidth,
                                    designHeight: 162,
                                    designPadding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    builder:
                                        (converter) => Stack(
                                          children: [
                                            Assets.component.freeBox.image(
                                              width: converter.w(365),
                                              height: converter.h(162),
                                            ),
                                            PositionedDirectional(
                                              top: converter.h(44),
                                              start: converter.w(96),
                                              width: converter.w(65),
                                              height: converter.h(65),
                                              child: WithAuth(
                                                builder:
                                                    (user) => StreamBuilder(
                                                      stream: Stream.periodic(
                                                        const Duration(
                                                          seconds: 1,
                                                        ),
                                                      ),
                                                      builder: (
                                                        context,
                                                        snapshot,
                                                      ) {
                                                        final ValueKey<bool>
                                                        canOpen = ValueKey<
                                                          bool
                                                        >(
                                                          user.canOpenRandomBox,
                                                        );

                                                        return KpctCupertinoButton.solid(
                                                          onPressed:
                                                              !canOpen.value
                                                                  ? null
                                                                  : () async =>
                                                                      await RandomBoxRewardModal.launch(
                                                                        context:
                                                                            context,
                                                                        drawId:
                                                                            DrawId.freeRadio,
                                                                      ),
                                                          child: KpctSwitcher(
                                                            builder:
                                                                () => (canOpen
                                                                            .value
                                                                        ? Assets
                                                                            .component
                                                                            .freeBoxRadioButtonEnabled
                                                                        : Assets
                                                                            .component
                                                                            .freeBoxRadioButtonDisabled)
                                                                    .image(
                                                                      key:
                                                                          canOpen,
                                                                      width: converter
                                                                          .h(
                                                                            65,
                                                                          ),
                                                                      height:
                                                                          converter.w(
                                                                            65,
                                                                          ),
                                                                      fit:
                                                                          BoxFit
                                                                              .contain,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                    ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: converter.h(44),
                                              end: converter.w(96),
                                              width: converter.w(65),
                                              height: converter.h(65),
                                              child: WithAuth(
                                                builder:
                                                    (user) => StreamBuilder(
                                                      stream: Stream.periodic(
                                                        const Duration(
                                                          seconds: 1,
                                                        ),
                                                      ),
                                                      builder: (
                                                        context,
                                                        snapshot,
                                                      ) {
                                                        final ValueKey<bool>
                                                        canOpen = ValueKey<
                                                          bool
                                                        >(
                                                          user.canOpenRandomBox,
                                                        );

                                                        return KpctCupertinoButton.solid(
                                                          onPressed:
                                                              !canOpen.value
                                                                  ? null
                                                                  : () async =>
                                                                      await RandomBoxRewardModal.launch(
                                                                        context:
                                                                            context,
                                                                        drawId:
                                                                            DrawId.freeLg,
                                                                      ),
                                                          child: KpctSwitcher(
                                                            builder:
                                                                () => (canOpen
                                                                            .value
                                                                        ? Assets
                                                                            .component
                                                                            .freeBoxListeningGearButtonEnabled
                                                                        : Assets
                                                                            .component
                                                                            .freeBoxListeningGearButtonDisabled)
                                                                    .image(
                                                                      key:
                                                                          canOpen,
                                                                      width: converter
                                                                          .h(
                                                                            65,
                                                                          ),
                                                                      height:
                                                                          converter.w(
                                                                            65,
                                                                          ),
                                                                      fit:
                                                                          BoxFit
                                                                              .contain,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                    ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                              ),
                                            ),

                                            // 230
                                            PositionedDirectional(
                                              bottom: converter.h(19),
                                              start: converter.w(66),
                                              end: converter.w(69),
                                              height: converter.h(14),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          converter.radius(6),
                                                        ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: DecoratedBox(
                                                        decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin:
                                                                Alignment
                                                                    .centerLeft,
                                                            end:
                                                                Alignment
                                                                    .centerRight,
                                                            stops: [0, 0.49],
                                                            colors: [
                                                              Color(0x0012BAF3),
                                                              Color(0xFF8300FF),
                                                            ],
                                                          ),
                                                        ),
                                                        child: WithAuth(
                                                          builder:
                                                              (
                                                                user,
                                                              ) => StreamBuilder(
                                                                stream: Stream.periodic(
                                                                  const Duration(
                                                                    seconds: 1,
                                                                  ),
                                                                ),
                                                                builder: (
                                                                  context,
                                                                  snapshot,
                                                                ) {
                                                                  final double
                                                                  ratio;
                                                                  final bool
                                                                  canOpenRandomBox =
                                                                      user.canOpenRandomBox;
                                                                  if (canOpenRandomBox) {
                                                                    ratio = 1;
                                                                  } else {
                                                                    final inSeconds =
                                                                        user.nextRandomBoxAt
                                                                            .difference(
                                                                              koreaNow(),
                                                                            )
                                                                            .inSeconds;

                                                                    if (inSeconds <
                                                                        daySeconds) {
                                                                      ratio =
                                                                          1 -
                                                                          (inSeconds /
                                                                              daySeconds);
                                                                    } else {
                                                                      ratio = 0;
                                                                    }
                                                                  }

                                                                  return SizedBox(
                                                                    height:
                                                                        converter
                                                                            .h(
                                                                              14,
                                                                            ),
                                                                    width: converter.w(
                                                                      230 *
                                                                          ratio,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: WithAuth(
                                                      builder:
                                                          (
                                                            user,
                                                          ) => StreamBuilder(
                                                            stream:
                                                                Stream.periodic(
                                                                  const Duration(
                                                                    seconds: 1,
                                                                  ),
                                                                ),
                                                            builder: (
                                                              context,
                                                              snapshot,
                                                            ) {
                                                              final String data;
                                                              final bool
                                                              canOpenRandomBox =
                                                                  user.canOpenRandomBox;
                                                              if (canOpenRandomBox) {
                                                                data =
                                                                    "상자를 오픈하세요 !";
                                                              } else {
                                                                data = user
                                                                    .nextRandomBoxAt
                                                                    .difference(
                                                                      koreaNow(),
                                                                    )
                                                                    .formatHMS(
                                                                      padLeft:
                                                                          2,
                                                                      separator:
                                                                          " ",
                                                                      suffixes: (
                                                                        hour:
                                                                            "h",
                                                                        minute:
                                                                            "m",
                                                                        second:
                                                                            "s",
                                                                      ),
                                                                    );
                                                              }

                                                              return OutlinedText(
                                                                data,
                                                                strokeColor:
                                                                    Colors
                                                                        .black,
                                                                strokeWidth:
                                                                    converter.h(
                                                                      1,
                                                                    ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: const Color(
                                                                    0xFFAD4CFB,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .semiBold,
                                                                  fontSize:
                                                                      converter
                                                                          .h(
                                                                            10,
                                                                          ),
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  height: 1,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            PositionedDirectional(
                                              bottom: converter.h(5),
                                              start: converter.hcx(321),
                                              width: converter.w(321),
                                              height: converter.h(12),
                                              child: Text(
                                                "24시간마다 두개의 랜덤박스 중 한개를 선택 가능합니다.",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  letterSpacing: 0,
                                                  color: const Color(
                                                    0xFFAD4CFB,
                                                  ),
                                                  fontWeight:
                                                      FontWeightAlias.regular,
                                                  fontSize: converter.h(10),
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                  const KpctSeparator(
                                    designWidth: designWidth,
                                    designHeight: 20,
                                  ),
                                  KpctAspectRatio.padding(
                                    designWidth: designWidth,
                                    designHeight: 162,
                                    designPadding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    builder:
                                        (converter) => Stack(
                                          children: [
                                            Assets.component.staminaBox.image(
                                              width: converter.w(365),
                                              height: converter.h(162),
                                            ),
                                            PositionedDirectional(
                                              top: converter.h(44),
                                              start: converter.w(74),
                                              width: converter.w(65),
                                              height: converter.h(65),
                                              child: WithAuth(
                                                builder: (user) {
                                                  final ValueKey<bool>
                                                  canOpen = ValueKey<bool>(
                                                    user.consumedStamina >=
                                                        App
                                                            .instance
                                                            .reserved
                                                            .global
                                                            .configuration
                                                            .staminaBoxRequirement,
                                                  );

                                                  return KpctCupertinoButton.solid(
                                                    onPressed:
                                                        !canOpen.value
                                                            ? null
                                                            : () async =>
                                                                await RandomBoxRewardModal.launch(
                                                                  context:
                                                                      context,
                                                                  drawId:
                                                                      DrawId
                                                                          .staminaRadio,
                                                                ),
                                                    child: KpctSwitcher(
                                                      builder:
                                                          () => (canOpen.value
                                                                  ? Assets
                                                                      .component
                                                                      .staminaBoxRadioButtonEnabled
                                                                  : Assets
                                                                      .component
                                                                      .staminaBoxRadioButtonDisabled)
                                                              .image(
                                                                key: canOpen,
                                                                width: converter
                                                                    .h(65),
                                                                height:
                                                                    converter.w(
                                                                      65,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: converter.h(44),
                                              end: converter.w(74),
                                              width: converter.w(65),
                                              height: converter.h(65),
                                              child: WithAuth(
                                                builder: (user) {
                                                  final ValueKey<bool>
                                                  canOpen = ValueKey<bool>(
                                                    user.consumedStamina >=
                                                        App
                                                            .instance
                                                            .reserved
                                                            .global
                                                            .configuration
                                                            .staminaBoxRequirement,
                                                  );

                                                  return KpctCupertinoButton.solid(
                                                    onPressed:
                                                        !canOpen.value
                                                            ? null
                                                            : () async =>
                                                                await RandomBoxRewardModal.launch(
                                                                  context:
                                                                      context,
                                                                  drawId:
                                                                      DrawId
                                                                          .staminaLg,
                                                                ),
                                                    child: KpctSwitcher(
                                                      builder:
                                                          () => (canOpen.value
                                                                  ? Assets
                                                                      .component
                                                                      .staminaBoxListeningGearButtonEnabled
                                                                  : Assets
                                                                      .component
                                                                      .staminaBoxListeningGearButtonDisabled)
                                                              .image(
                                                                key: canOpen,
                                                                width: converter
                                                                    .h(65),
                                                                height:
                                                                    converter.w(
                                                                      65,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),

                                            // 230
                                            PositionedDirectional(
                                              bottom: converter.h(19),
                                              start: converter.w(66),
                                              end: converter.w(69),
                                              height: converter.h(14),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          converter.radius(6),
                                                        ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: DecoratedBox(
                                                        decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin:
                                                                Alignment
                                                                    .centerLeft,
                                                            end:
                                                                Alignment
                                                                    .centerRight,
                                                            stops: [0, 0.49],
                                                            colors: [
                                                              Color(0x0012BAF3),
                                                              Color(0xFF00FF84),
                                                            ],
                                                          ),
                                                        ),
                                                        child: WithAuth(
                                                          builder:
                                                              (
                                                                user,
                                                              ) => SizedBox(
                                                                height:
                                                                    converter.h(
                                                                      14,
                                                                    ),
                                                                width: converter.w(
                                                                  230 *
                                                                      (user.consumedStamina.clamp2(
                                                                            min:
                                                                                0,
                                                                            max:
                                                                                App.instance.reserved.global.configuration.staminaBoxRequirement,
                                                                          ) /
                                                                          App
                                                                              .instance
                                                                              .reserved
                                                                              .global
                                                                              .configuration
                                                                              .staminaBoxRequirement),
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: WithAuth(
                                                      builder:
                                                          (
                                                            user,
                                                          ) => OutlinedText(
                                                            "소모한 스테미너 ${user.consumedStamina.clamp2(min: 0, max: App.instance.reserved.global.configuration.staminaBoxRequirement)} / ${App.instance.reserved.global.configuration.staminaBoxRequirement}",
                                                            strokeColor:
                                                                Colors.black,
                                                            strokeWidth:
                                                                converter.h(1),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  const Color(
                                                                    0xFF00AF5A,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .semiBold,
                                                              fontSize:
                                                                  converter.h(
                                                                    10,
                                                                  ),
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              height: 1,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            PositionedDirectional(
                                              bottom: converter.h(5),
                                              start: converter.hcx(321),
                                              width: converter.w(321),
                                              height: converter.h(12),
                                              child: Text(
                                                "소모한 스태미너로 아이템을 구매할 수 있습니다.",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  letterSpacing: 0,
                                                  color: const Color(
                                                    0xFF00AF5A,
                                                  ),
                                                  fontWeight:
                                                      FontWeightAlias.regular,
                                                  fontSize: converter.h(10),
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                  const KpctSeparator(
                                    designWidth: designWidth,
                                    designHeight: 20,
                                  ),
                                  KpctAspectRatio.padding(
                                    designWidth: designWidth,
                                    designHeight: 162,
                                    designPadding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    builder:
                                        (converter) => Stack(
                                          children: [
                                            Assets.component.sspBox.image(
                                              width: converter.w(365),
                                              height: converter.h(162),
                                            ),
                                            PositionedDirectional(
                                              top: converter.h(44),
                                              start: converter.w(74),
                                              width: converter.w(65),
                                              height: converter.h(65),
                                              child: WithAuth(
                                                builder: (user) {
                                                  final ValueKey<bool>
                                                  canOpen = ValueKey<bool>(
                                                    user.radioSsp >=
                                                        App
                                                            .instance
                                                            .reserved
                                                            .global
                                                            .configuration
                                                            .sspBoxRequirement,
                                                  );

                                                  return KpctCupertinoButton.solid(
                                                    onPressed:
                                                        !canOpen.value
                                                            ? null
                                                            : () async =>
                                                                await RandomBoxRewardModal.launch(
                                                                  context:
                                                                      context,
                                                                  drawId:
                                                                      DrawId
                                                                          .sspRadio,
                                                                ),
                                                    child: KpctSwitcher(
                                                      builder:
                                                          () => (canOpen.value
                                                                  ? Assets
                                                                      .component
                                                                      .sspBoxRadioButtonEnabled
                                                                  : Assets
                                                                      .component
                                                                      .sspBoxRadioButtonDisabled)
                                                              .image(
                                                                key: canOpen,
                                                                width: converter
                                                                    .h(65),
                                                                height:
                                                                    converter.w(
                                                                      65,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: converter.h(44),
                                              end: converter.w(74),
                                              width: converter.w(65),
                                              height: converter.h(65),
                                              child: WithAuth(
                                                builder: (user) {
                                                  final ValueKey<bool>
                                                  canOpen = ValueKey<bool>(
                                                    user.radioSsp >=
                                                        App
                                                            .instance
                                                            .reserved
                                                            .global
                                                            .configuration
                                                            .sspBoxRequirement,
                                                  );

                                                  return KpctCupertinoButton.solid(
                                                    onPressed:
                                                        !canOpen.value
                                                            ? null
                                                            : () async =>
                                                                await RandomBoxRewardModal.launch(
                                                                  context:
                                                                      context,
                                                                  drawId:
                                                                      DrawId
                                                                          .sspLg,
                                                                ),
                                                    child: KpctSwitcher(
                                                      builder:
                                                          () => (canOpen.value
                                                                  ? Assets
                                                                      .component
                                                                      .sspBoxListeningGearButtonEnabled
                                                                  : Assets
                                                                      .component
                                                                      .sspBoxListeningGearButtonDisabled)
                                                              .image(
                                                                key: canOpen,
                                                                width: converter
                                                                    .h(65),
                                                                height:
                                                                    converter.w(
                                                                      65,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),

                                            // 110
                                            PositionedDirectional(
                                              bottom: converter.h(19),
                                              start: converter.w(51),
                                              end: converter.w(204),
                                              height: converter.h(14),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          converter.radius(6),
                                                        ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: DecoratedBox(
                                                        decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin:
                                                                Alignment
                                                                    .centerLeft,
                                                            end:
                                                                Alignment
                                                                    .centerRight,
                                                            stops: [0, 0.49],
                                                            colors: [
                                                              Color(0x0012BAF3),
                                                              Color(0xFF00EAFF),
                                                            ],
                                                          ),
                                                        ),
                                                        child: WithAuth(
                                                          builder:
                                                              (
                                                                user,
                                                              ) => SizedBox(
                                                                height:
                                                                    converter.h(
                                                                      14,
                                                                    ),
                                                                width: converter.w(
                                                                  110 *
                                                                      (user.radioSsp.clamp2(
                                                                            min:
                                                                                0,
                                                                            max:
                                                                                App.instance.reserved.global.configuration.sspBoxRequirement,
                                                                          ) /
                                                                          App
                                                                              .instance
                                                                              .reserved
                                                                              .global
                                                                              .configuration
                                                                              .sspBoxRequirement),
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: WithAuth(
                                                      builder:
                                                          (
                                                            user,
                                                          ) => OutlinedText(
                                                            "SSP ${user.radioSsp.clamp2(min: 0, max: App.instance.reserved.global.configuration.sspBoxRequirement)} / ${App.instance.reserved.global.configuration.sspBoxRequirement}",
                                                            strokeColor:
                                                                Colors.black,
                                                            strokeWidth:
                                                                converter.h(1),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  const Color(
                                                                    0xFF00EAFF,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .semiBold,
                                                              fontSize:
                                                                  converter.h(
                                                                    10,
                                                                  ),
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              height: 1,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // 110
                                            PositionedDirectional(
                                              bottom: converter.h(19),
                                              start: converter.w(204),
                                              end: converter.w(51),
                                              height: converter.h(14),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          converter.radius(6),
                                                        ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: DecoratedBox(
                                                        decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin:
                                                                Alignment
                                                                    .centerLeft,
                                                            end:
                                                                Alignment
                                                                    .centerRight,
                                                            stops: [0, 0.49],
                                                            colors: [
                                                              Color(0x0012BAF3),
                                                              Color(0xFF00EAFF),
                                                            ],
                                                          ),
                                                        ),
                                                        child: WithAuth(
                                                          builder:
                                                              (
                                                                user,
                                                              ) => SizedBox(
                                                                height:
                                                                    converter.h(
                                                                      14,
                                                                    ),
                                                                width: converter.w(
                                                                  110 *
                                                                      (user.radioSsp.clamp2(
                                                                            min:
                                                                                0,
                                                                            max:
                                                                                App.instance.reserved.global.configuration.sspBoxRequirement,
                                                                          ) /
                                                                          App
                                                                              .instance
                                                                              .reserved
                                                                              .global
                                                                              .configuration
                                                                              .sspBoxRequirement),
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: WithAuth(
                                                      builder:
                                                          (
                                                            user,
                                                          ) => OutlinedText(
                                                            "SSP ${user.radioSsp.clamp2(min: 0, max: App.instance.reserved.global.configuration.sspBoxRequirement)} / ${App.instance.reserved.global.configuration.sspBoxRequirement}",
                                                            strokeColor:
                                                                Colors.black,
                                                            strokeWidth:
                                                                converter.h(1),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  const Color(
                                                                    0xFF00EAFF,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .semiBold,
                                                              fontSize:
                                                                  converter.h(
                                                                    10,
                                                                  ),
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              height: 1,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            PositionedDirectional(
                                              bottom: converter.h(5),
                                              start: converter.hcx(321),
                                              width: converter.w(321),
                                              height: converter.h(12),
                                              child: Text(
                                                "보유한 SSP로 아이템을 구매할 수 있습니다.",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  letterSpacing: 0,
                                                  color: const Color(
                                                    0xFF00EAFF,
                                                  ),
                                                  fontWeight:
                                                      FontWeightAlias.regular,
                                                  fontSize: converter.h(10),
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                  const KpctSeparator(
                                    designWidth: designWidth,
                                    designHeight: 20,
                                  ),
                                  KpctAspectRatio.padding(
                                    designWidth: designWidth,
                                    designHeight: 162,
                                    designPadding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    builder:
                                        (converter) => Stack(
                                          children: [
                                            Assets.component.epBox.image(
                                              width: converter.w(365),
                                              height: converter.h(162),
                                            ),
                                            PositionedDirectional(
                                              top: converter.h(44),
                                              start: converter.hcx(65),
                                              width: converter.w(65),
                                              height: converter.h(65),
                                              child: WithAuth(
                                                builder: (user) {
                                                  final ValueKey<bool>
                                                  canOpen = ValueKey<bool>(
                                                    user.ep >=
                                                        App
                                                            .instance
                                                            .reserved
                                                            .global
                                                            .configuration
                                                            .epBoxRequirement,
                                                  );

                                                  return KpctCupertinoButton.solid(
                                                    onPressed:
                                                        !canOpen.value
                                                            ? null
                                                            : () async =>
                                                                await RandomBoxRewardModal.launch(
                                                                  context:
                                                                      context,
                                                                  drawId:
                                                                      DrawId
                                                                          .epBox,
                                                                ),
                                                    child: KpctSwitcher(
                                                      builder:
                                                          () => (canOpen.value
                                                                  ? Assets
                                                                      .component
                                                                      .epBoxButtonEnabled
                                                                  : Assets
                                                                      .component
                                                                      .epBoxButtonDisabled)
                                                              .image(
                                                                key: canOpen,
                                                                width: converter
                                                                    .h(65),
                                                                height:
                                                                    converter.w(
                                                                      65,
                                                                    ),
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),

                                            // 110
                                            PositionedDirectional(
                                              bottom: converter.h(19),
                                              start: converter.w(128),
                                              end: converter.w(127),
                                              height: converter.h(14),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          converter.radius(6),
                                                        ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: DecoratedBox(
                                                        decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin:
                                                                Alignment
                                                                    .centerLeft,
                                                            end:
                                                                Alignment
                                                                    .centerRight,
                                                            stops: [0, 0.49],
                                                            colors: [
                                                              Color(0x0012BAF3),
                                                              Color(0xFFFF7A3B),
                                                            ],
                                                          ),
                                                        ),
                                                        child: WithAuth(
                                                          builder:
                                                              (
                                                                user,
                                                              ) => SizedBox(
                                                                height:
                                                                    converter.h(
                                                                      14,
                                                                    ),
                                                                width: converter.w(
                                                                  110 *
                                                                      (user.ep.clamp2(
                                                                            min:
                                                                                0,
                                                                            max:
                                                                                App.instance.reserved.global.configuration.epBoxRequirement,
                                                                          ) /
                                                                          App
                                                                              .instance
                                                                              .reserved
                                                                              .global
                                                                              .configuration
                                                                              .epBoxRequirement),
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: WithAuth(
                                                      builder:
                                                          (
                                                            user,
                                                          ) => OutlinedText(
                                                            "EP ${user.ep.clamp2(min: 0, max: App.instance.reserved.global.configuration.epBoxRequirement)} / ${App.instance.reserved.global.configuration.epBoxRequirement}",
                                                            strokeColor:
                                                                Colors.black,
                                                            strokeWidth:
                                                                converter.h(1),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  const Color(
                                                                    0xFFFF7A3B,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .semiBold,
                                                              fontSize:
                                                                  converter.h(
                                                                    10,
                                                                  ),
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              height: 1,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            PositionedDirectional(
                                              bottom: converter.h(5),
                                              start: converter.hcx(321),
                                              width: converter.w(321),
                                              height: converter.h(12),
                                              child: Text(
                                                "보유한 EP로 아이템을 구매할 수 있습니다.",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  letterSpacing: 0,
                                                  color: const Color(
                                                    0xFFFF7A3B,
                                                  ),
                                                  fontWeight:
                                                      FontWeightAlias.regular,
                                                  fontSize: converter.h(10),
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                  const KpctSeparator(
                                    designWidth: designWidth,
                                    designHeight: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ),
          ),
    ),
  );
}
