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

          try {
            final error = await App.instance.auth.signInWithGoogle();
            if (error == null) {
              App.instance.log.i("Google Sign-In Success");
            } else {
              App.instance.log.w("Google Sign-In Error: $error");
              App.instance.overlay.cover(on: false, message: error);
            }
          } catch (e, stack) {
            App.instance.log.e(
              "Google Sign-In Exception: $e",
              error: e,
              stackTrace: stack,
            );
            App.instance.overlay.cover(on: false, message: "로그인 중 오류가 발생했습니다.");
          }
        },
        signInWithApple: (event) async {
          App.instance.overlay.cover(on: true);

          try {
            final error = await App.instance.auth.signInWithApple();
            if (error == null) {
              App.instance.log.i("Apple Sign-In Success");
            } else {
              App.instance.log.w("Apple Sign-In Error: $error");
              App.instance.overlay.cover(on: false, message: error);
            }
          } catch (e, stack) {
            App.instance.log.e(
              "Apple Sign-In Exception: $e",
              error: e,
              stackTrace: stack,
            );
            App.instance.overlay.cover(on: false, message: "로그인 중 오류가 발생했습니다.");
          }
        },
      );
    });
  }
}
