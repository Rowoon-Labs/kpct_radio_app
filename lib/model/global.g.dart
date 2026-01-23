// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GlobalImpl _$$GlobalImplFromJson(Map<String, dynamic> json) => _$GlobalImpl(
      configuration:
          Configuration.fromJson(json['configuration'] as Map<String, dynamic>),
      listeningGauge: (json['listening_Gauge'] as num).toInt(),
      staminaChargeDelay: const SecondConverter()
          .fromJson((json['stamina_charge_delay'] as num).toInt()),
      gaugeDecrease: (json['gaugeDecrease'] as num).toInt(),
      listeningGetEp: (json['listening_GetEP'] as num).toInt(),
      staminaChargeRate: (json['stamina_charge_rate'] as num).toInt(),
      gaugeDecreaseDelay: const SecondConverter()
          .fromJson((json['gaugeDecrease_delay'] as num).toInt()),
      listeningGetEpProba: (json['listening_GetEP_Proba'] as num).toInt(),
      staminaUse: (json['stamina_Use'] as num).toInt(),
      listeningGetSsp: (json['listening_GetSSP'] as num).toInt(),
      expStamina: (json['exp_Stamina'] as num).toDouble(),
      luck: (json['luck'] as num).toInt(),
    );

Map<String, dynamic> _$$GlobalImplToJson(_$GlobalImpl instance) =>
    <String, dynamic>{
      'configuration': instance.configuration,
      'listening_Gauge': instance.listeningGauge,
      'stamina_charge_delay':
          const SecondConverter().toJson(instance.staminaChargeDelay),
      'gaugeDecrease': instance.gaugeDecrease,
      'listening_GetEP': instance.listeningGetEp,
      'stamina_charge_rate': instance.staminaChargeRate,
      'gaugeDecrease_delay':
          const SecondConverter().toJson(instance.gaugeDecreaseDelay),
      'listening_GetEP_Proba': instance.listeningGetEpProba,
      'stamina_Use': instance.staminaUse,
      'listening_GetSSP': instance.listeningGetSsp,
      'exp_Stamina': instance.expStamina,
      'luck': instance.luck,
    };

_$ConfigurationImpl _$$ConfigurationImplFromJson(Map<String, dynamic> json) =>
    _$ConfigurationImpl(
      tickSeconds: const SecondConverter()
          .fromJson((json['tickSeconds'] as num).toInt()),
      syncTickCount: (json['syncTickCount'] as num).toInt(),
      listeningGaugeGain: (json['listeningGaugeGain'] as num).toInt(),
      staminaBoxRequirement: (json['staminaBoxRequirement'] as num).toInt(),
      sspBoxRequirement: (json['sspBoxRequirement'] as num).toInt(),
      epBoxRequirement: (json['epBoxRequirement'] as num).toInt(),
    );

Map<String, dynamic> _$$ConfigurationImplToJson(_$ConfigurationImpl instance) =>
    <String, dynamic>{
      'tickSeconds': const SecondConverter().toJson(instance.tickSeconds),
      'syncTickCount': instance.syncTickCount,
      'listeningGaugeGain': instance.listeningGaugeGain,
      'staminaBoxRequirement': instance.staminaBoxRequirement,
      'sspBoxRequirement': instance.sspBoxRequirement,
      'epBoxRequirement': instance.epBoxRequirement,
    };
