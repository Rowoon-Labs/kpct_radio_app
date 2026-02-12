import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';

part 'take_ssp_modal_event.dart';
part 'take_ssp_modal_state.dart';
part 'take_ssp_modal_bloc.freezed.dart';

class TakeSspModalBloc extends Bloc<TakeSspModalEvent, TakeSspModalState> {
  Timer? _timer;
  final int hodSsp;

  TakeSspModalBloc({required this.hodSsp})
    : super(TakeSspModalState(amount: hodSsp)) {
    on<TakeSspModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const TakeSspModalEvent.onTick()),
          );
        },
        onTick: (event) {
          switch (state.status) {
            case TakeSspModalStatus.processing:
              if (state.elapsedDuration < maximumElapsedDuration) {
                emit(
                  state.copyWith(
                    elapsedDuration: (state.elapsedDuration + tickDuration),
                  ),
                );
              } else {
                if (state.result == null) {
                  // exceed maximumElapsedDuration, but api call not completed
                } else if (state.result == "") {
                  // success
                  emit(state.copyWith(status: TakeSspModalStatus.success));
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: TakeSspModalStatus.fail,
                      elapsedDuration: 0,
                    ),
                  );
                }
              }
              break;

            default:
              break;
          }
        },
        updateAmount: (event) async {
          emit(state.copyWith(amount: event.value));
        },
        action: (event) async {
          if (state.status == TakeSspModalStatus.prepare) {
            emit(
              state.copyWith(
                status: TakeSspModalStatus.processing,
                elapsedDuration: 0,
              ),
            );

            await FirebaseFunctions.instanceFor(region: "asia-northeast3")
                .httpsCallable("takeSsp")
                .call({
                  "email": App.instance.auth.customUser?.email,
                  "amount": state.amount,
                })
                .then((value) {
                  try {
                    emit(state.copyWith(result: value.data["message"]));
                  } catch (exception) {
                    emit(state.copyWith(result: ''));
                  }
                })
                .catchError((error) {
                  App.instance.log.d(error);
                  emit(state.copyWith(result: error.message));
                });
          }
        },
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
