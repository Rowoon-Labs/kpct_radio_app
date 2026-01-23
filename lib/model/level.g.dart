// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelImpl _$$LevelImplFromJson(Map<String, dynamic> json) => _$LevelImpl(
      id: json['id'] as String,
      condition1: const HourConverterFromString().fromJson(json['Condition1']),
      condition2: const StringToIntConverter().fromJson(json['Condition2']),
      limitSsp: const StringToIntConverter().fromJson(json['Limit_SSP']),
      rewardSsp: const StringToIntConverter().fromJson(json['Reward_SSP']),
      stamina: const StringToIntConverter().fromJson(json['stamina']),
      limitEp: const StringToIntConverter().fromJson(json['Limit_EP']),
      costEp: const StringToIntConverter().fromJson(json['Cost_EP']),
      costSsp: const StringToIntConverter().fromJson(json['Cost_SSP']),
      rewardCount: const StringToIntConverter().fromJson(json['Reward_Count']),
      rewardEp: const StringToIntConverter().fromJson(json['Reward_EP']),
      exp: const StringToIntConverter().fromJson(json['exp']),
      level: const StringToIntConverter().fromJson(json['level']),
      limitProbability:
          const StringToIntConverter().fromJson(json['Limit_Probability']),
    );

Map<String, dynamic> _$$LevelImplToJson(_$LevelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Condition1': const HourConverterFromString().toJson(instance.condition1),
      'Condition2': const StringToIntConverter().toJson(instance.condition2),
      'Limit_SSP': const StringToIntConverter().toJson(instance.limitSsp),
      'Reward_SSP': const StringToIntConverter().toJson(instance.rewardSsp),
      'stamina': const StringToIntConverter().toJson(instance.stamina),
      'Limit_EP': const StringToIntConverter().toJson(instance.limitEp),
      'Cost_EP': const StringToIntConverter().toJson(instance.costEp),
      'Cost_SSP': const StringToIntConverter().toJson(instance.costSsp),
      'Reward_Count': const StringToIntConverter().toJson(instance.rewardCount),
      'Reward_EP': const StringToIntConverter().toJson(instance.rewardEp),
      'exp': const StringToIntConverter().toJson(instance.exp),
      'level': const StringToIntConverter().toJson(instance.level),
      'Limit_Probability':
          const StringToIntConverter().toJson(instance.limitProbability),
    };
