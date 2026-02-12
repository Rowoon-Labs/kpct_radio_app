library kpct_aspect_ratio;

import 'dart:math' as lib_math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef KpctAspectRatioBuilder = Widget Function(KpctConverter converter);

class KpctConverter {
  final Size designSize;
  final Size realSize;

  KpctConverter._({
    required this.designSize,
    required this.realSize,
  });

  static flex({
    required BuildContext context,
    required double flex,
    required double designWidth,
  }) =>
      MediaQuery.of(context).size.width * (flex / designWidth);

  /// 전체 스크린에 대하여 Conveter를 생성 합니다
  /// KpctAspectRatio의 maxWidthRatio는 처리 하지만
  /// maxHeightRatio나 자동 최적화된 AspectRatio에 대한건
  /// 처리하지 않으니 주의해서 사용하세요
  KpctConverter.aboutScreenWidth({
    required double designWidth,
    required double designHeight,
    double maxWidthRatio = 1,
    required BuildContext context,
  })  : designSize = Size(
          designWidth,
          designHeight,
        ),
        realSize = _calculateRealSize(
          context: context,
          designSize: Size(
            designWidth,
            designHeight,
          ),
          maxWidthRatio: maxWidthRatio,
        );

  @Deprecated("use KpctConverter.aboutScreenWidth")
  KpctConverter.fromRealWidth({
    required Size design,
    required double realWidth,
  })  : designSize = design,
        realSize = Size(realWidth,
            _divideAndMultiply(design.height, design.width, realWidth));

  static Size _calculateRealSize({
    required BuildContext context,
    required Size designSize,
    required double maxWidthRatio,
  }) {
    final double radioAdjustedScreenWidth =
        MediaQuery.of(context).size.width * maxWidthRatio;

    return Size(
      radioAdjustedScreenWidth,
      _divideAndMultiply(
          designSize.height, designSize.width, radioAdjustedScreenWidth),
    );
  }

  static double _divideAndMultiply(double x, double y, double z) => (x / y) * z;

  /// Circular Radius
  Radius radius(double value) => Radius.elliptical(w(value), h(value));

  /// min
  double min(double value) => lib_math.min(w(value), h(value));

  /// average
  double average(double value) => (min(value) + max(value)) / 2;

  /// max
  double max(double value) => lib_math.max(w(value), h(value));

  /// Conver Design Width to Real Width
  double w(double value) =>
      _divideAndMultiply(realSize.width, designSize.width, value);

  /// Conver Design Height to Real Height
  double h(double value) =>
      _divideAndMultiply(realSize.height, designSize.height, value);

  /// Convert Design Width to Real X for Horizontal Center
  double hcx(double value) =>
      (designSize.width - value) / 2.0 * realSize.width / designSize.width;

  /// Convert Design Height to Real Y for Vertical Center
  double vcy(double value) =>
      (designSize.height - value) / 2.0 * realSize.height / designSize.height;
}

class KpctAspectRatio extends StatelessWidget {
  final KpctAspectRatioBuilder builder;

  final double designWidth;
  final double designHeight;

  final double maxWidthRatio;
  final double maxHeightRatio;

  final Alignment align;

  final EdgeInsets? designPadding;

  const KpctAspectRatio({
    super.key,
    required this.designWidth,
    required this.designHeight,
    this.maxWidthRatio = 1,
    this.maxHeightRatio = 1,
    this.align = Alignment.center,
    required this.builder,
  }) : designPadding = null;

  const KpctAspectRatio.padding({
    super.key,
    required this.designWidth,
    required this.designHeight,
    required this.designPadding,
    this.maxWidthRatio = 1,
    this.maxHeightRatio = 1,
    this.align = Alignment.center,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (designPadding == null) {
      return LayoutBuilder(
        key: key,
        builder: (_, constraints) {
          final Rect rect;

          final double viewPortWidth = (constraints.hasBoundedWidth
                  ? constraints.maxWidth
                  : MediaQuery.of(context).size.width) *
              maxWidthRatio;
          final double viewPortHeight = (constraints.hasBoundedHeight
                  ? constraints.maxHeight
                  : MediaQuery.of(context).size.height) *
              maxHeightRatio;

          final double innerRatio = designWidth / designHeight;
          final double outerRatio = viewPortWidth / viewPortHeight;

          if (innerRatio > outerRatio) {
            final double reverseInnerRatioMultiplyOuterWidth =
                viewPortWidth * (designHeight / designWidth);

            rect = Rect.fromLTRB(
              0,
              (viewPortHeight - reverseInnerRatioMultiplyOuterWidth) / 2,
              viewPortWidth,
              (viewPortHeight + reverseInnerRatioMultiplyOuterWidth) / 2,
            );
          } else {
            final double innerRatioMultiplyOuterHeight =
                viewPortHeight * innerRatio;

            rect = Rect.fromLTRB(
              (viewPortWidth - innerRatioMultiplyOuterHeight) / 2,
              0,
              (viewPortWidth + innerRatioMultiplyOuterHeight) / 2,
              viewPortHeight,
            );
          }

          return SizedBox(
            key: key,
            width: rect.size.width,
            height: rect.size.height,
            child: Align(
              alignment: align,
              child: builder(KpctConverter._(
                designSize: Size(
                  designWidth,
                  designHeight,
                ),
                realSize: rect.size,
              )),
            ),
          );
        },
      );
    } else {
      return KpctAspectRatio(
        key: key,
        designWidth: designWidth,
        designHeight: designHeight,
        maxWidthRatio: maxWidthRatio,
        maxHeightRatio: maxHeightRatio,
        align: align,
        builder: (converter) => Stack(
          children: [
            PositionedDirectional(
              top: converter.h(designPadding?.top ?? 0),
              end: converter.w(designPadding?.right ?? 0),
              start: converter.w(designPadding?.left ?? 0),
              bottom: converter.h(designPadding?.bottom ?? 0),
              child: KpctAspectRatio(
                designWidth: designWidth -
                    (designPadding?.left ?? 0) -
                    (designPadding?.right ?? 0),
                designHeight: designHeight -
                    (designPadding?.top ?? 0) -
                    (designPadding?.bottom ?? 0),
                builder: builder,
              ),
            )
          ],
        ),
      );
    }
  }
}

class KpctSeparator extends StatelessWidget {
  final double designWidth;
  final double designHeight;

  const KpctSeparator({
    super.key,
    required this.designWidth,
    required this.designHeight,
  });

  @override
  Widget build(BuildContext context) => KpctAspectRatio(
        designWidth: designWidth,
        designHeight: designHeight,
        builder: (converter) => const SizedBox(),
      );
}

class KpctSeparatorSliver extends StatelessWidget {
  final double designWidth;
  final double designHeight;

  const KpctSeparatorSliver({
    super.key,
    required this.designWidth,
    required this.designHeight,
  });

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: KpctAspectRatio(
          designWidth: designWidth,
          designHeight: designHeight,
          builder: (converter) => const SizedBox(),
        ),
      );
}
