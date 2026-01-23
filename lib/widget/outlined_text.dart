import 'package:flutter/material.dart';
import 'dart:ui' as ui show TextHeightBehavior;

class OutlinedText extends StatelessWidget {
  final String data;
  final InlineSpan? textSpan;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  final double strokeWidth;
  final Color strokeColor;

  const OutlinedText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    required this.strokeWidth,
    required this.strokeColor,
  }) : textSpan = null;

  @override
  Widget build(BuildContext context) {
    final TextStyle? outlinedTextStyle;
    final TextStyle? tempTextStyle = style?.copyWith();
    if (tempTextStyle != null) {
      outlinedTextStyle = TextStyle(
        locale: tempTextStyle.locale,
        overflow: tempTextStyle.overflow,
        height: tempTextStyle.height,
        fontFamily: tempTextStyle.fontFamily,
        background: tempTextStyle.background,
        backgroundColor: tempTextStyle.backgroundColor,
        decoration: tempTextStyle.decoration,
        debugLabel: tempTextStyle.debugLabel,
        decorationColor: tempTextStyle.decorationColor,
        decorationStyle: tempTextStyle.decorationStyle,
        letterSpacing: tempTextStyle.letterSpacing,
        fontSize: tempTextStyle.fontSize,
        fontWeight: tempTextStyle.fontWeight,
        shadows: tempTextStyle.shadows,
        decorationThickness: tempTextStyle.decorationThickness,
        fontFamilyFallback: tempTextStyle.fontFamilyFallback,
        fontFeatures: tempTextStyle.fontFeatures,
        fontStyle: tempTextStyle.fontStyle,
        fontVariations: tempTextStyle.fontVariations,
        inherit: tempTextStyle.inherit,
        leadingDistribution: tempTextStyle.leadingDistribution,
        textBaseline: tempTextStyle.textBaseline,
        wordSpacing: tempTextStyle.wordSpacing,

        // package: ,
        // color: null,
        foreground: Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeMiterLimit
          ..strokeWidth = (strokeWidth * 3.25),
      );
    } else {
      outlinedTextStyle = null;
    }

    return Stack(
      key: key,
      children: [
        Text(
          data,
          textAlign: textAlign,
          overflow: overflow,
          softWrap: softWrap,
          maxLines: maxLines,
          locale: locale,
          selectionColor: selectionColor,
          semanticsLabel: semanticsLabel,
          strutStyle: strutStyle,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textScaler: textScaler,
          textWidthBasis: textWidthBasis,
          style: outlinedTextStyle,
          // style: style?.copyWith(
          //   foreground: Paint()
          //     ..style = PaintingStyle.stroke
          //     ..color = Colors.black
          //     ..strokeWidth = converter.w(4),
          // ),
        ),
        Text(
          data,
          textAlign: textAlign,
          overflow: overflow,
          softWrap: softWrap,
          maxLines: maxLines,
          locale: locale,
          selectionColor: selectionColor,
          semanticsLabel: semanticsLabel,
          strutStyle: strutStyle,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textScaler: textScaler,
          textWidthBasis: textWidthBasis,
          style: style,
        ),
      ],
    );
  }
}
