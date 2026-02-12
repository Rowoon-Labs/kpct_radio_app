import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/app/core/navigator_core.dart';
import 'package:kpct_radio_app/app/core/overlay_cover.dart';
import 'package:kpct_radio_app/app/repository/factory_repository.dart';
import 'package:kpct_radio_app/app/repository/reserved_repository.dart';
import 'package:kpct_radio_app/firebase_options.dart';
import 'package:logger/logger.dart';

class App {
  static final App _instance = App._();
  static App get instance => _instance;

  late NavigatorCore _navigator;
  late OverlayCore _overlay;
  late AuthCore _auth;
  late Logger _logger;

  NavigatorCore get navigator => _navigator;
  OverlayCore get overlay => _overlay;
  AuthCore get auth => _auth;
  Logger get log => _logger;

  late ReservedRepository _reserved;
  late FactoryRepository _factory;

  ReservedRepository get reserved => _reserved;
  FactoryRepository get factory => _factory;

  App._();

  static Future<void> initialize() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ),
    );

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _instance._overlay = OverlayCore();
    _instance._logger = Logger();

    _instance._navigator = NavigatorCore();
    _instance._auth = AuthCore();

    _instance._reserved = ReservedRepository();
    _instance._factory = FactoryRepository();

    await _instance._navigator.initialize();
    await _instance._auth.initialize();
  }
}
