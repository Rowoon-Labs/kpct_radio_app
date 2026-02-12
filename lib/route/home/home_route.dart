import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        Positioned(
                          top: 91, // IdlePage의 PlayerPod 위치에 맞춤 (85.24 + 5.76)
                          left: 0,
                          right: 0,
                          child: YoutubePlayer(
                            controller:
                                context
                                    .read<HomeBloc>()
                                    .youtubePlayerController,
                            enableFullScreenOnVerticalDrag: true,
                            backgroundColor: Colors.transparent,
                            aspectRatio: 375 / 227.53,
                          ),
                        ),
                        const TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            IdlePage(),
                            StatusPage(),
                            GearPage(),
                            CraftingPage(),
                            ShopPage(),
                          ],
                        ),
                      ],
                    ),
                    bottomNavigationBar: const BottomNavigationRail(),
                  ),
                ),
              ],
            ),
          ),
    ),
  );
}
