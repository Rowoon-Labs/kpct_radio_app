import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/recipe.dart';
import 'package:kpct_radio_app/model/transaction_response.dart';
import 'package:kpct_radio_app/route/home/modal/half/workbench/workbench_modal_misc.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'workbench_modal_event.dart';
part 'workbench_modal_state.dart';
part 'workbench_modal_bloc.freezed.dart';

class WorkbenchModalBloc
    extends Bloc<WorkbenchModalEvent, WorkbenchModalState> {
  final List<Stuff> stuffs;
  final Recipe recipe;
  final Gear gear;

  StreamSubscription<List<Equipment>>? _equipmentsSubscription;

  Timer? _timer;

  WorkbenchModalBloc({
    required this.stuffs,
    required this.recipe,
    required this.gear,
  }) : super(WorkbenchModalState(stuffs: stuffs)) {
    on<WorkbenchModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          _timer = Timer.periodic(
            const Duration(milliseconds: tickDuration),
            (timer) => add(const WorkbenchModalEvent.onTick()),
          );

          _equipmentsSubscription = App.instance.auth.equipmentsChanges.listen(
            (event) =>
                add(WorkbenchModalEvent.onEquipmentsChanges(equipments: event)),
          );
        },
        craftPressed: (event) async {
          if (state.status == WorkbenchModalStatus.prepare) {
            emit(
              state.copyWith(
                status: WorkbenchModalStatus.crafting,
                elapsedDuration: 0,
              ),
            );

            final Equipment equipment = App.instance.factory.generateEquipment(
              gearId: gear.id,
            );
            final DocumentReference<CustomUser> userReference =
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(App.instance.auth.customUser?.id)
                    .withConverter(
                      fromFirestore: CustomUser.fromFirstore,
                      toFirestore: CustomUser.toFirestore,
                    );
            final List<DocumentReference<Equipment>> equipmentReferences =
                List.of(
                  event.equipmentIds.map(
                    (element) => FirebaseFirestore.instance
                        .collection("users")
                        .doc(App.instance.auth.customUser?.id)
                        .collection("equipments")
                        .doc(element)
                        .withConverter(
                          fromFirestore: Equipment.fromFirstore,
                          toFirestore: Equipment.toFirestore,
                        ),
                  ),
                );

            final TransactionResponse<void>
            response = await FirebaseFirestore.instance.runTransaction<
              TransactionResponse<void>
            >((transaction) async {
              final DocumentSnapshot<CustomUser> userSnapshot =
                  await transaction.get<CustomUser>(userReference);
              final List<DocumentSnapshot<Equipment>> equipmentSnapshots =
                  List.empty(growable: true);
              for (DocumentReference<Equipment> equipmentReference
                  in equipmentReferences) {
                equipmentSnapshots.add(await equipmentReference.get());
              }

              final CustomUser? user =
                  userSnapshot.exists ? userSnapshot.data() : null;
              final List<Equipment?> equipments = List.empty(growable: true);
              for (DocumentSnapshot<Equipment> equipmentSnapshot
                  in equipmentSnapshots) {
                equipments.add(
                  equipmentSnapshot.exists ? equipmentSnapshot.data() : null,
                );
              }

              if ((user != null) &&
                  (equipments.firstWhereOrNull(
                        (element) => (element == null),
                      ) ==
                      null)) {
                if (user.radioSsp < recipe.costSsp) {
                  return TransactionResponse<void>.fail(error: "SSP가 부족 합니다");
                } else if (user.ep < recipe.costEp) {
                  return TransactionResponse<void>.fail(error: "EP가 부족 합니다");
                } else if (equipments.firstWhereOrNull(
                      (element) => (element?.mounted == true),
                    ) !=
                    null) {
                  return TransactionResponse<void>.fail(error: "장착중인 장비가 있습니다");
                } else {
                  transaction.update(userReference, {
                    "radioSsp": (user.radioSsp - recipe.costSsp).clamp2(),
                    "ep": (user.ep - recipe.costEp).clamp2(),
                  });

                  if (user.inAdjustedLuckRange(
                    App.instance.reserved.global.luck,
                    recipe.probability,
                  )) {
                    equipmentReferences.forEachIndexed(
                      (index, element) => transaction.delete(element),
                    );

                    transaction.set(
                      userReference.collection("equipments").doc(),
                      {...equipment.toJson()..remove("id")},
                    );

                    return TransactionResponse<void>.success();
                  } else {
                    return TransactionResponse<void>.fail(error: "제작 실패");
                  }
                }
              } else {
                return TransactionResponse<void>.fail(
                  error: "유저 정보를 가져올 수 없습니다",
                );
              }
            });

            if (response.error == null) {
              emit(state.copyWith(result: ""));
            } else {
              emit(state.copyWith(result: response.error));
            }
          }
        },
        onTick: (event) {
          switch (state.status) {
            case WorkbenchModalStatus.crafting:
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
                  emit(state.copyWith(status: WorkbenchModalStatus.success));
                } else {
                  // fail
                  emit(
                    state.copyWith(
                      status: WorkbenchModalStatus.fail,
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
        onEquipmentsChanges: (event) {
          final List<Stuff> stuffs = List.empty(growable: true);
          final List<Equipment> equipments = List.of(event.equipments);

          for (Stuff stuff in state.stuffs) {
            final int index = equipments.indexWhere(
              (element) => (element.gearId == stuff.gear.id),
            );

            if (index == -1) {
              stuffs.add(stuff.copyWith());
            } else {
              stuffs.add(stuff.copyWith(equipment: equipments.removeAt(index)));
            }
          }

          emit(state.copyWith(initialized: true, stuffs: List.of(stuffs)));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _equipmentsSubscription?.cancel();
    return super.close();
  }
}
