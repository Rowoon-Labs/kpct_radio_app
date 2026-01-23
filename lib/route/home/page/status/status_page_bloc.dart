import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';

part 'status_page_event.dart';
part 'status_page_state.dart';
part 'status_page_bloc.freezed.dart';

class StatusPageBloc extends Bloc<StatusPageEvent, StatusPageState> {
  StatusPageBloc() : super(const StatusPageState()) {
    on<StatusPageEvent>((event, emit) async {
      await event.map(
        tryTakeSsp: (event) async {
          if (!state.tryingTakeSsp) {
            emit(state.copyWith(tryingTakeSsp: true));

            await FirebaseFunctions.instanceFor(region: "asia-northeast3")
                .httpsCallable("getHodSsp")
                .call({"email": App.instance.auth.customUser?.email})
                .then((value) {
                  if ((value.data != null) &&
                      (value.data is int) &&
                      (value.data > 0)) {
                    event.completer.complete(value.data);
                  } else {
                    event.completer.complete(null);
                  }
                })
                .catchError((error) {
                  event.completer.complete(null);
                })
                .whenComplete(() => emit(state.copyWith(tryingTakeSsp: false)));
          }
        },
      );
    });
  }
}
