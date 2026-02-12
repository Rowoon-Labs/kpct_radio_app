import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

extension GearTierExtension on GearTier {
  AssetGenImage get assetGenImage =>
      AssetGenImage("assets/tier/tier_${index + 1}.png");
}

extension GearCategoryExtension on GearCategory {
  AssetGenImage assetGenImage({required String icon}) {
    final String prefix;
    switch (this) {
      case GearCategory.radioSkin:
        prefix = "assets/gear/radio";

      case GearCategory.listeningGear:
        prefix = "assets/gear/lg";

      case GearCategory.accessory:
        prefix = "assets/gear/accessory";

      case GearCategory.parts:
        prefix = "assets/gear/parts";

      case GearCategory.gem:
        prefix = "assets/gear/gem";

      case GearCategory.nft:
        throw Exception();
    }

    final String imagePath = "$prefix/$icon.png";

    return AssetGenImage(imagePath);
  }

  /// 안전한 이미지 위젯 생성 (에러 발생 시 대체 이미지 표시)
  Widget safeImage({
    required String icon,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      assetGenImage(icon: icon).path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        if (kDebugMode) {
          print('이미지 로딩 실패: ${assetGenImage(icon: icon).path}');
          print('에러: $error');
          print('스택트레이스: $stackTrace');
        }

        // 에러 발생 시 빈 컨테이너 반환
        return Container(
          width: width,
          height: height,
          color: Colors.grey.withOpacity(0.3),
          child: const Icon(Icons.error_outline, color: Colors.grey),
        );
      },
    );
  }

  String get tabBarTitle {
    switch (this) {
      case GearCategory.radioSkin:
        return "라디오스킨";

      case GearCategory.listeningGear:
        return "리스닝기어";

      case GearCategory.accessory:
        return "악세서리";

      case GearCategory.parts:
        return "파츠";

      case GearCategory.gem:
        return "GEM";

      case GearCategory.nft:
        return "NFT";
    }
  }

  AssetGenImage tabBarAssetGenImage(bool selected) {
    switch (this) {
      case GearCategory.radioSkin:
        return selected
            ? Assets.component.tabBar60Selected
            : Assets.component.tabBar60Unselected;

      case GearCategory.listeningGear:
        return selected
            ? Assets.component.tabBar62Selected
            : Assets.component.tabBar62Unselected;

      case GearCategory.accessory:
      case GearCategory.parts:
      case GearCategory.gem:
        return selected
            ? Assets.component.tabBar61Selected
            : Assets.component.tabBar61Unselected;

      case GearCategory.nft:
        return selected
            ? Assets.component.tabBar60Selected
            : Assets.component.tabBar60Unselected;
    }
  }

  Size tabBarDesignSize(bool selected) {
    switch (this) {
      case GearCategory.radioSkin:
        return selected ? const Size(60, 30) : const Size(60, 26);

      case GearCategory.listeningGear:
        return selected ? const Size(62, 30) : const Size(62, 26);

      case GearCategory.accessory:
      case GearCategory.parts:
      case GearCategory.gem:
        return selected ? const Size(61, 30) : const Size(61, 26);

      case GearCategory.nft:
        return selected ? const Size(60, 30) : const Size(60, 26);
    }
  }
}
