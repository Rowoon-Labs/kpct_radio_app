// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnlockImpl _$$UnlockImplFromJson(Map<String, dynamic> json) => _$UnlockImpl(
  id: json['id'] as String,
  tier: const StringToGearTierConverter().fromJson(json['tier']),
  s1costEp: const StringToIntConverter().fromJson(json['s1cost_EP']),
  s2costEp: const StringToIntConverter().fromJson(json['s2cost_EP']),
  s3costEp: const StringToIntConverter().fromJson(json['s3cost_EP']),
  s4costEp: const StringToIntConverter().fromJson(json['s4cost_EP']),
  s5costEp: const StringToIntConverter().fromJson(json['s5cost_EP']),
  s1costSsp: const StringToIntConverter().fromJson(json['s1cost_SSP']),
  s2costSsp: const StringToIntConverter().fromJson(json['s2cost_SSP']),
  s3costSsp: const StringToIntConverter().fromJson(json['s3cost_SSP']),
  s4costSsp: const StringToIntConverter().fromJson(json['s4cost_SSP']),
  s5costSsp: const StringToIntConverter().fromJson(json['s5cost_SSP']),
  s1Probability: const StringToIntConverter().fromJson(json['s1_Probability']),
  s2Probability: const StringToIntConverter().fromJson(json['s2_Probability']),
  s3Probability: const StringToIntConverter().fromJson(json['s3_Probability']),
  s4Probability: const StringToIntConverter().fromJson(json['s4_Probability']),
  s5Probability: const StringToIntConverter().fromJson(json['s5_Probability']),
);

Map<String, dynamic> _$$UnlockImplToJson(
  _$UnlockImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'tier': const StringToGearTierConverter().toJson(instance.tier),
  's1cost_EP': const StringToIntConverter().toJson(instance.s1costEp),
  's2cost_EP': const StringToIntConverter().toJson(instance.s2costEp),
  's3cost_EP': const StringToIntConverter().toJson(instance.s3costEp),
  's4cost_EP': const StringToIntConverter().toJson(instance.s4costEp),
  's5cost_EP': const StringToIntConverter().toJson(instance.s5costEp),
  's1cost_SSP': const StringToIntConverter().toJson(instance.s1costSsp),
  's2cost_SSP': const StringToIntConverter().toJson(instance.s2costSsp),
  's3cost_SSP': const StringToIntConverter().toJson(instance.s3costSsp),
  's4cost_SSP': const StringToIntConverter().toJson(instance.s4costSsp),
  's5cost_SSP': const StringToIntConverter().toJson(instance.s5costSsp),
  's1_Probability': const StringToIntConverter().toJson(instance.s1Probability),
  's2_Probability': const StringToIntConverter().toJson(instance.s2Probability),
  's3_Probability': const StringToIntConverter().toJson(instance.s3Probability),
  's4_Probability': const StringToIntConverter().toJson(instance.s4Probability),
  's5_Probability': const StringToIntConverter().toJson(instance.s5Probability),
};
