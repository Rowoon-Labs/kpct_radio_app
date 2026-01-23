// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decomposition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DecompositionImpl _$$DecompositionImplFromJson(Map<String, dynamic> json) =>
    _$DecompositionImpl(
      id: json['id'] as String,
      gearId: json['gear_ID'] as String,
      costEp: const StringToIntConverter().fromJson(json['cost_EP']),
      costSsp: const StringToIntConverter().fromJson(json['cost_SSP']),
      resultMax: const StringToIntConverter().fromJson(json['result_max']),
      resultMin: const StringToIntConverter().fromJson(json['result_min']),
      result1: json['result1'] as String?,
      result2: json['result2'] as String?,
      result3: json['result3'] as String?,
      result4: json['result4'] as String?,
      result5: json['result5'] as String?,
      result6: json['result6'] as String?,
      result7: json['result7'] as String?,
      result8: json['result8'] as String?,
    );

Map<String, dynamic> _$$DecompositionImplToJson(_$DecompositionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gear_ID': instance.gearId,
      'cost_EP': const StringToIntConverter().toJson(instance.costEp),
      'cost_SSP': const StringToIntConverter().toJson(instance.costSsp),
      'result_max': const StringToIntConverter().toJson(instance.resultMax),
      'result_min': const StringToIntConverter().toJson(instance.resultMin),
      'result1': instance.result1,
      'result2': instance.result2,
      'result3': instance.result3,
      'result4': instance.result4,
      'result5': instance.result5,
      'result6': instance.result6,
      'result7': instance.result7,
      'result8': instance.result8,
    };
