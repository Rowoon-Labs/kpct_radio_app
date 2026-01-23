import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

part 'crafting_page_event.dart';
part 'crafting_page_state.dart';
part 'crafting_page_bloc.freezed.dart';

class CraftingPageBloc extends Bloc<CraftingPageEvent, CraftingPageState> {
  StreamSubscription<List<Kit>>? _kitsSubscription;

  CraftingPageBloc() : super(const CraftingPageState()) {
    on<CraftingPageEvent>((event, emit) async {
      await event.map(
        initialize: (event) {
          _kitsSubscription = App.instance.auth.kitsChanges.listen(
            (event) => add(CraftingPageEvent.onKitsChanges(kits: event)),
          );
        },
        tabPressed: (event) async {
          if (state.selectedGearCategory != event.gearCategory) {
            emit(state.copyWith(selectedGearCategory: event.gearCategory));
          }
        },
        elementPressed: (event) async {
          if (state.selectedKit?.id != event.kit.id) {
            emit(state.copyWith(selectedKit: event.kit));
          }
        },
        craftPressed: (event) async {},
        onKitsChanges: (event) {
          final List<Kit> kits = List.of(event.kits);

          emit(
            state.copyWith(
              kits: kits,
              selectedKit:
                  (state.selectedKit != null)
                      ? kits.firstWhereOrNull(
                        (element) => (state.selectedKit?.id == element.id),
                      )
                      : null,
            ),
          );
        },
      );
    });
  }
  @override
  Future<void> close() {
    _kitsSubscription?.cancel();
    return super.close();
  }
}
