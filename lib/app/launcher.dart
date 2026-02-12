import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';

class Launcher extends StatefulWidget {
  const Launcher({super.key});

  @override
  State<StatefulWidget> createState() => _Launcher();
}

class _Launcher extends State<Launcher> {
  late bool _initialized;

  _Launcher() : _initialized = false;

  @override
  void initState() {
    super.initState();

    App.initialize().then((value) {
      setState(() {
        _initialized = true;
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Future.wait([
          GoogleFonts.pendingFonts([
            GoogleFonts.inter(),
            GoogleFonts.montserrat(),
          ]),
          precacheImage(
            Assets.component.bottomNavigationRailIdleOff.provider(),
            context,
          ),
          precacheImage(
            Assets.component.bottomNavigationRailStatusOn.provider(),
            context,
          ),
          precacheImage(
            Assets.component.bottomNavigationRailGearOn.provider(),
            context,
          ),
          precacheImage(
            Assets.component.bottomNavigationRailCraftingOn.provider(),
            context,
          ),
          precacheImage(
            Assets.component.bottomNavigationRailShopOn.provider(),
            context,
          ),
          precacheImage(
            Assets.component.bottomNavigationRailChatOn.provider(),
            context,
          ),
        ]).then(
          (value) =>
              Future.delayed(const Duration(milliseconds: 500)).then((value) {
                try {
                  FlutterNativeSplash.remove();
                } catch (e) {
                  if (kDebugMode) {
                    print("Splash remove error: $e");
                  }
                }
              }),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return MaterialApp.router(
        routerConfig: App.instance.navigator.router,
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(),
          scaffoldBackgroundColor: Colors.black,
        ),
        builder:
            (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: BotToastInit()(context, child),
            ),
      );
    } else {
      return Container(color: Colors.white);
    }
  }
}
