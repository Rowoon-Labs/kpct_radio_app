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
import 'package:kpct_radio_app/route/home/modal/full/chat/chat_modal_bloc.dart';
import 'package:kpct_radio_app/widget/custom_circular_progress_indicator.dart';

class ChatModal extends StatelessWidget {
  const ChatModal({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ChatModalBloc()..add(const ChatModalEvent.initialize()),
    child: Builder(
      builder:
          (context) => SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black.withOpacity(0.7),
              body: Column(
                children: [
                  const KpctSeparator(
                    designWidth: designWidth,
                    designHeight: 5,
                  ),
                  KpctAspectRatio.padding(
                    designWidth: designWidth,
                    designHeight: 36,
                    designPadding: const EdgeInsets.symmetric(horizontal: 11),
                    builder:
                        (converter) => Stack(
                          children: [
                            Assets.component.chatModalHeader.image(
                              width: converter.realSize.width,
                              height: converter.realSize.height,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder:
                          (context, constraints) => Stack(
                            children: [
                              Center(
                                child: Assets.component.chatModalBridge.image(
                                  width:
                                      constraints.maxWidth *
                                      (353 / designWidth),
                                  height: constraints.maxHeight,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              BlocBuilder<ChatModalBloc, ChatModalState>(
                                buildWhen:
                                    (previous, current) =>
                                        (previous.chats != current.chats),
                                builder:
                                    (context, state) => ListView.separated(
                                      separatorBuilder:
                                          (context, index) =>
                                              const KpctSeparator(
                                                designWidth: designWidth,
                                                designHeight: 14,
                                              ),
                                      keyboardDismissBehavior:
                                          ScrollViewKeyboardDismissBehavior
                                              .onDrag,
                                      controller:
                                          context
                                              .read<ChatModalBloc>()
                                              .scrollController,
                                      itemCount: state.chats.length,
                                      padding: EdgeInsets.zero,
                                      reverse: true,
                                      itemBuilder: (context, index) {
                                        final bool isMyChat =
                                            state.chats[index].uid ==
                                            App.instance.auth.customUser?.id;

                                        final Radius radius = Radius.circular(
                                          KpctConverter.flex(
                                            context: context,
                                            flex: 10,
                                            designWidth: designWidth,
                                          ),
                                        );

                                        return Column(
                                          children: [
                                            KpctAspectRatio.padding(
                                              designWidth: designWidth,
                                              designHeight: 14,
                                              designPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 42.5,
                                                  ),
                                              builder:
                                                  (converter) => Align(
                                                    alignment:
                                                        isMyChat
                                                            ? Alignment
                                                                .centerRight
                                                            : Alignment
                                                                .centerLeft,
                                                    child: Text(
                                                      // state.chats[index].nickName,
                                                      // FGT때는 닉네임을 랜덤값으로 사용함
                                                      "M${state.chats[index].id.substring(19, 20).toUpperCase()}${state.chats[index].id.substring(3, 6).toUpperCase()}${state.chats[index].id.substring(9, 12).toUpperCase()}${state.chats[index].id.substring(15, 18).toUpperCase()}",
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      textAlign:
                                                          isMyChat
                                                              ? TextAlign.end
                                                              : TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            letterSpacing: 0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeightAlias
                                                                    .bold,
                                                            fontSize: converter
                                                                .h(9),
                                                            height: 1,
                                                          ),
                                                    ),
                                                  ),
                                            ),
                                            // Text(
                                            //   state.chats[index].createdAt.toString(),
                                            // ),
                                            const KpctSeparator(
                                              designWidth: designWidth,
                                              designHeight: 2,
                                            ),
                                            FractionallySizedBox(
                                              alignment:
                                                  isMyChat
                                                      ? Alignment.topRight
                                                      : Alignment.topLeft,
                                              widthFactor: (290 / designWidth),
                                              child: Align(
                                                alignment:
                                                    isMyChat
                                                        ? Alignment.topRight
                                                        : Alignment.topLeft,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        isMyChat
                                                            ? const Color(
                                                              0xFF036825,
                                                            )
                                                            : const Color(
                                                              0xFF272727,
                                                            ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                              isMyChat
                                                                  ? radius
                                                                  : Radius.zero,
                                                          topRight:
                                                              isMyChat
                                                                  ? Radius.zero
                                                                  : radius,
                                                          bottomLeft: radius,
                                                          bottomRight: radius,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          KpctConverter.flex(
                                                            context: context,
                                                            flex: 7.5,
                                                            designWidth:
                                                                designWidth,
                                                          ),
                                                      vertical:
                                                          KpctConverter.flex(
                                                            context: context,
                                                            flex: 6.5,
                                                            designWidth:
                                                                designWidth,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      state
                                                          .chats[index]
                                                          .content,
                                                      textAlign:
                                                          isMyChat
                                                              ? TextAlign.end
                                                              : TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: GoogleFonts.montserrat(
                                                        letterSpacing: 0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeightAlias
                                                                .medium,
                                                        fontSize:
                                                            KpctConverter.flex(
                                                              context: context,
                                                              flex: 14,
                                                              designWidth:
                                                                  designWidth,
                                                            ),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: KpctAspectRatio(
                                  designWidth: designWidth,
                                  designHeight: 32,
                                  builder:
                                      (converter) => BlocBuilder<
                                        ChatModalBloc,
                                        ChatModalState
                                      >(
                                        buildWhen:
                                            (previous, current) =>
                                                (previous.loading !=
                                                    current.loading),
                                        builder:
                                            (context, state) => KpctSwitcher(
                                              builder: () {
                                                if (state.loading) {
                                                  return CustomCircularProgressIndicator(
                                                    key: ValueKey<bool>(
                                                      state.loading,
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox(
                                                    key: ValueKey<bool>(
                                                      state.loading,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: KpctAspectRatio.padding(
                  designWidth: designWidth,
                  designHeight: 138,
                  designPadding: const EdgeInsets.symmetric(horizontal: 11),
                  builder:
                      (converter) => Stack(
                        children: [
                          Assets.component.chatModalFooter.image(
                            width: converter.realSize.width,
                            height: converter.realSize.height,
                            fit: BoxFit.contain,
                          ),
                          PositionedDirectional(
                            bottom: converter.h(87),
                            start: converter.w(22),
                            end: converter.w(18),
                            height: converter.h(28),
                            child: Center(
                              child: BlocBuilder<ChatModalBloc, ChatModalState>(
                                buildWhen:
                                    (previous, current) =>
                                        (previous.input != current.input),
                                builder:
                                    (context, state) => TextField(
                                      maxLines: 1,
                                      focusNode:
                                          context
                                              .read<ChatModalBloc>()
                                              .focusNode,
                                      controller:
                                          context
                                              .read<ChatModalBloc>()
                                              .textEditingController,
                                      onChanged:
                                          (value) =>
                                              context.read<ChatModalBloc>().add(
                                                ChatModalEvent.onChanged(
                                                  value: value,
                                                ),
                                              ),
                                      onEditingComplete: () {},
                                      onSubmitted: (value) {
                                        if (state.input.isNotEmpty) {
                                          context.read<ChatModalBloc>().add(
                                            const ChatModalEvent.send(),
                                          );
                                        } else {
                                          context
                                              .read<ChatModalBloc>()
                                              .focusNode
                                              .requestFocus();
                                        }
                                      },
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.send,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: GoogleFonts.inter(
                                        letterSpacing: 0,
                                        color: Colors.white,
                                        // fontStyle: FontStyle.italic,
                                        fontWeight: FontWeightAlias.extraBold,
                                        fontSize: converter.h(10),
                                        height: 1,
                                      ),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          letterSpacing: 0,
                                          color: Colors.white.withOpacity(0.4),
                                          // fontStyle: FontStyle.italic,
                                          fontWeight: FontWeightAlias.extraBold,
                                          fontSize: converter.h(10),
                                          height: 1,
                                        ),
                                        hintText: "입력하는 내용 타자 타자",
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: KpctConverter.flex(
                                            context: context,
                                            flex: 8,
                                            designWidth: designWidth,
                                          ),
                                        ),
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: converter.h(6),
                            start: converter.hcx(54),
                            width: converter.w(54),
                            height: converter.h(57),
                            child: KpctCupertinoButton.solid(
                              onPressed: () => Navigator.pop(context),
                              child: Assets.component.chatModalCloseButton
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
              ),
            ),
          ),
    ),
  );
}
