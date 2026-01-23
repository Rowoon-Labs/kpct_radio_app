import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/route/home/page/idle/pod/user_info/user_info_pod_bloc.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';

class UserInfoPod extends StatelessWidget {
  const UserInfoPod({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => UserInfoPodBloc(),
    child: KpctAspectRatio(
      designWidth: designWidth,
      designHeight: 89.24,
      builder:
          (converter) => Stack(
            children: [
              Assets.component.userInfoPod.image(
                width: converter.realSize.width,
                height: converter.realSize.height,
                fit: BoxFit.cover,
              ),
              PositionedDirectional(
                top: converter.h(11),
                start: converter.w(5),
                width: converter.w(77),
                height: converter.h(77),
                child: Stack(
                  children: [
                    WithAuth(
                      builder:
                          (user) => KpctSwitcher(
                            builder: () {
                              if (user.profileImageUrl != null) {
                                return PhysicalModel(
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  child: CachedNetworkImage(
                                    key: const ValueKey<String>(
                                      "hasProfileImage",
                                    ),
                                    imageUrl: user.profileImageUrl!,
                                    width: converter.w(77),
                                    height: converter.h(77),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return const SizedBox(
                                  key: ValueKey<String>("noProfileImage"),
                                );
                              }
                            },
                          ),
                    ),
                    Assets.component.userInfoProfileCover.image(
                      width: converter.w(77),
                      height: converter.h(77),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                top: converter.h(31),
                start: converter.w(115),
                width: converter.w(70),
                height: converter.h(24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: WithAuth(
                    builder:
                        (user) => FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: OutlinedText(
                            user.level.toString().padLeft(3, "0"),
                            strokeColor: Colors.black,
                            strokeWidth: converter.h(1),
                            textAlign: TextAlign.end,
                            style: GoogleFonts.inter(
                              letterSpacing: 0,
                              color: const Color(0xFF00FF00),
                              fontWeight: FontWeightAlias.semiBold,
                              fontSize: converter.h(20),
                              fontStyle: FontStyle.italic,
                              height: 1,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: converter.h(65),
                start: converter.w(99),
                width: converter.w(105),
                height: converter.h(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(converter.radius(4)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0, 0.49],
                          colors: [Color(0x0012BAF3), Color(0xFFEAF37F)],
                        ),
                      ),
                      child: WithAuth(
                        builder:
                            (user) => SizedBox(
                              height: converter.h(6),
                              width: converter.w(
                                105 *
                                    ((user.exp == user.maxExp)
                                        ? 1
                                        : (user.exp / user.maxExp)),
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: converter.h(26),
                end: converter.w(54.09),
                width: converter.w(61.91),
                height: converter.h(21),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: converter.w(2.91 * 2),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: WithAuth(
                      builder:
                          (user) => FittedBox(
                            alignment: Alignment.centerRight,
                            fit: BoxFit.scaleDown,
                            child: OutlinedText(
                              user.radioSsp.toString().padLeft(3, "0"),
                              strokeColor: Colors.black,
                              strokeWidth: converter.h(1),
                              textAlign: TextAlign.end,
                              style: GoogleFonts.inter(
                                letterSpacing: 0,
                                color: const Color(0xFF00FF00),
                                fontWeight: FontWeightAlias.semiBold,
                                fontSize: converter.h(13),
                                fontStyle: FontStyle.italic,
                                height: 1,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: converter.h(51),
                end: converter.w(54.09),
                width: converter.w(61.91),
                height: converter.h(21),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: converter.w(2.91 * 2),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: WithAuth(
                      builder:
                          (user) => FittedBox(
                            alignment: Alignment.centerRight,
                            fit: BoxFit.scaleDown,
                            child: OutlinedText(
                              user.ep.toString().padLeft(3, "0"),
                              strokeColor: Colors.black,
                              strokeWidth: converter.h(1),
                              textAlign: TextAlign.end,
                              style: GoogleFonts.inter(
                                letterSpacing: 0,
                                color: const Color(0xFF00FF00),
                                fontWeight: FontWeightAlias.semiBold,
                                fontSize: converter.h(13),
                                fontStyle: FontStyle.italic,
                                height: 1,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: converter.h(54),
                start: converter.w(93),
                width: converter.w(117.59),
                height: converter.h(10),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: converter.w(4.59)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: WithAuth(
                      builder:
                          (user) => FittedBox(
                            alignment: Alignment.centerRight,
                            fit: BoxFit.scaleDown,
                            child: OutlinedText(
                              "EXP ${user.exp.truncate()} / ${user.maxExp.truncate()}",
                              strokeColor: Colors.black,
                              strokeWidth: converter.h(1),
                              textAlign: TextAlign.end,
                              style: GoogleFonts.inter(
                                letterSpacing: 0,
                                color: const Color(0xFF00AFF1),
                                fontWeight: FontWeightAlias.semiBold,
                                fontSize: converter.h(8),
                                fontStyle: FontStyle.italic,
                                height: 1,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: converter.h(27),
                end: converter.w(9),
                width: converter.w(44),
                height: converter.h(44.37),
                child: WithAuth(
                  builder:
                      (user) => KpctSwitcher(
                        builder: () {
                          if (user.walletAddress != null) {
                            return Assets.component.walletLinked.image(
                              key: const ValueKey<String>("walletLinked"),
                              width: converter.w(44),
                              height: converter.h(44.37),
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Assets.component.walletUnlinked.image(
                              key: const ValueKey<String>("walletUnlined"),
                              width: converter.w(44),
                              height: converter.h(44.37),
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                ),
              ),
            ],
          ),
    ),
  );
}
