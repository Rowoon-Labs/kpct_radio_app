import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';

class OverlayCore {
  CancelFunc? _coverCancelFunc;

  OverlayCore();

  void cover({required bool on, String? message}) {
    if (on) {
      _coverCancelFunc ??= BotToast.showAnimationWidget(
        toastBuilder:
            (_) => Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: const Center(
                    child: SizedBox.square(
                      dimension: kToolbarHeightDiv3,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        allowClick: true,
        clickClose: false,
        enableKeyboardSafeArea: false,
        backgroundColor: Colors.black.withOpacity(0.5),
        animationDuration: defaultAnimationDuration,
        backButtonBehavior: BackButtonBehavior.ignore,
        animationReverseDuration: defaultAnimationDuration,
      );
    } else {
      _coverCancelFunc?.call();
      _coverCancelFunc = null;
    }
  }
}
