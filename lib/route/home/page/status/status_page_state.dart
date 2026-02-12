part of 'status_page_bloc.dart';

@freezed
class StatusPageState with _$StatusPageState {
  const factory StatusPageState({
    @Default(false) bool tryingTakeSsp,
  }) = _StatusPageState;
}
