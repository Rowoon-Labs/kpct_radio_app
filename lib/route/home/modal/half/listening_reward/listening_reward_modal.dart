import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/route/home/modal/half/listening_reward/listening_reward_modal_bloc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';
import 'package:kpct_radio_app/widget/outlined_text.dart';

enum ListeningRewardModalResponse { cancel, success }

class ListeningRewardModal extends StatelessWidget {
  static Future<dynamic> launch({required BuildContext context}) async =>
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ListeningRewardModal._(),
      );

  const ListeningRewardModal._();

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            ListeningRewardModalBloc()
              ..add(const ListeningRewardModalEvent.initialize()),
    child: Builder(
      builder:
          (context) => SafeArea(
            child: PopScope(
              canPop: false,
              child: Scaffold(
                backgroundColor: Colors.black.withOpacity(0.7),
                body: Center(
                  child: KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 329,
                    designPadding: const EdgeInsets.symmetric(horizontal: 11),
                    builder:
                        (converter) => BlocBuilder<
                          ListeningRewardModalBloc,
                          ListeningRewardModalState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  (previous.initialized != current.initialized),
                          builder:
                              (context, state) => KpctSwitcher(
                                builder: () {
                                  if (state.initialized) {
                                    return BlocBuilder<
                                      ListeningRewardModalBloc,
                                      ListeningRewardModalState
                                    >(
                                      key: ValueKey<bool>(state.initialized),
                                      buildWhen:
                                          (previous, current) =>
                                              (previous.status !=
                                                  current.status),
                                      builder:
                                          (context, state) => Stack(
                                            children: [
                                              Assets.background.halfModal.image(
                                                width: converter.realSize.width,
                                                height:
                                                    converter.realSize.height,
                                                fit: BoxFit.contain,
                                              ),
                                              PositionedDirectional(
                                                top: converter.h(40),
                                                start: 0,
                                                end: 0,
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Text(
                                                    "LISTENING REWARD",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                      letterSpacing: 0,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: const Color(
                                                        0xFF13BE13,
                                                      ),
                                                      fontWeight:
                                                          FontWeightAlias.bold,
                                                      fontSize: converter.h(20),
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              PositionedDirectional(
                                                top: converter.h(121),
                                                start: converter.w(0),
                                                end: converter.w(0),
                                                height: converter.h(57.5),
                                                child: KpctSwitcher(
                                                  builder: () {
                                                    final ValueKey<
                                                      ListeningRewardModalStatus
                                                    >
                                                    key = ValueKey(
                                                      state.status,
                                                    );
                                                    switch (key.value) {
                                                      case ListeningRewardModalStatus
                                                          .success:
                                                        return Center(
                                                          key: key,
                                                          child: BlocBuilder<
                                                            ListeningRewardModalBloc,
                                                            ListeningRewardModalState
                                                          >(
                                                            buildWhen:
                                                                (
                                                                  previous,
                                                                  current,
                                                                ) =>
                                                                    (previous
                                                                            .rewardSsp !=
                                                                        current
                                                                            .rewardSsp) ||
                                                                    (previous
                                                                            .rewardEp !=
                                                                        current
                                                                            .rewardEp),
                                                            builder: (
                                                              context,
                                                              state,
                                                            ) {
                                                              final List<Widget>
                                                              children = [
                                                                if (state
                                                                        .rewardSsp >
                                                                    0) ...[
                                                                  _buildReward(
                                                                    context:
                                                                        context,
                                                                    converter:
                                                                        converter,
                                                                    image:
                                                                        Assets
                                                                            .component
                                                                            .sspIcon,
                                                                    label:
                                                                        "SSP",
                                                                    text:
                                                                        state
                                                                            .rewardSsp
                                                                            .toString(),
                                                                  ),
                                                                ],
                                                                if (state
                                                                        .rewardEp >
                                                                    0) ...[
                                                                  _buildReward(
                                                                    context:
                                                                        context,
                                                                    converter:
                                                                        converter,
                                                                    image:
                                                                        Assets
                                                                            .component
                                                                            .epIcon,
                                                                    label: "EP",
                                                                    text:
                                                                        state
                                                                            .rewardEp
                                                                            .toString(),
                                                                  ),
                                                                ],
                                                              ];

                                                              return ListView.separated(
                                                                padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      converter
                                                                          .w(
                                                                            52.5,
                                                                          ),
                                                                ),
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemCount:
                                                                    children
                                                                        .length,
                                                                shrinkWrap:
                                                                    true,
                                                                separatorBuilder:
                                                                    (
                                                                      context,
                                                                      index,
                                                                    ) => VerticalDivider(
                                                                      color:
                                                                          Colors
                                                                              .transparent,
                                                                      width: converter
                                                                          .w(
                                                                            48,
                                                                          ),
                                                                      thickness:
                                                                          0,
                                                                    ),
                                                                itemBuilder:
                                                                    (
                                                                      context,
                                                                      index,
                                                                    ) =>
                                                                        children[index],
                                                              );
                                                            },
                                                          ),
                                                        );

                                                      case ListeningRewardModalStatus
                                                          .fail:
                                                        return Center(
                                                          key: key,
                                                          child: Text(
                                                            "다시 시도해 주세요",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: GoogleFonts.inter(
                                                              letterSpacing: 0,
                                                              color:
                                                                  const Color(
                                                                    0xFF24E85B,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeightAlias
                                                                      .semiBold,
                                                              // fontStyle: FontStyle.italic,
                                                              fontSize:
                                                                  converter.h(
                                                                    9,
                                                                  ),
                                                              height: 1,
                                                            ),
                                                          ),
                                                        );

                                                      case ListeningRewardModalStatus
                                                          .processing:
                                                        return SizedBox(
                                                          key: key,
                                                        );
                                                    }
                                                  },
                                                ),
                                              ),
                                              PositionedDirectional(
                                                end: converter.hcx(54),
                                                bottom: converter.h(7),
                                                width: converter.w(54),
                                                height: converter.h(57),
                                                child: KpctSwitcher(
                                                  builder:
                                                      () => KpctCupertinoButton.solid(
                                                        key: ValueKey<bool>(
                                                          state.status ==
                                                              ListeningRewardModalStatus
                                                                  .processing,
                                                        ),
                                                        onPressed:
                                                            () => Navigator.pop(
                                                              context,
                                                            ),
                                                        child: Assets
                                                            .component
                                                            .closeCircleButtonEnabled
                                                            .image(
                                                              width: converter
                                                                  .w(54),
                                                              height: converter
                                                                  .h(57),
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    );
                                  } else {
                                    return Stack(
                                      key: ValueKey<bool>(state.initialized),
                                      children: [
                                        Assets.background.halfModal.image(
                                          width: converter.realSize.width,
                                          height: converter.realSize.height,
                                          fit: BoxFit.contain,
                                        ),
                                        PositionedDirectional(
                                          top: converter.h(40),
                                          start: 0,
                                          end: 0,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              "LISTENING REWARD",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                letterSpacing: 0,
                                                fontStyle: FontStyle.italic,
                                                color: const Color(0xFF13BE13),
                                                fontWeight:
                                                    FontWeightAlias.bold,
                                                fontSize: converter.h(20),
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          top: converter.h(40 + 24),
                                          start: 0,
                                          end: 0,
                                          bottom: converter.h(85),
                                          child:
                                              const CustomCircularProgressIndicator(),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                        ),
                  ),
                ),
              ),
            ),
          ),
    ),
  );

  Widget _buildReward({
    required KpctConverter converter,
    required BuildContext context,
    required AssetGenImage image,
    required String label,
    String? text,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.all(converter.radius(8)),
          child: Stack(
            children: [
              image.image(
                width: converter.w(42),
                height: converter.h(42),
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
              if (text != null) ...[
                PositionedDirectional(
                  end: converter.w(4),
                  bottom: converter.h(6),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: OutlinedText(
                      strokeColor: Colors.black,
                      strokeWidth: converter.h(1),
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        letterSpacing: 0,
                        color: Colors.white,
                        fontWeight: FontWeightAlias.semiBold,
                        fontStyle: FontStyle.italic,
                        fontSize: converter.h(8),
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      SizedBox(
        height: converter.h(12),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              letterSpacing: 0,
              color: const Color(0xFF24BD24),
              fontWeight: FontWeightAlias.regular,
              // fontStyle: FontStyle.italic,
              fontSize: converter.h(10),
              height: 1,
            ),
          ),
        ),
      ),
    ],
  );
}
