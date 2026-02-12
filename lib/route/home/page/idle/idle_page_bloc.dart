import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'idle_page_event.dart';
part 'idle_page_state.dart';
part 'idle_page_bloc.freezed.dart';

class IdlePageBloc extends Bloc<IdlePageEvent, IdlePageState> {
  IdlePageBloc() : super(const IdlePageState()) {
    on<_initialize>((event, emit) {});
  }
}
