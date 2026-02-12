// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncImpl _$$SyncImplFromJson(Map<String, dynamic> json) => _$SyncImpl(
  tick: (json['tick'] as num?)?.toInt() ?? 0,
  gainedExp: (json['gainedExp'] as num?)?.toDouble() ?? 0,
  consumedStamina: (json['consumedStamina'] as num?)?.toInt() ?? 0,
  gainedListeningGauge: (json['gainedListeningGauge'] as num?)?.toInt() ?? 0,
  elapsedPlayDuration:
      json['elapsedPlayDuration'] == null
          ? Duration.zero
          : Duration(
            microseconds: (json['elapsedPlayDuration'] as num).toInt(),
          ),
);

Map<String, dynamic> _$$SyncImplToJson(_$SyncImpl instance) =>
    <String, dynamic>{
      'tick': instance.tick,
      'gainedExp': instance.gainedExp,
      'consumedStamina': instance.consumedStamina,
      'gainedListeningGauge': instance.gainedListeningGauge,
      'elapsedPlayDuration': instance.elapsedPlayDuration.inMicroseconds,
    };
