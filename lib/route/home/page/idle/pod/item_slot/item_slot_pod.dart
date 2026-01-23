import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/app/misc/custom_extensions.dart';
import 'package:kpct_radio_app/route/home/home_bloc.dart';
import 'package:kpct_radio_app/route/home/page/gear/gear_page_bloc.dart';
import 'package:kpct_radio_app/route/home/page/idle/pod/item_slot/item_slot_pod_bloc.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

class ItemSlotPod extends StatelessWidget {
  const ItemSlotPod({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => ItemSlotPodBloc(),
    child: KpctAspectRatio(
      designWidth: designWidth,
      designHeight: 111.11,
      builder:
          (converter) => Stack(
            children: [
              Assets.component.itemSlotPod.image(
                width: converter.realSize.width,
                height: converter.realSize.height,
                fit: BoxFit.cover,
              ),
              PositionedDirectional(
                top: converter.h(14.85 - 1),
                start: converter.w(57 - 1),
                width: converter.w(1 + 51 + 1),
                height: converter.w(1 + 51 + 1),
                child: _buildSlot(
                  converter: converter,
                  category: GearCategory.radioSkin,
                  context: context,
                ),
              ),
              PositionedDirectional(
                top: converter.h(14.85 - 1),
                start: converter.w(128 - 1),
                width: converter.w(1 + 51 + 1),
                height: converter.w(1 + 51 + 1),
                child: _buildSlot(
                  converter: converter,
                  category: GearCategory.listeningGear,
                  context: context,
                ),
              ),
              PositionedDirectional(
                top: converter.h(14.85 - 1),
                start: converter.w(202 - 1),
                width: converter.w(1 + 51 + 1),
                height: converter.w(1 + 51 + 1),
                child: _buildSlot(
                  converter: converter,
                  category: GearCategory.accessory,
                  context: context,
                ),
              ),
            ],
          ),
    ),
  );

  Widget _buildSlot({
    required KpctConverter converter,
    required GearCategory category,
    required BuildContext context,
  }) => WithAuth(
    builder: (user) {
      final Widget child;

      final Gear? gear = App.instance.reserved.gear(
        id: user.installedEquipments[category]?.gearId,
      );
      if (gear != null) {
        child = Stack(
          alignment: Alignment.center,
          children: [
            gear.tier.assetGenImage.image(
              width: converter.w(51),
              height: converter.h(51),
              fit: BoxFit.contain,
            ),
            gear.category
                .assetGenImage(icon: gear.icon)
                .image(
                  width: converter.w(38),
                  height: converter.h(38),
                  fit: BoxFit.contain,
                ),
          ],
        );
      } else {
        child = const SizedBox.expand();
      }

      return KpctCupertinoButton(
        onPressed: () async {
          context.read<HomeBloc>().add(
            HomeEvent.switchPage(context: context, page: HomePage.gear),
          );
          context.read<GearPageBloc>().add(
            GearPageEvent.tabPressed(gearCategory: category),
          );
        },
        child: child,
      );
    },
  );
}
