import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_navigation_rail_event.dart';
part 'bottom_navigation_rail_state.dart';
part 'bottom_navigation_rail_bloc.freezed.dart';

class BottomNavigationRailBloc
    extends Bloc<BottomNavigationRailEvent, BottomNavigationRailState> {
  BottomNavigationRailBloc() : super(const BottomNavigationRailState()) {
    on<BottomNavigationRailEvent>((event, emit) async {
      event.map(
        mock: (event) async {},
      );
    });
  }
}
