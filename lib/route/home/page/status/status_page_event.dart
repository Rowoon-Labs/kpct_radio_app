part of 'status_page_bloc.dart';

@freezed
class StatusPageEvent with _$StatusPageEvent {
  const factory StatusPageEvent.tryTakeSsp({
    required Completer<int?> completer,
  }) = _tryTakeSsp;
}
