import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/transaction_response.dart';
import 'package:kpct_radio_app/model/unlock.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'transfer_ssp_modal_event.dart';
part 'transfer_ssp_modal_state.dart';
part 'transfer_ssp_modal_bloc.freezed.dart';

class TransferSspModalBloc
    extends Bloc<TransferSspModalEvent, TransferSspModalState> {
  Timer? _timer;
  final int ssp;

  TransferSspModalBloc({required this.ssp})
    : super(const TransferSspModalState()) {
    on<TransferSspModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const TransferSspModalEvent.onTick()),
          );
        },
        onTick: (event) {
          switch (state.status) {
            case TransferSspModalStatus.processing:
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
                  emit(state.copyWith(status: TransferSspModalStatus.success));
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: TransferSspModalStatus.fail,
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
        action: (event) async {
          if (state.status == TransferSspModalStatus.prepare) {
            emit(
              state.copyWith(
                status: TransferSspModalStatus.processing,
                elapsedDuration: 0,
              ),
            );

            await FirebaseFunctions.instanceFor(region: "asia-northeast3")
                .httpsCallable("transferSsp")
                .call({
                  "email": App.instance.auth.customUser?.email,
                  "amount": ssp,
                })
                .then((value) {
                  try {
                    emit(state.copyWith(result: value.data["message"]));
                  } catch (exception) {
                    App.instance.log.d(exception);
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
