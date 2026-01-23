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
import 'package:kpct_radio_app/app/misc/custom_extensions.dart';
import 'package:kpct_radio_app/route/home/modal/half/decomposition/decomposition_modal.dart';
import 'package:kpct_radio_app/route/home/modal/half/insetting_gem/insetting_gem_modal.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal.dart';
import 'package:kpct_radio_app/route/home/page/gear/gear_page_bloc.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

class GearPage extends StatefulWidget {
  const GearPage({super.key});

  @override
  State<StatefulWidget> createState() => _GearPageState();
}

class _GearPageState extends State<GearPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _GearPage();
  }
}

class _GearPage extends StatelessWidget {
  const _GearPage();

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
            Column(
              children: [
                KpctAspectRatio(
                  designWidth: designWidth,
                  designHeight: 42,
                  builder:
                      (converter) => Stack(
                        children: [
                          PositionedDirectional(
                            top: converter.h(6),
                            start: converter.w(5),
                            width: converter.w(126),
                            height: converter.h(21),
                            child: Assets.component.consoleTypeTitleGear.image(
                              width: converter.w(126),
                              height: converter.h(21),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                ),
                KpctAspectRatio.padding(
                  designWidth: designWidth,
                  designHeight: 240.94,
                  designPadding: const EdgeInsets.symmetric(horizontal: 5),
                  builder:
                      (converter) => BlocBuilder<GearPageBloc, GearPageState>(
                        buildWhen:
                            (previous, current) =>
                                (previous.selectedPack !=
                                    current.selectedPack) ||
                                (previous.selectedGemPack !=
                                    current.selectedGemPack) ||
                                (previous.selectedSocketIndex !=
                                    current.selectedSocketIndex),
                        builder: (context, state) {
                          final Pack? selectedPack = state.selectedPack;
                          final int? selectedSocketIndex =
                              state.selectedSocketIndex;

                          return Stack(
                            children: [
                              Assets.component.gearHeader.image(
                                width: converter.realSize.width,
                                height: converter.realSize.height,
                                fit: BoxFit.contain,
                              ),
                              if (selectedPack != null) ...[
                                PositionedDirectional(
                                  top: converter.h(12 - 1),
                                  start: converter.w(11 - 1),
                                  width: converter.w(47 + 2),
                                  height: converter.h(47 + 2),
                                  child: selectedPack.gear.tier.assetGenImage
                                      .image(
                                        width: converter.w(47 + 2),
                                        height: converter.h(47 + 2),
                                        fit: BoxFit.contain,
                                      ),
                                ),
                                PositionedDirectional(
                                  top: converter.h(12 - 1),
                                  start: converter.w(11 - 1),
                                  width: converter.w(47 + 2),
                                  height: converter.h(47 + 2),
                                  child: selectedPack.gear.category
                                      .assetGenImage(
                                        icon: selectedPack.gear.icon,
                                      )
                                      .image(
                                        width: converter.w(47 + 2),
                                        height: converter.h(47 + 2),
                                        fit: BoxFit.contain,
                                      ),
                                ),
                                PositionedDirectional(
                                  top: converter.h(15),
                                  start: converter.w(72),
                                  width: converter.w(27),
                                  height: converter.h(33),
                                  child: AssetGenImage(
                                    "assets/symbol/${selectedPack.gear.tier.name}.png",
                                  ).image(
                                    width: converter.w(27),
                                    height: converter.h(33),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                PositionedDirectional(
                                  top: converter.h(17),
                                  start: converter.w(105),
                                  end: converter.w(112),
                                  height: converter.h(7),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: OutlinedText(
                                      selectedPack.gear.tier.label,
                                      strokeColor: Colors.black,
                                      strokeWidth: converter.h(1),
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        letterSpacing: 0,
                                        color: const Color(0xFF01BEFE),
                                        fontWeight: FontWeightAlias.regular,
                                        fontSize: converter.h(6),
                                        fontStyle: FontStyle.normal,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                  top: converter.h(29),
                                  start: converter.w(108),
                                  end: converter.w(112),
                                  height: converter.h(19),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      selectedPack.gear.name,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        letterSpacing: 0,
                                        color: const Color(0xFF01BEFE),
                                        fontWeight: FontWeightAlias.black,
                                        fontSize: converter.h(16),
                                        fontStyle: FontStyle.italic,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                  top: converter.h(80),
                                  start: converter.w(16),
                                  height: converter.h(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedText(
                                        "스태미너최대량",
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
                                      VerticalDivider(
                                        color: Colors.transparent,
                                        width: converter.w(8),
                                        thickness: 0,
                                      ),
                                      Text(
                                        selectedPack.adjustedStaminaMax
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
                                PositionedDirectional(
                                  top: converter.h(95),
                                  start: converter.w(16),
                                  height: converter.h(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedText(
                                        "획득 SSP",
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
                                      VerticalDivider(
                                        color: Colors.transparent,
                                        width: converter.w(8),
                                        thickness: 0,
                                      ),
                                      Text(
                                        selectedPack.adjustedListeningSsp
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
                                PositionedDirectional(
                                  top: converter.h(110),
                                  start: converter.w(16),
                                  height: converter.h(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedText(
                                        "획득 EXP",
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
                                      VerticalDivider(
                                        color: Colors.transparent,
                                        width: converter.w(8),
                                        thickness: 0,
                                      ),
                                      Text(
                                        selectedPack.adjustedGetExp.toString(),
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
                                PositionedDirectional(
                                  top: converter.h(80),
                                  start: converter.w(197),
                                  height: converter.h(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedText(
                                        "리스닝파워",
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF06FF98),
                                          fontWeight: FontWeightAlias.semiBold,
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
                                        selectedPack.adjustedListeningPower
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
                                PositionedDirectional(
                                  top: converter.h(95),
                                  start: converter.w(197),
                                  height: converter.h(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedText(
                                        "획득 EP",
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF06FF98),
                                          fontWeight: FontWeightAlias.semiBold,
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
                                        selectedPack.adjustedListeningEp
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
                                PositionedDirectional(
                                  top: converter.h(110),
                                  start: converter.w(196),
                                  height: converter.h(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OutlinedText(
                                        "기타",
                                        strokeColor: Colors.black,
                                        strokeWidth: converter.h(1),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: const Color(0xFF06FF98),
                                          fontWeight: FontWeightAlias.semiBold,
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
                                        selectedPack.adjustedEtc.toString(),
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
                                if (!selectedPack.stackable &&
                                    selectedPack
                                            .equipments
                                            .first
                                            .sockets
                                            .isNotEmpty ==
                                        true) ...[
                                  PositionedDirectional(
                                    top: converter.h(145.5),
                                    start: 0,
                                    end: 0,
                                    height: converter.h(32),
                                    child: Center(
                                      child: ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            selectedPack
                                                .equipments
                                                .first
                                                .sockets
                                                .length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        separatorBuilder:
                                            (context, index) => VerticalDivider(
                                              color: Colors.transparent,
                                              width: converter.w(28),
                                              thickness: 0,
                                            ),
                                        itemBuilder: (context, index) {
                                          final String? gemId =
                                              selectedPack
                                                  .equipments
                                                  .first
                                                  .sockets[index]
                                                  .gearId;

                                          if (gemId != null) {
                                            final List<Widget> children;
                                            if (gemId.isEmpty) {
                                              // unlocked
                                              children = [
                                                Assets.component.socketUnlocked
                                                    .image(
                                                      width: converter.w(32),
                                                      height: converter.w(32),
                                                      fit: BoxFit.contain,
                                                    ),
                                              ];
                                            } else {
                                              // jeweled
                                              final Gear? gem = App
                                                  .instance
                                                  .reserved
                                                  .gear(id: gemId);

                                              children = [
                                                Assets.component.socketUnlocked
                                                    .image(
                                                      width: converter.w(32),
                                                      height: converter.w(32),
                                                      fit: BoxFit.contain,
                                                    ),
                                                if (gem != null) ...[
                                                  gem.tier.assetGenImage.image(
                                                    width: converter.w(
                                                      23.75 + 2,
                                                    ),
                                                    height: converter.h(
                                                      23.75 + 2,
                                                    ),
                                                    fit: BoxFit.contain,
                                                  ),
                                                  gem.category
                                                      .assetGenImage(
                                                        icon: gem.icon,
                                                      )
                                                      .image(
                                                        width: converter.w(
                                                          22.29,
                                                        ),
                                                        height: converter.h(
                                                          22.29,
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                ] else ...[
                                                  //
                                                ],
                                              ];
                                            }

                                            return KpctCupertinoButton(
                                              onPressed:
                                                  () => context
                                                      .read<GearPageBloc>()
                                                      .add(
                                                        GearPageEvent.socketPressed(
                                                          index: index,
                                                        ),
                                                      ),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children:
                                                    children..addAll([
                                                      if (selectedSocketIndex ==
                                                          index) ...[
                                                        Assets
                                                            .component
                                                            .socketSelection
                                                            .image(
                                                              width: converter
                                                                  .w(31),
                                                              height: converter
                                                                  .h(31),
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                      ],
                                                    ]),
                                              ),
                                            );
                                          } else {
                                            // locked
                                            return KpctCupertinoButton(
                                              onPressed:
                                                  (selectedSocketIndex != null)
                                                      ? null
                                                      : () async =>
                                                          await SocketUnlockModal.launch(
                                                            context: context,
                                                            pack: selectedPack,
                                                          ),
                                              child: Assets
                                                  .component
                                                  .socketLocked
                                                  .image(
                                                    width: converter.w(32),
                                                    height: converter.w(32),
                                                    fit: BoxFit.contain,
                                                  ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                                if (selectedSocketIndex != null) ...[
                                  PositionedDirectional(
                                    top: converter.h(197),
                                    start: converter.w(135.97),
                                    width: converter.w(35.05),
                                    height: converter.h(37),
                                    child: BlocBuilder<
                                      GearPageBloc,
                                      GearPageState
                                    >(
                                      buildWhen:
                                          (previous, current) =>
                                              (previous.selectedGemPack !=
                                                  current.selectedGemPack),
                                      builder:
                                          (context, state) => KpctSwitcher(
                                            builder: () {
                                              final Pack? selectedGemPack =
                                                  state.selectedGemPack;
                                              final bool key =
                                                  (selectedGemPack != null) &&
                                                  (selectedGemPack
                                                      .equipments
                                                      .isNotEmpty);

                                              if (key) {
                                                return KpctCupertinoButton.solid(
                                                  key: ValueKey<bool>(key),
                                                  onPressed:
                                                      () async => await InsettingGemModal.launch(
                                                        context: context,
                                                        gemPack:
                                                            selectedGemPack,
                                                        targetPack:
                                                            selectedPack,
                                                        socketIndex:
                                                            selectedSocketIndex,
                                                      ).then((value) {
                                                        if ((value != null) &&
                                                            (value
                                                                is InsettingGemModalResponse) &&
                                                            (value ==
                                                                InsettingGemModalResponse
                                                                    .success)) {
                                                          context
                                                              .read<
                                                                GearPageBloc
                                                              >()
                                                              .add(
                                                                const GearPageEvent.releaseSocket(),
                                                              );
                                                        }
                                                      }),
                                                  child: Assets
                                                      .component
                                                      .insettingGemCircleButtonEnabled
                                                      .image(
                                                        width: converter.w(
                                                          35.05,
                                                        ),
                                                        height: converter.h(37),
                                                        fit: BoxFit.contain,
                                                      ),
                                                );
                                              } else {
                                                return KpctCupertinoButton.solid(
                                                  key: ValueKey<bool>(key),
                                                  onPressed: null,
                                                  child: Assets
                                                      .component
                                                      .insettingGemCircleButtonDisabled
                                                      .image(
                                                        width: converter.w(
                                                          35.05,
                                                        ),
                                                        height: converter.h(37),
                                                        fit: BoxFit.contain,
                                                      ),
                                                );
                                              }
                                            },
                                          ),
                                    ),
                                    // child: KpctCupertinoButton.solid(
                                    //   onPressed: () async => await InsettingGemModal.launch(
                                    //     context: context,
                                    //     targetPack: selectedPack,
                                    //     gemPack: null,
                                    //     socketIndex: selectedSocketIndex,
                                    //   ),
                                    //   child: Assets.component.insettingGemCircleButtonDisabled.image(
                                    //     width: converter.w(35.05),
                                    //     height: converter.h(37),
                                    //     fit: BoxFit.contain,
                                    //   ),
                                    // ),
                                  ),
                                  PositionedDirectional(
                                    top: converter.h(197),
                                    end: converter.w(135.97),
                                    width: converter.w(35.05),
                                    height: converter.h(37),
                                    child: KpctCupertinoButton.solid(
                                      onPressed:
                                          () => context.read<GearPageBloc>().add(
                                            const GearPageEvent.releaseSocket(),
                                          ),
                                      child: Assets.component.cancelCircleButton
                                          .image(
                                            width: converter.w(35.05),
                                            height: converter.h(37),
                                            fit: BoxFit.contain,
                                          ),
                                    ),
                                  ),
                                ] else ...[
                                  if (App.instance.reserved.decomposition(
                                        id: selectedPack.gear.id,
                                      ) !=
                                      null) ...[
                                    PositionedDirectional(
                                      top: converter.h(197),
                                      start: converter.w(135.97),
                                      width: converter.w(35.05),
                                      height: converter.h(37),
                                      child: KpctSwitcher(
                                        builder: () {
                                          if (selectedPack.mounted) {
                                            return KpctCupertinoButton.solid(
                                              key: ValueKey<bool>(
                                                selectedPack.mounted,
                                              ),
                                              onPressed: null,
                                              child: Assets
                                                  .component
                                                  .decompositionCircleButtonDisabled
                                                  .image(
                                                    width: converter.w(35.05),
                                                    height: converter.h(37),
                                                    fit: BoxFit.contain,
                                                  ),
                                            );
                                          } else {
                                            return KpctCupertinoButton.solid(
                                              key: ValueKey<bool>(
                                                selectedPack.mounted,
                                              ),
                                              onPressed:
                                                  () async =>
                                                      await DecompositionModal.launch(
                                                        context: context,
                                                        pack: selectedPack,
                                                        decomposition: App
                                                            .instance
                                                            .reserved
                                                            .decomposition(
                                                              id:
                                                                  selectedPack
                                                                      .gear
                                                                      .id,
                                                            ),
                                                      ),
                                              child: Assets
                                                  .component
                                                  .decompositionCircleButtonEnabled
                                                  .image(
                                                    width: converter.w(35.05),
                                                    height: converter.h(37),
                                                    fit: BoxFit.contain,
                                                  ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                  if (selectedPack.mountable) ...[
                                    PositionedDirectional(
                                      top: converter.h(197),
                                      end: converter.w(135.97),
                                      width: converter.w(35.05),
                                      height: converter.h(37),
                                      child: KpctSwitcher(
                                        builder: () {
                                          if (selectedPack.mounted) {
                                            return KpctCupertinoButton.solid(
                                              key: ValueKey<bool>(
                                                selectedPack.mounted,
                                              ),
                                              onPressed:
                                                  () => context
                                                      .read<GearPageBloc>()
                                                      .add(
                                                        GearPageEvent.uninstall(
                                                          equipmentId:
                                                              selectedPack.id,
                                                        ),
                                                      ),
                                              child: Assets
                                                  .component
                                                  .unequipCircleButton
                                                  .image(
                                                    width: converter.w(35.05),
                                                    height: converter.h(37),
                                                    fit: BoxFit.contain,
                                                  ),
                                            );
                                          } else {
                                            return KpctCupertinoButton.solid(
                                              key: ValueKey<bool>(
                                                selectedPack.mounted,
                                              ),
                                              onPressed:
                                                  () => context
                                                      .read<GearPageBloc>()
                                                      .add(
                                                        GearPageEvent.install(
                                                          equipmentId:
                                                              selectedPack.id,
                                                        ),
                                                      ),
                                              child: Assets
                                                  .component
                                                  .equipCircleButton
                                                  .image(
                                                    width: converter.w(35.05),
                                                    height: converter.h(37),
                                                    fit: BoxFit.contain,
                                                  ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ],
                              ],
                            ],
                          );
                        },
                      ),
                ),
                Stack(
                  children: [
                    KpctAspectRatio.padding(
                      designWidth: designWidth,
                      designHeight: 30 + (12 - 7),
                      designPadding: const EdgeInsets.symmetric(horizontal: 5),
                      builder:
                          (converter) => Stack(
                            children: [
                              PositionedDirectional(
                                top: converter.h(1),
                                start: 0,
                                end: 0,
                                height: converter.h(30),
                                child: BlocBuilder<GearPageBloc, GearPageState>(
                                  buildWhen:
                                      (previous, current) =>
                                          (previous.selectedGearCategory !=
                                              current.selectedGearCategory),
                                  builder:
                                      (context, state) => Flex(
                                        direction: Axis.horizontal,
                                        children:
                                            GearCategory.values.map((element) {
                                              final Size designSize = element
                                                  .tabBarDesignSize(
                                                    state.selectedGearCategory ==
                                                        element,
                                                  );
                                              final AssetGenImage asset =
                                                  element.tabBarAssetGenImage(
                                                    state.selectedGearCategory ==
                                                        element,
                                                  );

                                              return Flexible(
                                                flex: designSize.width.toInt(),
                                                fit: FlexFit.tight,
                                                child: KpctCupertinoButton.solid(
                                                  pressedOpacity: 1,
                                                  onPressed:
                                                      () => context
                                                          .read<GearPageBloc>()
                                                          .add(
                                                            GearPageEvent.tabPressed(
                                                              gearCategory:
                                                                  element,
                                                            ),
                                                          ),
                                                  child: Stack(
                                                    children: [
                                                      KpctSwitcher(
                                                        builder:
                                                            () => Align(
                                                              key: ValueKey<
                                                                bool
                                                              >(
                                                                state.selectedGearCategory ==
                                                                    element,
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .bottomCenter,
                                                              child: asset.image(
                                                                width: converter
                                                                    .w(
                                                                      designSize
                                                                          .width,
                                                                    ),
                                                                height:
                                                                    converter.h(
                                                                      designSize
                                                                          .height,
                                                                    ),
                                                              ),
                                                            ),
                                                      ),
                                                      PositionedDirectional(
                                                        start: 0,
                                                        end: 0,
                                                        bottom: converter.h(12),
                                                        child: Align(
                                                          alignment:
                                                              Alignment
                                                                  .bottomCenter,
                                                          child: Text(
                                                            element.tabBarTitle,
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .regular,
                                                              fontSize:
                                                                  converter.h(
                                                                    8,
                                                                  ),
                                                              height: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                ),
                              ),
                              PositionedDirectional(
                                bottom: 0,
                                start: 0,
                                end: 0,
                                height: converter.h(12),
                                child: Assets.component.tabBarViewEdge.image(
                                  width: converter.realSize.width,
                                  height: converter.h(12),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                    ),
                  ],
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder:
                        (context, constraints) => Stack(
                          children: [
                            Center(
                              child: Assets.component.tabBarViewBridge.image(
                                width:
                                    constraints.maxWidth * (365 / designWidth),
                                height: constraints.maxHeight,
                                fit: BoxFit.fill,
                              ),
                            ),
                            BlocBuilder<GearPageBloc, GearPageState>(
                              buildWhen:
                                  (previous, current) =>
                                      (previous.packs != current.packs) ||
                                      (previous.selectedGemPack !=
                                          current.selectedGemPack) ||
                                      (previous.selectedGearCategory !=
                                          current.selectedGearCategory),
                              builder: (context, state) {
                                final List<Pack> packs = List.of(
                                  state.packs.where(
                                    (element) =>
                                        (element.gear.category ==
                                            state.selectedGearCategory),
                                  ),
                                );

                                return GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: KpctConverter.flex(
                                      context: context,
                                      flex: 15,
                                      designWidth: designWidth,
                                    ),
                                  ),
                                  itemCount: packs.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 6,
                                        childAspectRatio: (50 / 49.76),
                                        crossAxisSpacing: KpctConverter.flex(
                                          context: context,
                                          flex: 9,
                                          designWidth: designWidth,
                                        ),
                                        mainAxisSpacing: KpctConverter.flex(
                                          context: context,
                                          flex: 9,
                                          designWidth: designWidth,
                                        ),
                                      ),
                                  itemBuilder:
                                      (
                                        context,
                                        index,
                                      ) => KpctCupertinoButton.solid(
                                        onPressed:
                                            () => context
                                                .read<GearPageBloc>()
                                                .add(
                                                  GearPageEvent.elementPressed(
                                                    pack: packs[index],
                                                  ),
                                                ),
                                        child: KpctAspectRatio(
                                          designWidth: 50,
                                          designHeight: 49.76,
                                          builder:
                                              (converter) => Stack(
                                                children: [
                                                  Assets.component.gearBorder
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
                                                  if ((state.selectedGearCategory ==
                                                          GearCategory.gem) &&
                                                      (state
                                                              .selectedGemPack
                                                              ?.id ==
                                                          packs[index].id)) ...[
                                                    Assets
                                                        .component
                                                        .packSelection
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
                                                  ],
                                                  PositionedDirectional(
                                                    top: converter.h(6),
                                                    start: converter.w(6),
                                                    end: converter.w(6),
                                                    bottom: converter.h(5.76),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        packs[index]
                                                            .gear
                                                            .tier
                                                            .assetGenImage
                                                            .image(
                                                              width: converter
                                                                  .w(38),
                                                              height: converter
                                                                  .h(38),
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                        packs[index]
                                                            .gear
                                                            .category
                                                            .assetGenImage(
                                                              icon:
                                                                  packs[index]
                                                                      .gear
                                                                      .icon,
                                                            )
                                                            .image(
                                                              width: converter
                                                                  .w(38),
                                                              height: converter
                                                                  .h(38),
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (packs[index]
                                                      .stackable) ...[
                                                    PositionedDirectional(
                                                      bottom: converter.h(8.76),
                                                      end: converter.w(10),
                                                      child: Align(
                                                        alignment:
                                                            Alignment
                                                                .bottomRight,
                                                        child: OutlinedText(
                                                          packs[index]
                                                              .equipments
                                                              .length
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.end,
                                                          strokeWidth: converter
                                                              .h(1),
                                                          strokeColor:
                                                              Colors.black,
                                                          style: GoogleFonts.inter(
                                                            letterSpacing: 0,
                                                            color: Colors.white,
                                                            fontStyle:
                                                                FontStyle
                                                                    .italic,
                                                            fontWeight:
                                                                FontWeightAlias
                                                                    .semiBold,
                                                            fontSize: converter
                                                                .h(8),
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ] else ...[
                                                    if (packs[index]
                                                        .equipments
                                                        .first
                                                        .sockets
                                                        .isNotEmpty) ...[
                                                      PositionedDirectional(
                                                        bottom: converter.h(
                                                          9.76,
                                                        ),
                                                        start: 0,
                                                        end: 0,
                                                        height: converter.h(4),
                                                        child: Center(
                                                          child: ListView.separated(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                packs[index]
                                                                    .equipments
                                                                    .first
                                                                    .sockets
                                                                    .length,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            shrinkWrap: true,
                                                            separatorBuilder:
                                                                (
                                                                  context,
                                                                  index,
                                                                ) => VerticalDivider(
                                                                  color:
                                                                      Colors
                                                                          .transparent,
                                                                  width:
                                                                      converter
                                                                          .w(4),
                                                                  thickness: 0,
                                                                ),
                                                            itemBuilder:
                                                                (
                                                                  context,
                                                                  socketIndex,
                                                                ) => Container(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  width:
                                                                      converter
                                                                          .w(4),
                                                                  height:
                                                                      converter
                                                                          .h(4),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      (packs[index].equipments.first.sockets[socketIndex].gearId?.isNotEmpty ==
                                                                              true)
                                                                          ? Container(
                                                                            color: const Color(
                                                                              0xFF7AFF11,
                                                                            ),
                                                                            width: converter.w(
                                                                              2,
                                                                            ),
                                                                            height: converter.h(
                                                                              2,
                                                                            ),
                                                                          )
                                                                          : const SizedBox(),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ],
                                              ),
                                        ),
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                  ),
                ),
                KpctAspectRatio.padding(
                  designWidth: designWidth,
                  designHeight: 12,
                  designPadding: const EdgeInsets.symmetric(horizontal: 5),
                  builder:
                      (converter) => RotatedBox(
                        quarterTurns: 2,
                        child: Assets.component.tabBarViewEdge.image(
                          width: converter.realSize.width,
                          height: converter.h(12),
                          fit: BoxFit.contain,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
  );
}
