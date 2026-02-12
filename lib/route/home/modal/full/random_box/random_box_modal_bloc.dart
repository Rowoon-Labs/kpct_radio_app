import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/model/chat.dart';
import 'package:kpct_radio_app/route/home/modal/full/chat/chat_modal_misc.dart';

part 'random_box_modal_event.dart';
part 'random_box_modal_state.dart';
part 'random_box_modal_bloc.freezed.dart';

class RandomBoxModalBloc
    extends Bloc<RandomBoxModalEvent, RandomBoxModalState> {
  RandomBoxModalBloc() : super(const RandomBoxModalState()) {
    on<RandomBoxModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          emit(state.copyWith(initialized: true));
        },
      );
    });
  }
}
