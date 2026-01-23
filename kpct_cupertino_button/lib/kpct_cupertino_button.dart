library kpct_cupertino_button;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KpctCupertinoButton extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color disabledColor;
  final VoidCallback? onPressed;
  final double? minSize;
  final double? pressedOpacity;
  final BorderRadius? borderRadius;
  final Border? border;
  final AlignmentGeometry alignment;

  const KpctCupertinoButton({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    this.disabledColor = Colors.transparent,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.4,
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.center,
    required this.onPressed,
  })  : border = null,
        assert(pressedOpacity == null ||
            (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));

  const KpctCupertinoButton.solid({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.4,
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.center,
    required this.onPressed,
  })  : border = null,
        disabledColor = color ?? Colors.transparent,
        assert(pressedOpacity == null ||
            (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));

  const KpctCupertinoButton.outlined({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    this.disabledColor = Colors.transparent,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.4,
    this.borderRadius = BorderRadius.zero,
    this.border,
    this.alignment = Alignment.center,
    required this.onPressed,
  }) : assert(pressedOpacity == null ||
            (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));

  const KpctCupertinoButton.outlinedSolid({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.4,
    this.borderRadius = BorderRadius.zero,
    this.border,
    this.alignment = Alignment.center,
    required this.onPressed,
  })  : disabledColor = color ?? Colors.transparent,
        assert(pressedOpacity == null ||
            (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));

  @override
  Widget build(BuildContext context) {
    if (border != null) {
      return DecoratedBox(
        key: key,
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.transparent,
          border: border,
        ),
        child: CupertinoButton(
          key: key,
          padding: padding,
          color: color,
          borderRadius: borderRadius,
          disabledColor: disabledColor,
          minSize: minSize,
          pressedOpacity: pressedOpacity,
          alignment: alignment,
          onPressed: onPressed,
          child: child,
        ),
      );
    } else {
      return CupertinoButton(
        key: key,
        padding: padding,
        color: color,
        borderRadius: borderRadius,
        disabledColor: disabledColor,
        minSize: minSize,
        pressedOpacity: pressedOpacity,
        alignment: alignment,
        onPressed: onPressed,
        child: child,
      );
    }
  }
}
