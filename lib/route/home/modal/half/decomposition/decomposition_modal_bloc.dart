import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/decomposition.dart';
import 'package:kpct_radio_app/model/transaction_response.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'decomposition_modal_event.dart';
part 'decomposition_modal_state.dart';
part 'decomposition_modal_bloc.freezed.dart';

class DecompositionModalBloc
    extends Bloc<DecompositionModalEvent, DecompositionModalState> {
  Timer? _timer;
  final Decomposition decomposition;
  final Pack pack;

  DecompositionModalBloc({required this.decomposition, required this.pack})
    : super(const DecompositionModalState()) {
    on<DecompositionModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const DecompositionModalEvent.onTick()),
          );

          emit(state.copyWith(initialized: true));
        },
        decompositionPressed: (event) async {
          if (state.status == DecompositionModalStatus.prepare) {
            emit(
              state.copyWith(
                status: DecompositionModalStatus.decomposing,
                elapsedDuration: 0,
              ),
            );

            final DocumentReference<CustomUser> userReference =
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(App.instance.auth.customUser?.id)
                    .withConverter(
                      fromFirestore: CustomUser.fromFirstore,
                      toFirestore: CustomUser.toFirestore,
                    );
            final DocumentReference<Equipment> equipmentReference =
                userReference
                    .collection("equipments")
                    .doc(pack.id)
                    .withConverter(
                      fromFirestore: Equipment.fromFirstore,
                      toFirestore: Equipment.toFirestore,
                    );

            final TransactionResponse<List<String>> response =
                await FirebaseFirestore.instance
                    .runTransaction<TransactionResponse<List<String>>>((
                      transaction,
                    ) async {
                      final DocumentSnapshot<CustomUser> userSnapshot =
                          await transaction.get<CustomUser>(userReference);
                      final DocumentSnapshot<Equipment> equipmentSnapshot =
                          await transaction.get<Equipment>(equipmentReference);

                      final CustomUser? user =
                          userSnapshot.exists ? userSnapshot.data() : null;
                      final Equipment? equipment =
                          equipmentSnapshot.exists
                              ? equipmentSnapshot.data()
                              : null;

                      if ((user != null) && (equipment != null)) {
                        if (equipment.mounted) {
                          return TransactionResponse<List<String>>.fail(
                            error: "장착중인 장비입니다",
                          );
                        } else if (user.radioSsp < decomposition.costSsp) {
                          return TransactionResponse<List<String>>.fail(
                            error: "SSP가 부족합니다",
                          );
                        } else if (user.ep < decomposition.costEp) {
                          return TransactionResponse<List<String>>.fail(
                            error: "EP가 부족합니다",
                          );
                        } else {
                          transaction.update(userReference, {
                            "radioSsp":
                                (user.radioSsp - decomposition.costSsp)
                                    .clamp2(),
                            "ep": (user.ep - decomposition.costEp).clamp2(),
                          });

                          final List<Equipment> equipments = App
                              .instance
                              .factory
                              .generateDecomposedEquipments(
                                decomposition: decomposition,
                              );

                          for (Equipment equipment in equipments) {
                            transaction.set(
                              userReference.collection("equipments").doc(),
                              {...equipment.toJson()..remove("id")},
                            );
                          }

                          transaction.delete(equipmentReference);

                          return TransactionResponse<List<String>>.success(
                            data: equipments.map((e) => e.gearId).toList(),
                          );
                        }
                      } else {
                        return TransactionResponse<List<String>>.fail(
                          error: "유저 정보를 가져올 수 없습니다",
                        );
                      }
                    })
                    .catchError((error) {
                      return TransactionResponse<List<String>>.fail(
                        error: "소켓 언락 실패",
                      );
                    });

            App.instance.log.d(response.error);

            if (response.error == null) {
              emit(state.copyWith(result: "", results: response.data ?? []));
            } else {
              emit(state.copyWith(result: response.error));
            }
          }
        },
        onTick: (event) {
          switch (state.status) {
            case DecompositionModalStatus.decomposing:
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
                  emit(
                    state.copyWith(status: DecompositionModalStatus.success),
                  );
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: DecompositionModalStatus.fail,
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
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
