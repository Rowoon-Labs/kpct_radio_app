import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/route/home/modal/full/setting/setting_modal_bloc.dart';

class SettingModal extends StatelessWidget {
  const SettingModal({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) => SettingModalBloc()..add(const SettingModalEvent.initialize()),
    child: SafeArea(
      child: LayoutBuilder(
        builder:
            (context, constraints) => Stack(
              children: [
                Assets.background.common.image(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    KpctAspectRatio(
                      designWidth: designWidth,
                      designHeight: 46,
                      builder:
                          (converter) => Stack(
                            children: [
                              PositionedDirectional(
                                top: converter.h(6),
                                start: converter.w(5),
                                width: converter.w(126),
                                height: converter.h(21),
                                child: Assets.component.consoleTypeTitleSetting
                                    .image(
                                      width: converter.w(126),
                                      height: converter.h(21),
                                      // fit: BoxFit.cover,
                                    ),
                              ),
                              PositionedDirectional(
                                top: converter.h(5),
                                end: converter.w(6),
                                width: converter.w(27),
                                height: converter.h(27),
                                child: KpctCupertinoButton(
                                  onPressed: () => Navigator.pop(context),
                                  alignment: Alignment.topCenter,
                                  child: Assets.component.closeButton.image(
                                    width: converter.w(27),
                                    height: converter.h(27),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),

                    KpctAspectRatio.padding(
                      designWidth: designWidth,
                      designHeight: 82.92,
                      designPadding: const EdgeInsets.only(left: 8, right: 7),
                      builder:
                          (converter) => Stack(
                            children: [
                              Assets.component.settingAccount.image(
                                width: converter.realSize.width,
                                height: converter.realSize.height,
                                // fit: BoxFit.cover,
                              ),
                              PositionedDirectional(
                                top: converter.h(10),
                                start: converter.w(12),
                                width: converter.w(55),
                                height: converter.h(55),
                                child: WithAuth(
                                  builder:
                                      (user) => Center(
                                        child: KpctSwitcher(
                                          builder: () {
                                            if (user.profileImageUrl != null) {
                                              return PhysicalModel(
                                                clipBehavior: Clip.antiAlias,
                                                color: Colors.transparent,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                  converter.radius(4),
                                                ),
                                                child: CachedNetworkImage(
                                                  key: const ValueKey<String>(
                                                    "hasProfileImage",
                                                  ),
                                                  imageUrl:
                                                      user.profileImageUrl!,
                                                  width: converter.w(55),
                                                  height: converter.h(55),
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            } else {
                                              return const SizedBox(
                                                key: ValueKey<String>(
                                                  "noProfileImage",
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                ),
                              ),
                              PositionedDirectional(
                                top: converter.h(42),
                                start: converter.w(84),
                                end: converter.w(84),
                                height: converter.h(12),
                                child: WithAuth(
                                  builder:
                                      (user) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          user.email,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            letterSpacing: 0,
                                            color: const Color(0xFF00BE20),
                                            fontWeight: FontWeightAlias.regular,
                                            fontSize: converter.h(10),
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                              PositionedDirectional(
                                top: converter.h(10),
                                end: converter.w(22),
                                width: converter.w(54),
                                height: converter.h(57),
                                child: KpctCupertinoButton.solid(
                                  onPressed: () async {
                                    App.instance.overlay.cover(on: true);

                                    await App.instance.auth.signOut().then(
                                      (value) =>
                                          App.instance.overlay.cover(on: true),
                                    );
                                  },
                                  child: Assets.component.settingLogoutButton
                                      .image(
                                        width: converter.w(54),
                                        height: converter.h(57),
                                        fit: BoxFit.contain,
                                      ),
                                ),
                              ),
                            ],
                          ),
                    ),

                    // const KpctSeparator(
                    //   designWidth: designWidth,
                    //   designHeight: 14.08,
                    // ),
                    //
                    // KpctAspectRatio.padding(
                    //   designWidth: designWidth,
                    //   designHeight: 82.92,
                    //   designPadding: const EdgeInsets.only(
                    //     left: 8,
                    //     right: 7,
                    //   ),
                    //   builder: (converter) => Stack(
                    //     children: [
                    //       Assets.component.settingWifi.image(
                    //         width: converter.realSize.width,
                    //         height: converter.realSize.height,
                    //         // fit: BoxFit.cover,
                    //       ),
                    //       PositionedDirectional(
                    //         top: converter.h(10),
                    //         end: converter.w(22),
                    //         width: converter.w(54),
                    //         height: converter.h(57),
                    //         child: KpctCupertinoButton.solid(
                    //           onPressed: () {},
                    //           child: Assets.component.settingWifiOnButton.image(
                    //             width: converter.w(54),
                    //             height: converter.h(57),
                    //             fit: BoxFit.contain,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
      ),
    ),
  );
}
