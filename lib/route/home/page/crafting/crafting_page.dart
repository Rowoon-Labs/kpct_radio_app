import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/misc/custom_extensions.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal.dart';
import 'package:kpct_radio_app/route/home/page/crafting/crafting_page_bloc.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

class CraftingPage extends StatefulWidget {
  const CraftingPage({super.key});

  @override
  State<StatefulWidget> createState() => _CraftingPageState();
}

class _CraftingPageState extends State<CraftingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _CraftingPage();
  }
}

class _CraftingPage extends StatelessWidget {
  const _CraftingPage();

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
                            child: Assets.component.consoleTypeTitleCrafting
                                .image(
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
                      (
                        converter,
                      ) => BlocBuilder<CraftingPageBloc, CraftingPageState>(
                        buildWhen:
                            (previous, current) =>
                                (previous.selectedKit != current.selectedKit),
                        builder: (context, state) {
                          final Kit? selectedKit = state.selectedKit;

                          return Stack(
                            children: [
                              Assets.component.gearHeader.image(
                                width: converter.realSize.width,
                                height: converter.realSize.height,
                                fit: BoxFit.contain,
                              ),
                              if (selectedKit != null) ...[
                                PositionedDirectional(
                                  top: converter.h(12 - 1),
                                  start: converter.w(11 - 1),
                                  width: converter.w(47 + 2),
                                  height: converter.h(47 + 2),
                                  child: selectedKit.gear.tier.assetGenImage
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
                                  child: selectedKit.gear.category
                                      .assetGenImage(
                                        icon: selectedKit.gear.icon,
                                      )
                                      .image(
                                        width: converter.w(47 + 2),
                                        height: converter.h(47 + 2),
                                        fit: BoxFit.contain,
                                      ),
                                ),

                                ////////////////////////////////////////////////////////////////////////////////
                                PositionedDirectional(
                                  top: converter.h(15),
                                  start: converter.w(72),
                                  width: converter.w(27),
                                  height: converter.h(33),
                                  child: AssetGenImage(
                                    "assets/symbol/${selectedKit.gear.tier.name}.png",
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
                                      selectedKit.gear.tier.label,
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
                                      selectedKit.gear.name,
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
                                        (selectedKit.gear.staminaMax != null
                                            ? selectedKit.gear.staminaMax
                                                .toString()
                                            : "0"),
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
                                        (selectedKit.gear.listeningSsp != null
                                            ? selectedKit.gear.listeningSsp
                                                .toString()
                                            : "0"),
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
                                        (selectedKit.gear.getExp != null
                                            ? selectedKit.gear.getExp.toString()
                                            : "0"),
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
                                        (selectedKit.gear.staminaUse != null
                                            ? selectedKit.gear.staminaUse
                                                .toString()
                                            : "0"),
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
                                        (selectedKit.gear.listeningEp != null
                                            ? selectedKit.gear.listeningEp
                                                .toString()
                                            : "0"),
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
                                        "0",
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

                                ////////////////////////////////////////////////////////////////////////////////
                                if ((selectedKit.gear.socketMax != null) &&
                                    ((selectedKit.gear.socketMax ?? 0) >
                                        0)) ...[
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
                                            selectedKit.gear.socketMax ?? 0,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        separatorBuilder:
                                            (context, index) => VerticalDivider(
                                              color: Colors.transparent,
                                              width: converter.w(28),
                                              thickness: 0,
                                            ),
                                        itemBuilder:
                                            (context, index) => Assets
                                                .component
                                                .socketLocked
                                                .image(
                                                  width: converter.w(32),
                                                  height: converter.w(32),
                                                  fit: BoxFit.contain,
                                                ),
                                      ),
                                    ),
                                  ),
                                ],
                                if ((selectedKit.gear.category !=
                                        GearCategory.parts) &&
                                    (selectedKit.gear.category !=
                                            GearCategory.gem
                                        ? true
                                        : (selectedKit.gear.tier !=
                                            GearTier.seven))) ...[
                                  PositionedDirectional(
                                    top: converter.h(197),
                                    start: converter.hcx(35.05),
                                    width: converter.w(35.05),
                                    height: converter.h(37),
                                    child: KpctCupertinoButton.solid(
                                      onPressed: () async {
                                        await WorkbenchModal.launch(
                                          context: context,
                                          kit: selectedKit,
                                        ).then((value) {});
                                      },
                                      child: Assets
                                          .component
                                          .craftingCircleButtonEnabled
                                          .image(
                                            width: converter.w(32),
                                            height: converter.w(32),
                                            fit: BoxFit.contain,
                                          ),
                                    ),
                                  ),
                                ],
                                if (kReleaseMode == false)
                                  PositionedDirectional(
                                    top: converter.h(197 + 3.5),
                                    end: converter.w(60),
                                    width: converter.w(60),
                                    height: converter.h(30),
                                    child: KpctCupertinoButton.solid(
                                      onPressed:
                                          () async => await FirebaseFirestore
                                              .instance
                                              .collection("users")
                                              .doc(
                                                App
                                                    .instance
                                                    .auth
                                                    .customUser
                                                    ?.id,
                                              )
                                              .collection("equipments")
                                              .add(
                                                Equipment(
                                                    id: "",
                                                    gearId: selectedKit.id,
                                                    category:
                                                        selectedKit
                                                            .gear
                                                            .category,
                                                    mounted: false,
                                                    sockets:
                                                        List<Socket>.generate(
                                                          selectedKit
                                                                  .gear
                                                                  .socketMax ??
                                                              0,
                                                          (index) =>
                                                              const Socket(
                                                                gearId: null,
                                                                getExp: 0,
                                                                staminaUse: 0,
                                                                listeningEp: 0,
                                                                listeningSsp: 0,
                                                              ),
                                                        ),
                                                  ).toJson()
                                                  ..remove("id"),
                                              ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        converter.radius(8),
                                      ),
                                      child: Text(
                                        "강제 생성",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: Colors.black,
                                          fontWeight: FontWeightAlias.bold,
                                          fontSize: converter.h(8),
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                child: BlocBuilder<
                                  CraftingPageBloc,
                                  CraftingPageState
                                >(
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
                                                          .read<
                                                            CraftingPageBloc
                                                          >()
                                                          .add(
                                                            CraftingPageEvent.tabPressed(
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
                            BlocBuilder<CraftingPageBloc, CraftingPageState>(
                              buildWhen:
                                  (previous, current) =>
                                      (previous.kits != current.kits) ||
                                      (previous.selectedGearCategory !=
                                          current.selectedGearCategory),
                              builder: (context, state) {
                                final List<Kit> kits = List.of(
                                  state.kits.where(
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
                                  itemCount: kits.length,
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
                                                .read<CraftingPageBloc>()
                                                .add(
                                                  CraftingPageEvent.elementPressed(
                                                    kit: kits[index],
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
                                                  PositionedDirectional(
                                                    top: converter.h(6),
                                                    start: converter.w(6),
                                                    end: converter.w(6),
                                                    bottom: converter.h(5.76),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        kits[index]
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
                                                        kits[index]
                                                            .gear
                                                            .category
                                                            .assetGenImage(
                                                              icon:
                                                                  kits[index]
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
                                                        AnimatedOpacity(
                                                          opacity:
                                                              (kits[index].equipments !=
                                                                      null)
                                                                  ? 0
                                                                  : 0.6,
                                                          duration:
                                                              defaultAnimationDuration,
                                                          curve:
                                                              defaultAnimationCurve,
                                                          child: Container(
                                                            width: converter.w(
                                                              38,
                                                            ),
                                                            height: converter.h(
                                                              38,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors.black,
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
                                                  if (kits[index]
                                                      .stackable) ...[
                                                    if ((kits[index]
                                                                .equipments
                                                                ?.length !=
                                                            null) &&
                                                        ((kits[index]
                                                                    .equipments
                                                                    ?.length ??
                                                                0) >
                                                            0)) ...[
                                                      PositionedDirectional(
                                                        bottom: converter.h(
                                                          8.76,
                                                        ),
                                                        end: converter.w(10),
                                                        child: Align(
                                                          alignment:
                                                              Alignment
                                                                  .bottomRight,
                                                          child: OutlinedText(
                                                            (kits[index]
                                                                        .equipments
                                                                        ?.length ??
                                                                    0)
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.end,
                                                            strokeWidth:
                                                                converter.h(1),
                                                            strokeColor:
                                                                Colors.black,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  Colors.white,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .semiBold,
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
                                                  ] else ...[
                                                    if ((kits[index]
                                                                .gear
                                                                .socketMax !=
                                                            null) &&
                                                        ((kits[index]
                                                                    .gear
                                                                    .socketMax ??
                                                                0) >
                                                            0)) ...[
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
                                                                kits[index]
                                                                    .gear
                                                                    .socketMax ??
                                                                0,
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
                                                                  index,
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
