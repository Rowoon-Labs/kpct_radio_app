import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/model/chat.dart';
import 'package:kpct_radio_app/route/home/modal/full/chat/chat_modal_misc.dart';

part 'chat_modal_event.dart';
part 'chat_modal_state.dart';
part 'chat_modal_bloc.freezed.dart';

class ChatModalBloc extends Bloc<ChatModalEvent, ChatModalState> {
  final FocusNode focusNode;
  final ScrollController scrollController;
  final TextEditingController textEditingController;

  StreamSubscription<QuerySnapshot<Chat>>? _streamSubscription;

  ChatModalBloc()
    : focusNode = FocusNode(),
      scrollController = ScrollController(),
      textEditingController = TextEditingController(),
      super(const ChatModalState()) {
    on<ChatModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          final Completer<void> completer = Completer();

          add(ChatModalEvent.load(completer: completer));

          await Future.wait([completer.future]).then((value) {
            _streamSubscription = FirebaseFirestore.instance
                .collection("chats")
                .orderBy("createdAt", descending: true)
                .orderBy("uid")
                .limit(1)
                .withConverter(
                  fromFirestore: Chat.fromFirstore,
                  toFirestore: Chat.toFirestore,
                )
                .snapshots()
                .listen((event) {
                  if (event.docs.isNotEmpty) {
                    add(ChatModalEvent.receive(value: event.docs.first.data()));
                  }
                });

            scrollController.addListener(() {
              if (scrollController.position.atEdge &&
                  (scrollController.position.pixels > 0)) {
                add(const ChatModalEvent.load());
              }
            });

            emit(state.copyWith(initialized: true));
          });
        },
        load: (event) async {
          if (!state.loading) {
            emit(state.copyWith(loading: true));

            if (state.hasMore) {
              Query query = FirebaseFirestore.instance
                  .collection("chats")
                  .orderBy("createdAt", descending: true)
                  .orderBy("uid")
                  .limit(pageSizeOfChats);

              if (state.chats.isNotEmpty) {
                query = query.startAfter([
                  Timestamp.fromDate(state.chats.last.createdAt),
                  state.chats.last.uid,
                ]);
              }

              await query
                  .withConverter(
                    fromFirestore: Chat.fromFirstore,
                    toFirestore: Chat.toFirestore,
                  )
                  .get()
                  .then((value) {
                    emit(
                      state.copyWith(
                        chats: List.of(state.chats)
                          ..addAll(value.docs.map((element) => element.data())),
                        hasMore: (value.docs.length == pageSizeOfChats),
                      ),
                    );
                  });
            }

            emit(state.copyWith(loading: false));
          }

          event.completer?.complete();
        },
        send: (event) async {
          if (state.input.isNotEmpty &&
              (App.instance.auth.customUser != null)) {
            final String input = state.input;

            textEditingController.clear();
            emit(state.copyWith(input: ""));

            await FirebaseFirestore.instance.collection("chats").add({
              "uid": App.instance.auth.customUser?.id,
              "nickName": App.instance.auth.customUser?.email,
              "content": input,
              "createdAt": FieldValue.serverTimestamp(),
            });
          }
        },
        receive: (event) {
          if (state.chats.indexWhere((chat) => (event.value.id == chat.id)) ==
              -1) {
            emit(
              state.copyWith(
                chats: List.of(state.chats)..insert(0, event.value),
              ),
            );
          }
        },
        onChanged: (event) {
          emit(state.copyWith(input: event.value.trim()));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
