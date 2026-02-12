import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';

class LinkHodRequiredPopup extends StatelessWidget {
  final String email;

  const LinkHodRequiredPopup({super.key, required this.email});

  static Future<void> show(BuildContext context, {required String email}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LinkHodRequiredPopup(email: email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: KpctAspectRatio(
          designWidth: designWidth,
          designHeight: 300,
          builder:
              (converter) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "계정 연동 필요",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      letterSpacing: 0,
                      color: Colors.white,
                      fontWeight: FontWeightAlias.bold,
                      fontSize: converter.h(28),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: converter.h(8)),
                  Text(
                    "Hall of Dimension",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      letterSpacing: 0,
                      color: const Color(0xFF02D7FF),
                      fontWeight: FontWeightAlias.semiBold,
                      fontSize: converter.h(16),
                      height: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    thickness: 0,
                    height: converter.h(20),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: converter.w(20)),
                    child: Text(
                      "해당 기능을 이용하려면 Hall of Dimension(HOD) 계정 연동이 필요합니다.\n\n커뮤니티 웹사이트(hallofdimension.io)에서 계정을 연동한 후 다시 시도해 주세요.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        letterSpacing: 0,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeightAlias.medium,
                        fontSize: converter.h(13),
                        height: 1.5,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    thickness: 0,
                    height: converter.h(20),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "현재 로그인: $email",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        letterSpacing: 0,
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeightAlias.medium,
                        fontSize: converter.h(12),
                        height: 1,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    thickness: 0,
                    height: converter.h(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: converter.w(100),
                        height: converter.h(40),
                        child: KpctCupertinoButton.outlinedSolid(
                          onPressed: () => Navigator.of(context).pop(),
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.all(converter.radius(20)),
                          child: Text(
                            "닫기",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeightAlias.bold,
                              fontSize: converter.h(16),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.transparent,
                        width: converter.w(10),
                      ),
                      SizedBox(
                        width: converter.w(120),
                        height: converter.h(40),
                        child: KpctCupertinoButton.outlinedSolid(
                          onPressed: () {
                            Navigator.of(context).pop();
                            App.instance.auth.signOut();
                          },
                          color: Colors.white,
                          borderRadius: BorderRadius.all(converter.radius(20)),
                          child: Text(
                            "로그아웃",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeightAlias.bold,
                              fontSize: converter.h(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
