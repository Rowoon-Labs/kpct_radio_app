import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';

part 'setting_modal_event.dart';
part 'setting_modal_state.dart';
part 'setting_modal_bloc.freezed.dart';

class SettingModalBloc extends Bloc<SettingModalEvent, SettingModalState> {
  final ScrollController scrollController;

  SettingModalBloc()
    : scrollController = ScrollController(),
      super(const SettingModalState()) {
    on<SettingModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          emit(state.copyWith(initialized: true));
        },
        deleteAccountPressed: (event) async {
          final context = App.instance.navigator.key.currentContext;
          if (context == null) return;

          final bool? confirm = await showCupertinoDialog<bool>(
            context: context,
            builder:
                (context) => CupertinoAlertDialog(
                  title: const Text("계정 삭제"),
                  content: const Text(
                    "계정 삭제 시 모든 데이터(프로필, 아이템, 전적 등)가 영구적으로 삭제되며 복구할 수 없습니다. 정말 삭제하시겠습니까?",
                  ),
                  actions: [
                    CupertinoDialogAction(
                      isDestructiveAction: false,
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("취소"),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("삭제"),
                    ),
                  ],
                ),
          );

          if (confirm == true) {
            App.instance.overlay.cover(on: true);

            final error = await App.instance.auth.deleteAccount();

            if (error == null) {
              App.instance.overlay.cover(on: false, message: "계정이 삭제되었습니다.");
            } else if (error == "security-error") {
              App.instance.overlay.cover(
                on: false,
                message: "보안을 위해 최근 로그인 기록이 필요합니다.\n다시 로그인 후 시도해 주세요.",
              );
              await App.instance.auth.signOut();
            } else {
              App.instance.overlay.cover(on: false, message: error);
            }
          }
        },
      );
    });
  }
}
