import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/route/home/bottom_navigation/bottom_navigation_rail_bloc.dart';
import 'package:kpct_radio_app/route/home/bottom_navigation/bottom_navigation_rail_button.dart';
import 'package:kpct_radio_app/route/home/home_bloc.dart';

class BottomNavigationRail extends StatelessWidget {
  const BottomNavigationRail({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => BottomNavigationRailBloc(),
    child: KpctAspectRatio(
      designWidth: designWidth,
      designHeight: 101,
      builder:
          (converter) => Stack(
            children: [
              Assets.component.bottomNavigationRail.image(
                width: converter.realSize.width,
                height: converter.realSize.height,
                fit: BoxFit.cover,
              ),
              PositionedDirectional(
                top: converter.h(7),
                bottom: converter.h(15),
                start: converter.hcx(345),
                width: converter.w(345),
                child: FittedBox(
                  child: Row(
                    children:
                        [
                          HomePage.values.first,
                          ...HomePage.values
                              .sublist(1)
                              .expand((element) => [null, element]),
                        ].map((element) {
                          if (element != null) {
                            return BlocBuilder<HomeBloc, HomeState>(
                              buildWhen:
                                  (previous, current) =>
                                      (previous.page != current.page),
                              builder:
                                  (context, state) =>
                                      BottomNavigationRailButton(
                                        page: element,
                                        on: state.page == element,
                                      ),
                            );
                          } else {
                            return VerticalDivider(
                              color: Colors.transparent,
                              thickness: 0,
                              width: converter.w(12),
                            );
                          }
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
    ),
  );
}
