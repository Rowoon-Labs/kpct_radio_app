import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kpct_radio_app/route/home/home_route.dart';
import 'package:kpct_radio_app/route/sign/sign_route.dart';

class NavigatorCore {
  final GlobalKey<NavigatorState> key;

  late GoRouter _router;

  GoRouter get router => _router;

  NavigatorCore() : key = GlobalKey<NavigatorState>();

  void pop<T extends Object?>([T? result]) => key.currentContext?.pop(result);
  void go(String location, {Object? extra}) =>
      key.currentContext?.go(location, extra: extra);
  Future<T?> push<T extends Object?>(String location, {Object? extra}) async =>
      await key.currentContext?.push<T?>(location, extra: extra);

  Future<void> initialize() async {
    _router = GoRouter(
      initialLocation: "/sign",
      navigatorKey: key,
      routes: [
        GoRoute(
          path: "/sign",
          pageBuilder:
              (context, state) => CupertinoPage<void>(
                name: "sign",
                key: state.pageKey,
                child: SignRoute(key: state.pageKey),
              ),
        ),
        GoRoute(
          path: "/home",
          pageBuilder:
              (context, state) => CupertinoPage<void>(
                name: "home",
                key: state.pageKey,
                child: HomeRoute(key: state.pageKey),
              ),
        ),
      ],
    );
  }
}
