import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/route/home/bottom_navigation/bottom_navigation_rail.dart';
import 'package:kpct_radio_app/route/home/home_bloc.dart';
import 'package:kpct_radio_app/route/home/page/crafting/crafting_page.dart';
import 'package:kpct_radio_app/route/home/page/crafting/crafting_page_bloc.dart';
import 'package:kpct_radio_app/route/home/page/gear/gear_page.dart';
import 'package:kpct_radio_app/route/home/page/gear/gear_page_bloc.dart';
import 'package:kpct_radio_app/route/home/page/idle/idle_page_bloc.dart';
import 'package:kpct_radio_app/route/home/page/idle/idle_page_page.dart';
import 'package:kpct_radio_app/route/home/page/shop/shop_page.dart';
import 'package:kpct_radio_app/route/home/page/shop/shop_page_bloc.dart';
import 'package:kpct_radio_app/route/home/page/status/status_page.dart';
import 'package:kpct_radio_app/route/home/page/status/status_page_bloc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => HomeBloc()..add(const HomeEvent.initialize()),
      ),
      BlocProvider(
        create:
            (context) => IdlePageBloc()..add(const IdlePageEvent.initialize()),
      ),
      BlocProvider(create: (context) => StatusPageBloc()),
      BlocProvider(
        create:
            (context) => GearPageBloc()..add(const GearPageEvent.initialize()),
      ),
      BlocProvider(
        create:
            (context) =>
                CraftingPageBloc()..add(const CraftingPageEvent.initialize()),
      ),
      BlocProvider(create: (context) => ShopPageBloc()),
    ],
    child: Builder(
      builder:
          (context) => SafeArea(
            child: Stack(
              children: [
                DefaultTabController(
                  length: HomePage.values.length - 1,
                  child: Scaffold(
                    body: Stack(
                      children: [
                        YoutubePlayer(
                          controller:
                              context.read<HomeBloc>().youtubePlayerController,
                          enableFullScreenOnVerticalDrag: true,
                          backgroundColor: Colors.transparent,
                          aspectRatio: 375 / 227.53,
                          // gestureRecognizers: {
                          // },
                        ),
                        const ColoredBox(
                          color: Colors.black,
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              IdlePage(),
                              StatusPage(),
                              GearPage(),
                              CraftingPage(),
                              ShopPage(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: const BottomNavigationRail(),
                  ),
                ),
                WithAuth(
                  builder: (user) {
                    // FGT 기간중에만 로그인 되도록
                    // if (DateTime.now()
                    //         .toUtc()
                    //         .isBefore(DateTime.utc(2024, 9, 4, 6)) ||
                    //     DateTime.now()
                    //         .toUtc()
                    //         .isAfter(DateTime.utc(2024, 9, 10, 6))) {
                    //   return Material(
                    //     key: ValueKey<bool>(user.bonded),
                    //     color: Colors.black.withOpacity(0.7),
                    //     child: Center(
                    //       child: KpctAspectRatio(
                    //         designWidth: designWidth,
                    //         designHeight: 200,
                    //         builder: (converter) => Column(
                    //           children: [
                    //             Text(
                    //               "서비스 종료\n현재는 FGT 기간이 아닙니다.",
                    //               textAlign: TextAlign.center,
                    //               style: GoogleFonts.inter(
                    //                 letterSpacing: 0,
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeightAlias.bold,
                    //                 fontSize: converter.h(24),
                    //                 height: 1,
                    //               ),
                    //             ),
                    //             Divider(
                    //               color: Colors.transparent,
                    //               thickness: 0,
                    //               height: converter.h(30),
                    //             ),
                    //             FittedBox(
                    //               fit: BoxFit.scaleDown,
                    //               child: Text(
                    //                 user.email,
                    //                 textAlign: TextAlign.center,
                    //                 style: GoogleFonts.inter(
                    //                   letterSpacing: 0,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeightAlias.medium,
                    //                   fontSize: converter.h(14),
                    //                   height: 1,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }
                    if (user.bonded) {
                      return SizedBox.expand(key: ValueKey<bool>(user.bonded));
                    } else {
                      return Material(
                        key: ValueKey<bool>(user.bonded),
                        color: Colors.black.withOpacity(0.6),
                        child: Center(
                          child: KpctAspectRatio(
                            designWidth: designWidth,
                            designHeight: 200,
                            builder:
                                (converter) => Column(
                                  children: [
                                    Text(
                                      "HOD 연동 필요",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        letterSpacing: 0,
                                        color: Colors.white,
                                        fontWeight: FontWeightAlias.bold,
                                        fontSize: converter.h(32),
                                        height: 1,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      thickness: 0,
                                      height: converter.h(20),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        user.email,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          letterSpacing: 0,
                                          color: Colors.white,
                                          fontWeight: FontWeightAlias.bold,
                                          fontSize: converter.h(16),
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
    ),
  );
}
