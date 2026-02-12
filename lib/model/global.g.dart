// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GlobalImpl _$$GlobalImplFromJson(Map<String, dynamic> json) => _$GlobalImpl(
  configuration:
      json['configuration'] == null
          ? const Configuration(
            tickSeconds: defaultGlobalConfigurationTickSeconds,
            syncTickCount: defaultGlobalConfigurationSyncTickCount,
            listeningGaugeGain: defaultGlobalConfigurationListeningGaugeGain,
            epBoxRequirement: defaultGlobalConfigurationEpBoxRequirement,
            sspBoxRequirement: defaultGlobalConfigurationSspBoxRequirement,
            staminaBoxRequirement:
                defaultGlobalConfigurationStaminaBoxRequirement,
            showIdPwLogin: true,
          )
          : Configuration.fromJson(
            json['configuration'] as Map<String, dynamic>,
          ),
  listeningGauge:
      (json['listening_Gauge'] as num?)?.toInt() ?? defaultGlobalListeningGauge,
  staminaChargeDelay:
      json['stamina_charge_delay'] == null
          ? defaultGlobalStaminaChargeDelay
          : const SecondConverter().fromJson(
            (json['stamina_charge_delay'] as num).toInt(),
          ),
  gaugeDecrease:
      (json['gaugeDecrease'] as num?)?.toInt() ?? defaultGlobalGaugeDecrease,
  listeningGetEp:
      (json['listening_GetEP'] as num?)?.toInt() ?? defaultGlobalListeningGetEp,
  staminaChargeRate:
      (json['stamina_charge_rate'] as num?)?.toInt() ??
      defaultGlobalStaminaChargeRate,
  gaugeDecreaseDelay:
      json['gaugeDecrease_delay'] == null
          ? defaultGlobalGaugeDecreaseDelay
          : const SecondConverter().fromJson(
            (json['gaugeDecrease_delay'] as num).toInt(),
          ),
  listeningGetEpProba:
      (json['listening_GetEP_Proba'] as num?)?.toInt() ??
      defaultGlobalListeningGetEpProba,
  staminaUse: (json['stamina_Use'] as num?)?.toInt() ?? defaultGlobalStaminaUse,
  listeningGetSsp:
      (json['listening_GetSSP'] as num?)?.toInt() ??
      defaultGlobalListeningGetSsp,
  expStamina:
      (json['exp_Stamina'] as num?)?.toDouble() ?? defaultGlobalExpStamina,
  luck: (json['luck'] as num?)?.toInt() ?? defaultGlobalLuck,
);

Map<String, dynamic> _$$GlobalImplToJson(_$GlobalImpl instance) =>
    <String, dynamic>{
      'configuration': instance.configuration,
      'listening_Gauge': instance.listeningGauge,
      'stamina_charge_delay': const SecondConverter().toJson(
        instance.staminaChargeDelay,
      ),
      'gaugeDecrease': instance.gaugeDecrease,
      'listening_GetEP': instance.listeningGetEp,
      'stamina_charge_rate': instance.staminaChargeRate,
      'gaugeDecrease_delay': const SecondConverter().toJson(
        instance.gaugeDecreaseDelay,
      ),
      'listening_GetEP_Proba': instance.listeningGetEpProba,
      'stamina_Use': instance.staminaUse,
      'listening_GetSSP': instance.listeningGetSsp,
      'exp_Stamina': instance.expStamina,
      'luck': instance.luck,
    };

_$ConfigurationImpl _$$ConfigurationImplFromJson(Map<String, dynamic> json) =>
    _$ConfigurationImpl(
      tickSeconds:
          json['tickSeconds'] == null
              ? defaultGlobalConfigurationTickSeconds
              : const SecondConverter().fromJson(
                (json['tickSeconds'] as num).toInt(),
              ),
      syncTickCount:
          (json['syncTickCount'] as num?)?.toInt() ??
          defaultGlobalConfigurationSyncTickCount,
      listeningGaugeGain:
          (json['listeningGaugeGain'] as num?)?.toInt() ??
          defaultGlobalConfigurationListeningGaugeGain,
      staminaBoxRequirement:
          (json['staminaBoxRequirement'] as num?)?.toInt() ??
          defaultGlobalConfigurationStaminaBoxRequirement,
      sspBoxRequirement:
          (json['sspBoxRequirement'] as num?)?.toInt() ??
          defaultGlobalConfigurationSspBoxRequirement,
      epBoxRequirement:
          (json['epBoxRequirement'] as num?)?.toInt() ??
          defaultGlobalConfigurationEpBoxRequirement,
      showIdPwLogin: json['showIdPwLogin'] as bool? ?? true,
    );

Map<String, dynamic> _$$ConfigurationImplToJson(_$ConfigurationImpl instance) =>
    <String, dynamic>{
      'tickSeconds': const SecondConverter().toJson(instance.tickSeconds),
      'syncTickCount': instance.syncTickCount,
      'listeningGaugeGain': instance.listeningGaugeGain,
      'staminaBoxRequirement': instance.staminaBoxRequirement,
      'sspBoxRequirement': instance.sspBoxRequirement,
      'epBoxRequirement': instance.epBoxRequirement,
      'showIdPwLogin': instance.showIdPwLogin,
    };
