part of 'workbench_modal_bloc.dart';

enum WorkbenchModalStatus {
  prepare,
  crafting,
  success,
  fail,
}

extension WorkbenchModalStatusExtension on WorkbenchModalStatus {
  String get title {
    switch (this) {
      case WorkbenchModalStatus.prepare:
        return "제작";

      case WorkbenchModalStatus.crafting:
        return "제작중";

      case WorkbenchModalStatus.success:
        return "제작성공!";

      case WorkbenchModalStatus.fail:
        return "제작실패!";
    }
  }
}

@freezed
class WorkbenchModalState with _$WorkbenchModalState {
  const factory WorkbenchModalState({
    @Default(false) bool initialized,
    @Default(0) int elapsedDuration,
    @Default([]) List<Stuff> stuffs,
    @Default(WorkbenchModalStatus.prepare) WorkbenchModalStatus status,
    @Default(null) String? result,
  }) = _WorkbenchModalState;
}
