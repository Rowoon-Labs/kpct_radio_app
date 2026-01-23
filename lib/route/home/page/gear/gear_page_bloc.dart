import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'gear_page_event.dart';
part 'gear_page_state.dart';
part 'gear_page_bloc.freezed.dart';

class GearPageBloc extends Bloc<GearPageEvent, GearPageState> {
  StreamSubscription<List<Pack>>? _packsSubscription;

  GearPageBloc() : super(const GearPageState()) {
    on<GearPageEvent>((event, emit) async {
      await event.map(
        initialize: (event) {
          _packsSubscription = App.instance.auth.packsChanges.listen(
            (event) => add(GearPageEvent.onPacksChanges(packs: event)),
          );
        },
        tabPressed: (event) async {
          if (state.selectedSocketIndex == null) {
            if (state.selectedGearCategory != event.gearCategory) {
              emit(state.copyWith(selectedGearCategory: event.gearCategory));
            }
          }
        },
        elementPressed: (event) async {
          if (state.selectedPack?.id != event.pack.id) {
            if (state.selectedSocketIndex != null) {
              emit(state.copyWith(selectedGemPack: event.pack));
            } else {
              emit(state.copyWith(selectedPack: event.pack));
            }
          }
        },
        gemPressed: (event) async {
          if (state.selectedPack?.id != event.pack.id) {
            emit(state.copyWith(selectedPack: event.pack));
          }
        },
        onPacksChanges: (event) {
          final List<Pack> packs = List.of(event.packs);

          final Pack? selectedPack =
              (state.selectedPack != null)
                  ? packs.firstWhereOrNull(
                    (element) => (state.selectedPack?.id == element.id),
                  )
                  : null;

          final int? selectedSocketIndex;
          if (selectedPack != null) {
            if (state.selectedSocketIndex != null) {
              if (!selectedPack.stackable &&
                  (state.selectedSocketIndex! <
                      selectedPack.equipments.first.sockets.length) &&
                  (selectedPack.equipments.first.sockets[state
                          .selectedSocketIndex!] !=
                      null)) {
                selectedSocketIndex = state.selectedSocketIndex;
              } else {
                selectedSocketIndex = null;
              }
            } else {
              selectedSocketIndex = null;
            }
          } else {
            selectedSocketIndex = null;
          }

          emit(
            state.copyWith(
              packs: packs,
              selectedPack: selectedPack,
              selectedSocketIndex: selectedSocketIndex,
            ),
          );
        },
        socketPressed: (event) {
          if (state.selectedSocketIndex == null) {
            emit(
              state.copyWith(
                selectedGearCategory: GearCategory.gem,
                selectedSocketIndex: event.index,
              ),
            );
          }
        },
        releaseSocket: (event) {
          emit(
            state.copyWith(selectedSocketIndex: null, selectedGemPack: null),
          );
        },
        install: (event) async {
          App.instance.overlay.cover(on: true);

          final DocumentReference<CustomUser> userReference = FirebaseFirestore
              .instance
              .collection("users")
              .doc(App.instance.auth.customUser?.id)
              .withConverter(
                fromFirestore: CustomUser.fromFirstore,
                toFirestore: CustomUser.toFirestore,
              );
          final DocumentReference<Equipment> equipmentReference =
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(App.instance.auth.customUser?.id)
                  .collection("equipments")
                  .doc(event.equipmentId)
                  .withConverter(
                    fromFirestore: Equipment.fromFirstore,
                    toFirestore: Equipment.toFirestore,
                  );

          final bool success = await FirebaseFirestore.instance
              .runTransaction<bool>((transaction) async {
                final DocumentSnapshot<CustomUser> userSnapshot =
                    await transaction.get<CustomUser>(userReference);
                final DocumentSnapshot<Equipment> equipmentSnapshot =
                    await transaction.get<Equipment>(equipmentReference);

                final CustomUser? user =
                    userSnapshot.exists ? userSnapshot.data() : null;
                final Equipment? equipment =
                    equipmentSnapshot.exists ? equipmentSnapshot.data() : null;

                if ((user != null) && (equipment != null)) {
                  final Gear? gear = App.instance.reserved.gear(
                    id: equipment.gearId,
                  );

                  if (gear != null) {
                    if (user
                            .installedEquipments[equipment.category]
                            ?.equipmentId !=
                        null) {
                      transaction.update(
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(App.instance.auth.customUser?.id)
                            .collection("equipments")
                            .doc(
                              user
                                  .installedEquipments[equipment.category]
                                  ?.equipmentId,
                            ),
                        {"mounted": false},
                      );
                    }

                    transaction.update(userReference, {
                      "installedEquipments.${equipment.category.query}": {
                        "equipmentId": equipment.id,
                        "sockets": equipment.sockets.map((e) => e.toJson()),
                        ...gear.toJson()..remove("id"),
                      },
                    });

                    transaction.update(equipmentReference, {"mounted": true});
                  }

                  return true;
                } else {
                  return false;
                }
              })
              .whenComplete(() => App.instance.overlay.cover(on: false));
        },
        uninstall: (event) async {
          App.instance.overlay.cover(on: true);

          final DocumentReference<CustomUser> userReference = FirebaseFirestore
              .instance
              .collection("users")
              .doc(App.instance.auth.customUser?.id)
              .withConverter(
                fromFirestore: CustomUser.fromFirstore,
                toFirestore: CustomUser.toFirestore,
              );
          final DocumentReference<Equipment> equipmentReference =
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(App.instance.auth.customUser?.id)
                  .collection("equipments")
                  .doc(event.equipmentId)
                  .withConverter(
                    fromFirestore: Equipment.fromFirstore,
                    toFirestore: Equipment.toFirestore,
                  );

          final bool success = await FirebaseFirestore.instance
              .runTransaction<bool>((transaction) async {
                final DocumentSnapshot<CustomUser> userSnapshot =
                    await transaction.get<CustomUser>(userReference);
                final DocumentSnapshot<Equipment> equipmentSnapshot =
                    await transaction.get<Equipment>(equipmentReference);

                final CustomUser? user =
                    userSnapshot.exists ? userSnapshot.data() : null;
                final Equipment? equipment =
                    equipmentSnapshot.exists ? equipmentSnapshot.data() : null;

                if ((user != null) && (equipment != null)) {
                  transaction.update(equipmentReference, {"mounted": false});

                  transaction.update(userReference, {
                    "installedEquipments.${equipment.category.query}": null,
                  });

                  return true;
                } else {
                  return false;
                }
              })
              .whenComplete(() => App.instance.overlay.cover(on: false));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _packsSubscription?.cancel();
    return super.close();
  }
}
