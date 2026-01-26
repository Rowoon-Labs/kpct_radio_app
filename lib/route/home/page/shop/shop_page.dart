import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/route/home/page/shop/shop_page_bloc.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/shop_item.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _ShopPage();
  }
}

class _ShopPage extends StatelessWidget {
  const _ShopPage();

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
                            child: Assets.component.consoleTypeTitleShop.image(
                              width: converter.w(126),
                              height: converter.h(21),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: context.read<ShopPageBloc>().scrollController,
                    itemCount: App.instance.reserved.shopItems.length,
                    separatorBuilder:
                        (context, index) => const KpctSeparator(
                          designWidth: designWidth,
                          designHeight: 5,
                        ),
                    itemBuilder: (context, index) {
                      final ShopItem shopItem =
                          App.instance.reserved.shopItems[index];

                      return StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder:
                            (context, snapshot) => WithAuth(
                              builder: (user) {
                                final AdjustedItem adjustedItem = shopItem
                                    .adjust(user: user);

                                return KpctAspectRatio.padding(
                                  designWidth: designWidth,
                                  designHeight: 114.92,
                                  designPadding: const EdgeInsets.only(
                                    left: 7,
                                    right: 8,
                                  ),
                                  builder:
                                      (converter) => KpctCupertinoButton.solid(
                                        onPressed:
                                            !adjustedItem.canBuy
                                                ? null
                                                : () => context
                                                    .read<ShopPageBloc>()
                                                    .add(
                                                      ShopPageEvent.tryBuy(
                                                        shopItem: shopItem,
                                                      ),
                                                    ),
                                        color: Colors.transparent,
                                        pressedOpacity: 0.95,
                                        child: Stack(
                                          children: [
                                            Stack(
                                              children: [
                                                Assets.component.shopItemPod
                                                    .image(
                                                      width:
                                                          constraints.maxWidth,
                                                      height:
                                                          constraints.maxHeight,
                                                      fit: BoxFit.cover,
                                                    ),
                                                PositionedDirectional(
                                                  top: converter.h(3),
                                                  start: converter.w(8),
                                                  width: converter.w(66),
                                                  height: converter.h(66),
                                                  child: AssetGenImage(
                                                    "assets/item/${shopItem.icon ?? ""}.png",
                                                  ).image(
                                                    width: converter.w(66),
                                                    height: converter.h(66),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                PositionedDirectional(
                                                  top: converter.h(17),
                                                  start: converter.w(82),
                                                  end: converter.w(25),
                                                  height: converter.h(15),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      shopItem.name ?? "",
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: GoogleFonts.inter(
                                                        letterSpacing: 0,
                                                        color: const Color(
                                                          0xFF02D7FF,
                                                        ),
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .semiBold,
                                                        fontSize: converter.h(
                                                          12,
                                                        ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                PositionedDirectional(
                                                  top: converter.h(37),
                                                  start: converter.w(82),
                                                  end: converter.w(25),
                                                  height: converter.h(22),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      (shopItem.desc ?? "") +
                                                          (adjustedItem
                                                                      .remainEffectiveDuration !=
                                                                  null
                                                              ? "\n(남은시간 ${adjustedItem.remainEffectiveDuration!.inMinutes}분)"
                                                              : ""),
                                                      softWrap: false,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.inter(
                                                        letterSpacing: 0,
                                                        color: const Color(
                                                          0xFF00B2E0,
                                                        ),
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .semiBold,
                                                        fontSize: converter.h(
                                                          10,
                                                        ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                PositionedDirectional(
                                                  top: converter.h(84),
                                                  start: converter.w(231),
                                                  width: converter.w(14),
                                                  height: converter.h(14),
                                                  child: (shopItem.costSsp > 0
                                                          ? Assets
                                                              .component
                                                              .shopSspIcon
                                                          : Assets
                                                              .component
                                                              .shopEpIcon)
                                                      .image(
                                                        width: converter.w(14),
                                                        height: converter.h(14),
                                                        fit: BoxFit.contain,
                                                      ),
                                                ),
                                                PositionedDirectional(
                                                  top: converter.h(79),
                                                  start: converter.w(30),
                                                  end: converter.w(203),
                                                  height: converter.h(10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "1일 5회 구매 가능 (${adjustedItem.todayBuyCount} 회 구매)",
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: GoogleFonts.inter(
                                                        letterSpacing: 0,
                                                        color: const Color(
                                                          0xFF00FF96,
                                                        ),
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .semiBold,
                                                        fontSize: converter.h(
                                                          8,
                                                        ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                PositionedDirectional(
                                                  top: converter.h(83),
                                                  start: converter.w(247),
                                                  end: converter.w(54),
                                                  height: converter.h(16),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      // state.items[index].description,
                                                      NumberFormat.simpleCurrency(
                                                        decimalDigits: 0,
                                                        name: "",
                                                      ).format(
                                                        shopItem.costSsp > 0
                                                            ? shopItem.costSsp
                                                            : shopItem.costEp,
                                                      ),
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: GoogleFonts.inter(
                                                        letterSpacing: 0,
                                                        color: const Color(
                                                          0xFF01FD9F,
                                                        ),
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .semiBold,
                                                        fontSize: converter.h(
                                                          13,
                                                        ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IgnorePointer(
                                              child: AnimatedOpacity(
                                                opacity:
                                                    adjustedItem.canBuy
                                                        ? 0
                                                        : 0.6,
                                                duration:
                                                    defaultAnimationDuration,
                                                curve: defaultAnimationCurve,
                                                child: Assets
                                                    .component
                                                    .shopItemPod
                                                    .image(
                                                      width:
                                                          constraints.maxWidth,
                                                      height:
                                                          constraints.maxHeight,
                                                      color: Colors.black,
                                                      fit: BoxFit.cover,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                );
                              },
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
  );
}
