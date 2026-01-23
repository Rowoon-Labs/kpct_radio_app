import 'dart:async';

import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/level.dart';
import 'package:kpct_radio_app/route/home/modal/full/setting/setting_modal.dart';
import 'package:kpct_radio_app/route/home/modal/half/level_up/level_up_modal.dart';
import 'package:kpct_radio_app/route/home/modal/half/overcome/overcome_modal.dart';
import 'package:kpct_radio_app/route/home/modal/half/take_ssp/take_ssp_modal.dart';
import 'package:kpct_radio_app/route/home/modal/half/transfer_ssp/transfer_ssp_modal.dart';
import 'package:kpct_radio_app/route/home/page/status/status_page_bloc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatefulWidget> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _StatusPage();
  }
}

class _StatusPage extends StatelessWidget {
  const _StatusPage();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder:
        (context, constraints) => Stack(
          children: [
            Assets.background.common.image(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  KpctAspectRatio(
                    designWidth: designWidth,
                    designHeight: 30,
                    builder:
                        (converter) => Stack(
                          children: [
                            PositionedDirectional(
                              top: converter.h(4.88),
                              start: converter.w(5),
                              width: converter.w(126),
                              height: converter.h(21),
                              child: Assets.component.consoleTypeTitleStatus
                                  .image(
                                    width: converter.w(126),
                                    height: converter.h(21),
                                    // fit: BoxFit.cover,
                                  ),
                            ),
                            PositionedDirectional(
                              top: converter.h(3),
                              end: converter.w(6),
                              width: converter.w(23),
                              height: converter.h(23),
                              child: KpctCupertinoButton(
                                // onPressed: () => Navigator.pop(context),
                                onPressed:
                                    () async =>
                                        await showMaterialModalBottomSheet(
                                          context: context,
                                          enableDrag: false,
                                          isDismissible: false,
                                          backgroundColor: Colors.transparent,
                                          builder:
                                              (context) => const SettingModal(),
                                        ),
                                alignment: Alignment.topCenter,
                                child: Assets.component.settingButton.image(
                                  width: converter.w(23),
                                  height: converter.h(23),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 161,
                    designPadding: const EdgeInsets.only(left: 6, right: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusSummary.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(9),
                              start: converter.w(8),
                              width: converter.w(60),
                              height: converter.h(60),
                              child: WithAuth(
                                builder:
                                    (user) => Center(
                                      child: KpctSwitcher(
                                        builder: () {
                                          if (user.profileImageUrl != null) {
                                            return PhysicalModel(
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.transparent,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                converter.radius(4),
                                              ),
                                              child: CachedNetworkImage(
                                                key: const ValueKey<String>(
                                                  "hasProfileImage",
                                                ),
                                                imageUrl: user.profileImageUrl!,
                                                width: converter.w(55),
                                                height: converter.h(55),
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          } else {
                                            return const SizedBox(
                                              key: ValueKey<String>(
                                                "noProfileImage",
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(96),
                              end: converter.w(16),
                              width: converter.w(36),
                              height: converter.h(38),
                              child: WithAuth(
                                builder:
                                    (user) => KpctSwitcher(
                                      builder: () {
                                        final bool canPress =
                                            user.exp >= user.maxExp;
                                        final Level? nextLevel = App
                                            .instance
                                            .reserved
                                            .nextLevel(level: user.level);

                                        if (nextLevel != null) {
                                          if ((nextLevel.limitProbability ==
                                                  0) ||
                                              user.overcomeLevels.contains(
                                                nextLevel.level,
                                              )) {
                                            return KpctCupertinoButton(
                                              key: ValueKey<String>(
                                                "normal-$canPress",
                                              ),
                                              onPressed:
                                                  !canPress
                                                      ? null
                                                      : () =>
                                                          LevelUpModal.launch(
                                                            context: context,
                                                          ),
                                              child: (canPress
                                                      ? Assets
                                                          .component
                                                          .levelUpCircleButtonEnabled
                                                      : Assets
                                                          .component
                                                          .levelUpCircleButtonDisabled)
                                                  .image(
                                                    width: converter.w(36),
                                                    height: converter.h(38),
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.contain,
                                                  ),
                                            );
                                          } else {
                                            return KpctCupertinoButton(
                                              key: ValueKey<String>(
                                                "limited-$canPress",
                                              ),
                                              onPressed:
                                                  !canPress
                                                      ? null
                                                      : () =>
                                                          OvercomeModal.launch(
                                                            context: context,
                                                          ),
                                              child: (canPress
                                                      ? Assets
                                                          .component
                                                          .overcomeCircleButtonEnabled
                                                      : Assets
                                                          .component
                                                          .overcomeCircleButtonDisabled)
                                                  .image(
                                                    width: converter.w(36),
                                                    height: converter.h(38),
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.contain,
                                                  ),
                                            );
                                          }
                                        } else {
                                          return SizedBox.shrink(
                                            key: ValueKey<bool>(
                                              nextLevel != null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(43),
                              start: converter.w(94),
                              end: converter.w(9),
                              height: converter.h(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  converter.radius(4),
                                ),
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
                                          Color(0xFFEAF37F),
                                        ],
                                      ),
                                    ),
                                    child: WithAuth(
                                      builder:
                                          (user) => SizedBox(
                                            height: converter.h(8),
                                            width: converter.w(
                                              261 *
                                                  ((user.exp == user.maxExp)
                                                      ? 1
                                                      : (user.exp /
                                                          user.maxExp)),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(15),
                              start: converter.w(117),
                              end: converter.w(177),
                              height: converter.h(24),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: OutlinedText(
                                        user.level.toString().padLeft(3, "0"),
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF00FF00),
                                          fontWeight: FontWeightAlias.semiBold,
                                          fontSize: converter.h(20),
                                          fontStyle: FontStyle.italic,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(29),
                              start: converter.w(255),
                              end: converter.w(9),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerRight,
                                      child: OutlinedText(
                                        "EXP ${user.exp.truncate()} / ${user.maxExp.truncate()}",
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF13B0EC),
                                          fontWeight: FontWeightAlias.semiBold,
                                          fontSize: converter.h(8),
                                          // fontStyle: FontStyle.italic,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(60),
                              start: converter.w(111),
                              end: converter.w(9),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: OutlinedText(
                                        user.walletAddress ?? "지갑 없음",
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF13B0EC),
                                          fontWeight: FontWeightAlias.semiBold,
                                          fontSize: converter.h(8),
                                          // fontStyle: FontStyle.italic,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(91),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: OutlinedText(
                                        user.email,
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF13B0EC),
                                          fontWeight: FontWeightAlias.semiBold,
                                          fontSize: converter.h(8),
                                          // fontStyle: FontStyle.italic,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(110),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "가입날짜",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          DateFormat(
                                            "yyyy.MM.dd",
                                          ).format(user.createdAt),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(129),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "총 획득 SSP",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.accumulatedRadioSsp.toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(108),
                              start: converter.w(195),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "플레이타임",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user
                                              .accumulatedPlayDuration
                                              .formatUnderHourSingleMax,
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(127),
                              start: converter.w(195),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "총 획득 EP",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.accumulatedEp.toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  const KpctSeparator(
                    designWidth: designWidth,
                    designHeight: 7,
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 69,
                    designPadding: const EdgeInsets.only(left: 6, right: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusReferral.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(28),
                              start: converter.w(118),
                              end: converter.w(114),
                              height: converter.h(24),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        child: OutlinedText(
                                          user.referralCode ?? "레퍼럴 코드 없음",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF00FF00),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(20),
                                            fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(20),
                              end: converter.w(58),
                              width: converter.w(36),
                              height: converter.h(38),
                              child: WithAuth(
                                builder:
                                    (user) => KpctSwitcher(
                                      builder:
                                          () => KpctCupertinoButton(
                                            key: ValueKey<bool>(
                                              user.referralCode == null,
                                            ),
                                            onPressed:
                                                (user.referralCode == null)
                                                    ? null
                                                    : () => Clipboard.setData(
                                                      ClipboardData(
                                                        text:
                                                            user.referralCode ??
                                                            "",
                                                      ),
                                                    ),
                                            child: (user.referralCode == null
                                                    ? Assets
                                                        .component
                                                        .copyCircleDisabledButton
                                                    : Assets
                                                        .component
                                                        .copyCircleEnabledButton)
                                                .image(
                                                  width: converter.w(36),
                                                  height: converter.h(38),
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 149,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusSsp.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(30),
                              start: converter.w(79),
                              end: converter.w(141),
                              height: converter.h(24),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        user.radioSsp.toString(),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF02D7FF),
                                          fontWeight: FontWeightAlias.black,
                                          fontSize: converter.h(20),
                                          fontStyle: FontStyle.italic,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(97),
                              start: converter.w(15),
                              end: converter.w(57),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "HoD 계정에 보유한 SSP를\nRadio App 으로 가져옵니다.",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                    letterSpacing: 0,
                                    color: const Color(0xFF06FF98),
                                    fontWeight: FontWeightAlias.regular,
                                    fontSize: converter.h(8),
                                    fontStyle: FontStyle.normal,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(92),
                              end: converter.w(192),
                              width: converter.w(36),
                              height: converter.h(38),
                              child: BlocBuilder<
                                StatusPageBloc,
                                StatusPageState
                              >(
                                buildWhen:
                                    (previous, current) =>
                                        (previous.tryingTakeSsp !=
                                            current.tryingTakeSsp),
                                builder:
                                    (context, state) => KpctCupertinoButton(
                                      // key: ValueKey<bool>(state.tryingTakeSsp),
                                      key: const ValueKey<bool>(
                                        false,
                                      ), // FGT때는 전송 기능 막음
                                      onPressed: () async {
                                        if (!state.tryingTakeSsp) {
                                          final Completer<int?> completer =
                                              Completer();

                                          context.read<StatusPageBloc>().add(
                                            StatusPageEvent.tryTakeSsp(
                                              completer: completer,
                                            ),
                                          );

                                          await completer.future.then((
                                            value,
                                          ) async {
                                            if (value != null) {
                                              await TakeSspModal.launch(
                                                context: context,
                                                hodSsp: value,
                                              );
                                            }
                                          });
                                        }
                                      },
                                      child: switch (state.tryingTakeSsp) {
                                        true => SizedBox.square(
                                          dimension: converter.average(12),
                                          child:
                                              const CustomCircularProgressIndicator(),
                                        ),
                                        false => Assets
                                            .component
                                            .transCircleEnabledButton
                                            .image(
                                              width: converter.w(36),
                                              height: converter.h(38),
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                            ),
                                      },
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(97),
                              start: converter.w(194),
                              end: converter.w(57),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "획득한 SSP를 모두 HoD 계정으로 전송합니다. 전송한 SSP는 HoD에서 claim 할 수 있습니다.",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                    letterSpacing: 0,
                                    color: const Color(0xFF06FF98),
                                    fontWeight: FontWeightAlias.regular,
                                    fontSize: converter.h(8),
                                    fontStyle: FontStyle.normal,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(92),
                              end: converter.w(15),
                              width: converter.w(36),
                              height: converter.h(38),
                              child: WithAuth(
                                builder:
                                    (user) => KpctSwitcher(
                                      builder:
                                          () => KpctCupertinoButton(
                                            key: ValueKey<bool>(
                                              user.radioSsp <= 0,
                                            ),
                                            onPressed:
                                                // user.radioSsp <= 0
                                                //     ? null
                                                //     : () => TransferSspModal.launch(
                                                //           context: context,
                                                //           ssp: user.radioSsp,
                                                //         ),
                                                null, // FGT때는 전송기능 막음
                                            child: (
                                                // user.radioSsp <= 0
                                                //       ? Assets
                                                //           .component.transCircleDisabledButton
                                                //       : Assets
                                                //           .component.transCircleEnabledButton
                                                Assets
                                                    .component
                                                    .transCircleDisabledButton) // FGT때는 전송기능 막음
                                                .image(
                                                  width: converter.w(36),
                                                  height: converter.h(38),
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 149,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusListeningPower.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(30),
                              start: converter.w(79),
                              end: converter.w(141),
                              height: converter.h(24),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                              user
                                                  .adjustedListeningPower(
                                                    App
                                                        .instance
                                                        .reserved
                                                        .global
                                                        .staminaUse,
                                                  )
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.inter(
                                                letterSpacing: 0,
                                                color: const Color(0xFF02D7FF),
                                                fontWeight:
                                                    FontWeightAlias.black,
                                                fontSize: converter.h(20),
                                                fontStyle: FontStyle.italic,
                                                height: 1,
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: Colors.transparent,
                                              width: converter.w(6),
                                              thickness: 0,
                                            ),
                                            OutlinedText(
                                              "/ second",
                                              strokeColor: Colors.black,
                                              strokeWidth: converter.h(1),
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.inter(
                                                letterSpacing: 0,
                                                color: const Color(0xFF13B0EC),
                                                fontWeight:
                                                    FontWeightAlias.regular,
                                                fontSize: converter.h(10),
                                                // fontStyle: FontStyle.italic,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(90),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기본",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          App
                                              .instance
                                              .reserved
                                              .global
                                              .staminaUse
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(105),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝기어",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningPowerListeningGear
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(120),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기타",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningPowerEtc
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(105),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "라디오스킨",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningPowerRadioSkin
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(120),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "악세서리",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningPowerAccessory
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 78,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusRow.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝완료시 획득 SSP",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user
                                              .adjustedListeningSsp(
                                                App
                                                    .instance
                                                    .reserved
                                                    .global
                                                    .listeningGetSsp,
                                              )
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "라디오스킨",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningSspRadioSkin
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "악세서리",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningSspAccessory
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기본",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user
                                              .adjustedListeningSsp(
                                                App
                                                    .instance
                                                    .reserved
                                                    .global
                                                    .listeningGetSsp,
                                              )
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝기어",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningSspListeningGear
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기타",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningSspEtc
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 78,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusRow.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝완료시 획득 EP",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user
                                              .adjustedListeningEp(
                                                App
                                                    .instance
                                                    .reserved
                                                    .global
                                                    .listeningGetEp,
                                              )
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "라디오스킨",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningEpRadioSkin
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "악세서리",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningEpAccessory
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기본",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user
                                              .adjustedListeningEp(
                                                App
                                                    .instance
                                                    .reserved
                                                    .global
                                                    .listeningGetEp,
                                              )
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝기어",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningEpListeningGear
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기타",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedListeningEpEtc
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 78,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusRow.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝완료시 EP 획득 확률",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          "${user.adjustedListeningEpProb(App.instance.reserved.global.listeningGetEpProba)}%",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "라디오스킨",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          "0%",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "악세서리",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          "0%",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기본",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          "${user.defaultListeningEpProb(App.instance.reserved.global.listeningGetEpProba)}%",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝기어",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          "0%",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기타",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          "0%",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 149,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusStamina.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(30),
                              start: converter.w(79),
                              end: converter.w(141),
                              height: converter.h(24),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        child: Text(
                                          user.adjustedStaminaMax.toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF18F89B),
                                            fontWeight: FontWeightAlias.black,
                                            fontSize: converter.h(20),
                                            fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(90),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기본",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.defaultStaminaMax.toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(105),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "라디오스킨",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedStaminaMaxRadioSkin
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(120),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "악세서리",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedStaminaMaxAccessory
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(105),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝기어",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedStaminaMaxListeningGear
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(120),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기타",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedStaminaMaxEtc.toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 78,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusRow.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "EXP획득",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user
                                              .adjustedGetExp(
                                                App
                                                    .instance
                                                    .reserved
                                                    .global
                                                    .expStamina,
                                              )
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "라디오스킨",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedGetExpRadioSkin
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "악세서리",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedGetExpAccessory
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(19),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기본",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user
                                              .defaultGetExp(
                                                App
                                                    .instance
                                                    .reserved
                                                    .global
                                                    .expStamina,
                                              )
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(34),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝기어",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedGetExpListeningGear
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(49),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기타",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedGetExpEtc.toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 149,
                    designPadding: const EdgeInsets.symmetric(horizontal: 5),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.statusFortune.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              // fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: converter.h(30),
                              start: converter.w(79),
                              end: converter.w(141),
                              height: converter.h(24),
                              child: WithAuth(
                                builder:
                                    (user) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        child: Text(
                                          "${user.adjustedLuckAddRate(App.instance.reserved.global.luck)}%",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFFEB2299),
                                            fontWeight: FontWeightAlias.black,
                                            fontSize: converter.h(20),
                                            fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(90),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기본",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          App.instance.reserved.global.luck
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(105),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "리스닝기어",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedLuckAddRateListeningGear
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(120),
                              start: converter.w(18),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "기타",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedLuckAddRateEtc
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF13B0EC),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(105),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "라디오스킨",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedLuckAddRateRadioSkin
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            PositionedDirectional(
                              top: converter.h(120),
                              start: converter.w(196),
                              height: converter.h(10),
                              child: WithAuth(
                                builder:
                                    (user) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OutlinedText(
                                          "악세서리",
                                          strokeColor: Colors.black,
                                          strokeWidth: converter.h(1),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight:
                                                FontWeightAlias.semiBold,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.transparent,
                                          width: converter.w(8),
                                          thickness: 0,
                                        ),
                                        Text(
                                          user.adjustedLuckAddRateAccessory
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF06FF98),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(8),
                                            // fontStyle: FontStyle.italic,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
  );
}
