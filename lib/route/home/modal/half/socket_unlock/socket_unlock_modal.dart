import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/app/asset/fonts.dart';
import 'package:kpct_radio_app/app/constant/constants.dart';
import 'package:kpct_radio_app/app/core/auth_core.dart';
import 'package:kpct_radio_app/model/unlock.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/half/socket_unlock/socket_unlock_modal_misc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

enum SocketUnlockModalResponse {
  cancel,
  noTargetKit,
  noSocketSlot,
  noEmptySocket,
  noTargetEquipment,
  noTargetUnlock,
  noNextInformation,

  success,
}

class SocketUnlockModal extends StatelessWidget {
  final ({int sspCost, int epCost, int probability}) next;
  final Unlock unlock;
  final Pack pack;

  static Future<dynamic> launch({
    required BuildContext context,
    required Pack? pack,
  }) async {
    if (pack != null) {
      if (pack.equipments.first.sockets.isNotEmpty) {
        final int indexOfFirstLockedSocket = pack.equipments.first.sockets
            .indexWhere((element) => (element.gearId == null));

        if (indexOfFirstLockedSocket == -1) {
          return SocketUnlockModalResponse.noEmptySocket;
        } else {
          final Unlock? unlock = App.instance.reserved.unlock(
            tier: pack.gear.tier,
          );

          if (unlock != null) {
            final int numberOfAlreadyUnlockedSockets =
                pack.equipments.first.sockets
                    .where((element) => (element.gearId != null))
                    .length;

            final ({int sspCost, int epCost, int probability})? next = unlock
                .next(
                  numberOfAlreadyUnlockedSockets:
                      numberOfAlreadyUnlockedSockets,
                );

            if (next != null) {
              return await showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (context) => SocketUnlockModal(
                      next: next,
                      pack: pack,
                      unlock: unlock,
                    ),
              );
            } else {
              return SocketUnlockModalResponse.noNextInformation;
            }
          } else {
            return SocketUnlockModalResponse.noTargetUnlock;
          }
        }
      } else {
        return SocketUnlockModalResponse.noSocketSlot;
      }
    } else {
      return SocketUnlockModalResponse.noTargetKit;
    }
  }

  const SocketUnlockModal({
    required this.unlock,
    required this.pack,
    required this.next,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (_) =>
            SocketUnlockModalBloc(pack: pack, unlock: unlock)
              ..add(const SocketUnlockModalEvent.initialize()),
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
                          SocketUnlockModalBloc,
                          SocketUnlockModalState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  (previous.initialized != current.initialized),
                          builder:
                              (context, state) => KpctSwitcher(
                                builder: () {
                                  if (state.initialized) {
                                    return BlocBuilder<
                                      SocketUnlockModalBloc,
                                      SocketUnlockModalState
                                    >(
                                      key: ValueKey<bool>(state.initialized),
                                      buildWhen:
                                          (previous, current) =>
                                              (previous.status !=
                                                  current.status),
                                      builder:
                                          (context, state) => WithAuth(
                                            builder: (user) {
                                              return Stack(
                                                children: [
                                                  KpctSwitcher(
                                                    builder:
                                                        () => Assets
                                                            .background
                                                            .halfModal
                                                            .image(
                                                              key: ValueKey<
                                                                SocketUnlockModalStatus
                                                              >(state.status),
                                                              width:
                                                                  converter
                                                                      .realSize
                                                                      .width,
                                                              height:
                                                                  converter
                                                                      .realSize
                                                                      .height,
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                  ),
                                                  PositionedDirectional(
                                                    start: converter.hcx(85),
                                                    top: converter.h(67),
                                                    width: converter.w(85),
                                                    height: converter.h(85),
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          (state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare)
                                                              ? 1
                                                              : 0,
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      child: Assets
                                                          .clipart
                                                          .unlock
                                                          .image(
                                                            width: converter.w(
                                                              85,
                                                            ),
                                                            height: converter.h(
                                                              85,
                                                            ),
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            fit: BoxFit.contain,
                                                          ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    start: converter.hcx(306),
                                                    top: converter.h(207),
                                                    width: converter.w(306),
                                                    height: converter.h(30),
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          (state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare)
                                                              ? 0.5
                                                              : 0,
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                converter
                                                                    .radius(5),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    start: converter.hcx(306),
                                                    top: converter.h(161),
                                                    width: converter.w(306),
                                                    height: converter.h(6),
                                                    child: AnimatedOpacity(
                                                      opacity:
                                                          (state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare)
                                                              ? 0
                                                              : 1,
                                                      duration:
                                                          defaultAnimationDuration,
                                                      curve:
                                                          defaultAnimationCurve,
                                                      child: Assets
                                                          .component
                                                          .modalGauge
                                                          .image(
                                                            width: converter.w(
                                                              306,
                                                            ),
                                                            height: converter.h(
                                                              6,
                                                            ),
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            fit: BoxFit.contain,
                                                          ),
                                                    ),
                                                  ),
                                                  AnimatedPositionedDirectional(
                                                    duration:
                                                        defaultAnimationDuration,
                                                    curve:
                                                        defaultAnimationCurve,
                                                    top: converter.h(
                                                      state.status ==
                                                              SocketUnlockModalStatus
                                                                  .prepare
                                                          ? 40
                                                          : 98,
                                                    ),
                                                    start: 0,
                                                    end: 0,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Text(
                                                        "SOCKET UNLOCK",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.inter(
                                                          letterSpacing: 0,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: const Color(
                                                            0xFF13BE13,
                                                          ),
                                                          fontWeight:
                                                              FontWeightAlias
                                                                  .bold,
                                                          fontSize: converter.h(
                                                            20,
                                                          ),
                                                          height: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    start: 0,
                                                    end: 0,
                                                    top: converter.h(135),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: AnimatedOpacity(
                                                        opacity:
                                                            (state.status ==
                                                                        SocketUnlockModalStatus
                                                                            .success) ||
                                                                    (state.status ==
                                                                        SocketUnlockModalStatus
                                                                            .fail)
                                                                ? 1
                                                                : 0,
                                                        duration:
                                                            defaultAnimationDuration,
                                                        curve:
                                                            defaultAnimationCurve,
                                                        child: Text(
                                                          state.status.result,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.inter(
                                                            letterSpacing: 0,
                                                            color: const Color(
                                                              0xFF24E85B,
                                                            ),
                                                            fontWeight:
                                                                FontWeightAlias
                                                                    .semiBold,
                                                            fontSize: converter
                                                                .h(10),
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    top: converter.h(161),
                                                    start: converter.w(11 + 35),
                                                    end: converter.w(12 + 34),
                                                    height: converter.h(6),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            SocketUnlockModalStatus
                                                                .prepare) {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                          );
                                                        } else {
                                                          return Align(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                            alignment:
                                                                Alignment
                                                                    .centerLeft,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                    converter
                                                                        .radius(
                                                                          4,
                                                                        ),
                                                                  ),
                                                              // borderRadius: BorderRadius.only(
                                                              //   topLeft: converter.radius(4),
                                                              //   bottomLeft: converter.radius(4),
                                                              // ),
                                                              child: DecoratedBox(
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                    begin:
                                                                        Alignment
                                                                            .centerRight,
                                                                    end:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    stops:
                                                                        const [
                                                                          0.49,
                                                                          1,
                                                                        ],
                                                                    colors: [
                                                                      const Color(
                                                                        0xFF24BD24,
                                                                      ),
                                                                      const Color(
                                                                        0xFF24E85B,
                                                                      ).withOpacity(
                                                                        0.33,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: BlocBuilder<
                                                                  SocketUnlockModalBloc,
                                                                  SocketUnlockModalState
                                                                >(
                                                                  buildWhen:
                                                                      (
                                                                        previous,
                                                                        current,
                                                                      ) =>
                                                                          (previous.elapsedDuration !=
                                                                              current.elapsedDuration),
                                                                  builder:
                                                                      (
                                                                        context,
                                                                        state,
                                                                      ) => SizedBox(
                                                                        // width: converter.w(261),
                                                                        height:
                                                                            converter.h(
                                                                              6,
                                                                            ),
                                                                        width: converter.w(
                                                                          261 *
                                                                              (state.elapsedDuration /
                                                                                  maximumElapsedDuration),
                                                                        ),
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    top: converter.h(172),
                                                    start: 0,
                                                    end: 0,
                                                    height: converter.h(18),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            SocketUnlockModalStatus
                                                                .prepare) {
                                                          return Row(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "성공확률",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: const Color(
                                                                    0xFF13BE13,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .semiBold,
                                                                  fontSize:
                                                                      converter
                                                                          .h(8),
                                                                  height: 1,
                                                                ),
                                                              ),
                                                              VerticalDivider(
                                                                color:
                                                                    Colors
                                                                        .transparent,
                                                                width: converter
                                                                    .w(97),
                                                                thickness: 0,
                                                              ),
                                                              Text(
                                                                "${next.probability}%",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: const Color(
                                                                    0xFF06FF98,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .regular,
                                                                  fontSize:
                                                                      converter
                                                                          .h(
                                                                            15,
                                                                          ),
                                                                  height: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    top: converter.h(211),
                                                    start: 0,
                                                    end: 0,
                                                    height: converter.h(22),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            SocketUnlockModalStatus
                                                                .prepare) {
                                                          return Row(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Assets
                                                                  .component
                                                                  .sspIcon
                                                                  .image(
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              21,
                                                                            ),
                                                                    height:
                                                                        converter
                                                                            .h(
                                                                              21,
                                                                            ),
                                                                    fit:
                                                                        BoxFit
                                                                            .contain,
                                                                  ),
                                                              VerticalDivider(
                                                                color:
                                                                    Colors
                                                                        .transparent,
                                                                width: converter
                                                                    .w(4.6),
                                                                thickness: 0,
                                                              ),
                                                              Text(
                                                                "${user.radioSsp}/${next.sspCost}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: const Color(
                                                                    0xFF13ED51,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .regular,
                                                                  fontSize:
                                                                      converter
                                                                          .h(
                                                                            12,
                                                                          ),
                                                                  height: 1,
                                                                ),
                                                              ),
                                                              VerticalDivider(
                                                                color:
                                                                    Colors
                                                                        .transparent,
                                                                width: converter
                                                                    .w(42),
                                                                thickness: 0,
                                                              ),
                                                              Assets
                                                                  .component
                                                                  .epIcon
                                                                  .image(
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              21,
                                                                            ),
                                                                    height:
                                                                        converter
                                                                            .h(
                                                                              22,
                                                                            ),
                                                                    fit:
                                                                        BoxFit
                                                                            .contain,
                                                                  ),
                                                              VerticalDivider(
                                                                color:
                                                                    Colors
                                                                        .transparent,
                                                                width: converter
                                                                    .w(4.6),
                                                                thickness: 0,
                                                              ),
                                                              Text(
                                                                "${user.ep}/${next.epCost}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.inter(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: const Color(
                                                                    0xFF13ED51,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeightAlias
                                                                          .regular,
                                                                  fontSize:
                                                                      converter
                                                                          .h(
                                                                            12,
                                                                          ),
                                                                  height: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    start: converter.w(89),
                                                    bottom: converter.h(7),
                                                    width: converter.w(54),
                                                    height: converter.h(57),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            SocketUnlockModalStatus
                                                                .prepare) {
                                                          final bool canUnlock =
                                                              (user.radioSsp >=
                                                                  next.sspCost) &&
                                                              (user.ep >=
                                                                  next.epCost);

                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                            onPressed:
                                                                !canUnlock
                                                                    ? null
                                                                    : () => context
                                                                        .read<
                                                                          SocketUnlockModalBloc
                                                                        >()
                                                                        .add(
                                                                          SocketUnlockModalEvent.unlockPressed(
                                                                            gearId:
                                                                                pack.gear.id,
                                                                            unlockId:
                                                                                unlock.id,
                                                                            equipmentId:
                                                                                pack.equipments.first.id,
                                                                          ),
                                                                        ),
                                                            child: KpctSwitcher(
                                                              builder: () {
                                                                if (canUnlock) {
                                                                  return Assets.component.unlockCircleButtonEnabled.image(
                                                                    key: ValueKey<
                                                                      bool
                                                                    >(
                                                                      canUnlock,
                                                                    ),
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              54,
                                                                            ),
                                                                    height:
                                                                        converter
                                                                            .h(
                                                                              57,
                                                                            ),
                                                                    fit:
                                                                        BoxFit
                                                                            .contain,
                                                                  );
                                                                } else {
                                                                  return Assets.component.unlockCircleButtonDisabled.image(
                                                                    key: ValueKey<
                                                                      bool
                                                                    >(
                                                                      canUnlock,
                                                                    ),
                                                                    width:
                                                                        converter
                                                                            .w(
                                                                              54,
                                                                            ),
                                                                    height:
                                                                        converter
                                                                            .h(
                                                                              57,
                                                                            ),
                                                                    fit:
                                                                        BoxFit
                                                                            .contain,
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        } else {
                                                          return SizedBox(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .prepare,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  AnimatedPositionedDirectional(
                                                    duration:
                                                        defaultAnimationDuration,
                                                    curve:
                                                        defaultAnimationCurve,
                                                    end:
                                                        state.status ==
                                                                SocketUnlockModalStatus
                                                                    .prepare
                                                            ? converter.w(89)
                                                            : converter.hcx(54),
                                                    bottom: converter.h(7),
                                                    width: converter.w(54),
                                                    height: converter.h(57),
                                                    child: KpctSwitcher(
                                                      builder: () {
                                                        if (state.status ==
                                                            SocketUnlockModalStatus
                                                                .unlocking) {
                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .unlocking,
                                                            ),
                                                            onPressed: null,
                                                            child: Assets
                                                                .component
                                                                .closeCircleButtonDisabled
                                                                .image(
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            54,
                                                                          ),
                                                                  height:
                                                                      converter
                                                                          .h(
                                                                            57,
                                                                          ),
                                                                  fit:
                                                                      BoxFit
                                                                          .contain,
                                                                ),
                                                          );
                                                        } else {
                                                          return KpctCupertinoButton.solid(
                                                            key: ValueKey<bool>(
                                                              state.status ==
                                                                  SocketUnlockModalStatus
                                                                      .unlocking,
                                                            ),
                                                            onPressed:
                                                                () =>
                                                                    Navigator.pop(
                                                                      context,
                                                                    ),
                                                            child: Assets
                                                                .component
                                                                .closeCircleButtonEnabled
                                                                .image(
                                                                  width:
                                                                      converter
                                                                          .w(
                                                                            54,
                                                                          ),
                                                                  height:
                                                                      converter
                                                                          .h(
                                                                            57,
                                                                          ),
                                                                  fit:
                                                                      BoxFit
                                                                          .contain,
                                                                ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                    );
                                  } else {
                                    return CustomCircularProgressIndicator(
                                      key: ValueKey<bool>(state.initialized),
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
}
