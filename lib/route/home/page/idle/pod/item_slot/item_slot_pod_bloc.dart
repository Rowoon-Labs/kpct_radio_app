import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_slot_pod_event.dart';
part 'item_slot_pod_state.dart';
part 'item_slot_pod_bloc.freezed.dart';

class ItemSlotPodBloc extends Bloc<ItemSlotPodEvent, ItemSlotPodState> {
  ItemSlotPodBloc() : super(const ItemSlotPodState()) {
    on<ItemSlotPodEvent>((event, emit) async {
      event.map(
        mock: (event) async {},
      );
    });
  }
}
