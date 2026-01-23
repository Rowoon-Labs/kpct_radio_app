import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync.freezed.dart';
part 'sync.g.dart';

@unfreezed
class Sync with _$Sync {
  factory Sync({
    @Default(0) int tick,
    @Default(0) double gainedExp,
    @Default(0) int consumedStamina,
    @Default(0) int gainedListeningGauge,
    @Default(Duration.zero) Duration elapsedPlayDuration,
  }) = _Sync;

  factory Sync.fromJson(Map<String, Object?> json) => _$SyncFromJson(json);

  const Sync._();

  void clear() {
    final Sync sync = Sync();

    tick = sync.tick;
    gainedExp = sync.gainedExp;
    consumedStamina = sync.consumedStamina;
    elapsedPlayDuration = sync.elapsedPlayDuration;
    gainedListeningGauge = sync.gainedListeningGauge;
  }
}
