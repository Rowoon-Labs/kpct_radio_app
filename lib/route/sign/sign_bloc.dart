import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';

part 'sign_event.dart';
part 'sign_state.dart';
part 'sign_bloc.freezed.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc() : super(const SignState()) {
    on<SignEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {},
        signInWithGoogle: (event) async {
          App.instance.overlay.cover(on: true);

          await App.instance.auth.signInWithGoogle().then((value) {
            if (value != null) {
              App.instance.overlay.cover(on: false, message: value);
            } else {
              App.instance.log.d(value);
            }
          });
        },
        signInWithApple: (event) async {
          App.instance.overlay.cover(on: true);

          await App.instance.auth.signInWithApple().then((value) {
            if (value != null) {
              App.instance.overlay.cover(on: false, message: value);
            } else {
              App.instance.log.d(value);
            }
          });
        },
      );
    });
  }
}
