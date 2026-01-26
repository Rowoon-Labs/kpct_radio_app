import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/route/sign/sign_bloc.dart';

class SignRoute extends StatelessWidget {
  const SignRoute({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (context) => SignBloc()..add(SignEvent.initialize(context: context)),
    child: BlocBuilder<SignBloc, SignState>(
      buildWhen:
          (previous, current) => (previous.initialized != current.initialized),
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Assets.background.sign.image(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Center(
                child: KpctAspectRatio(
                  designWidth: designWidth,
                  designHeight: 347 + 83 + 40 + 16 + 40,
                  builder:
                      (converter) => Stack(
                        children: [
                          PositionedDirectional(
                            top: 0,
                            start: converter.hcx(271),
                            width: converter.w(271),
                            height: converter.h(347),
                            child: Assets.clipart.logo.image(
                              fit: BoxFit.cover,
                              width: converter.w(271),
                              height: converter.h(347),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: converter.h(40 + 16),
                            start: converter.hcx(259),
                            width: converter.w(259),
                            height: converter.h(40),
                            child: _buildSignButton(
                              context: context,
                              converter: converter,
                              text: "Sign in with Google",
                              icon: Assets.icon.googleIcon,
                              onPressed:
                                  () => context.read<SignBloc>().add(
                                    const SignEvent.signInWithGoogle(),
                                  ),
                              radius: 24,
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 0,
                            start: converter.hcx(259),
                            width: converter.w(259),
                            height: converter.h(40),
                            child: _buildSignButton(
                              context: context,
                              converter: converter,
                              text: "Sign in with Apple",
                              icon: Assets.icon.appleIcon,
                              onPressed:
                                  () => context.read<SignBloc>().add(
                                    const SignEvent.signInWithApple(),
                                  ),
                              radius: 24,
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  Widget _buildSignButton({
    required BuildContext context,
    required KpctConverter converter,
    required AssetGenImage icon,
    required String text,
    required VoidCallback onPressed,
    double? radius,
  }) => KpctCupertinoButton.outlinedSolid(
    color: Colors.white,
    onPressed: onPressed,
    borderRadius: BorderRadius.all(converter.radius(radius ?? 8)),
    border: Border.all(
      color: const Color(0xFF1E2432).withOpacity(0.23),
      strokeAlign: BorderSide.strokeAlignInside,
      style: BorderStyle.solid,
      width: converter.h(1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon.image(
          fit: BoxFit.cover,
          width: converter.h(24),
          height: converter.h(24),
        ),
        SizedBox(width: converter.w(8)),
        Text(
          text,
          style: GoogleFonts.inter(
            height: 1,
            color: Colors.black,
            fontSize: converter.h(16),
            fontWeight: FontWeightAlias.medium,
            letterSpacing: 0,
          ),
        ),
      ],
    ),
  );
}
