import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_pod_event.dart';
part 'user_info_pod_state.dart';
part 'user_info_pod_bloc.freezed.dart';

class UserInfoPodBloc extends Bloc<UserInfoPodEvent, UserInfoPodState> {
  UserInfoPodBloc() : super(const UserInfoPodState()) {
    on<UserInfoPodEvent>((event, emit) async {
      event.map(
        mock: (event) async {},
      );
    });
  }
}
