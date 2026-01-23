import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
          emit(state.copyWith(
            initialized: true,
          ));
        },
      );
    });
  }
}
