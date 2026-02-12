library kpct_switcher;

import 'package:flutter/widgets.dart';

typedef KpctSwitcherBuilder = Widget Function();

const Duration _defaultAnimationDuration = Duration(milliseconds: 500);

Widget _defaultTransitionBuilder(Widget child, Animation<double> animation) =>
    FadeTransition(
      opacity: animation,
      child: child,
    );

class KpctSwitcher extends AnimatedSwitcher {
  KpctSwitcher({
    super.key,
    super.duration = _defaultAnimationDuration,
    super.reverseDuration = _defaultAnimationDuration,
    super.switchInCurve = Curves.decelerate,
    super.switchOutCurve = Curves.decelerate,
    super.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
    super.transitionBuilder = _defaultTransitionBuilder,
    required KpctSwitcherBuilder builder,
  }) : super(
          child: builder(),
        );
}
