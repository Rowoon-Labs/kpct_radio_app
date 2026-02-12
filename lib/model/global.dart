import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app_common/models/converter/second_converter.dart';

part 'global.freezed.dart';
part 'global.g.dart';

const int defaultGlobalStaminaUse = 1;
const int defaultGlobalListeningGauge = 10000;
const int defaultGlobalListeningGetSsp = 100;
const int defaultGlobalListeningGetEp = 5;
const int defaultGlobalListeningGetEpProba = 5;
const double defaultGlobalExpStamina = 1.25;
const Duration defaultGlobalGaugeDecreaseDelay = Duration(seconds: 300);
const int defaultGlobalGaugeDecrease = 50;
const int defaultGlobalLuck = 5;
const Duration defaultGlobalStaminaChargeDelay = Duration(seconds: 43200);
const int defaultGlobalStaminaChargeRate = 100;

const int defaultGlobalConfigurationSyncTickCount = 10;
const int defaultGlobalConfigurationListeningGaugeGain = 1;
const Duration defaultGlobalConfigurationTickSeconds = Duration(seconds: 1);

const int defaultGlobalConfigurationStaminaBoxRequirement = 100;
const int defaultGlobalConfigurationSspBoxRequirement = 80;
const int defaultGlobalConfigurationEpBoxRequirement = 100;

@freezed
class Global with _$Global {
  const factory Global({
    @JsonKey(name: "configuration")
    @Default(
      Configuration(
        tickSeconds: defaultGlobalConfigurationTickSeconds,
        syncTickCount: defaultGlobalConfigurationSyncTickCount,
        listeningGaugeGain: defaultGlobalConfigurationListeningGaugeGain,
        epBoxRequirement: defaultGlobalConfigurationEpBoxRequirement,
        sspBoxRequirement: defaultGlobalConfigurationSspBoxRequirement,
        staminaBoxRequirement: defaultGlobalConfigurationStaminaBoxRequirement,
        showIdPwLogin: true,
      ),
    )
    Configuration configuration,
    //
    @JsonKey(name: "listening_Gauge")
    @Default(defaultGlobalListeningGauge)
    int listeningGauge,
    @SecondConverter()
    @JsonKey(name: "stamina_charge_delay")
    @Default(defaultGlobalStaminaChargeDelay)
    Duration staminaChargeDelay,
    @JsonKey(name: "gaugeDecrease")
    @Default(defaultGlobalGaugeDecrease)
    int gaugeDecrease,
    @JsonKey(name: "listening_GetEP")
    @Default(defaultGlobalListeningGetEp)
    int listeningGetEp,
    @JsonKey(name: "stamina_charge_rate")
    @Default(defaultGlobalStaminaChargeRate)
    int staminaChargeRate,
    @SecondConverter()
    @JsonKey(name: "gaugeDecrease_delay")
    @Default(defaultGlobalGaugeDecreaseDelay)
    Duration gaugeDecreaseDelay,
    @JsonKey(name: "listening_GetEP_Proba")
    @Default(defaultGlobalListeningGetEpProba)
    int listeningGetEpProba,
    @JsonKey(name: "stamina_Use")
    @Default(defaultGlobalStaminaUse)
    int staminaUse,
    @JsonKey(name: "listening_GetSSP")
    @Default(defaultGlobalListeningGetSsp)
    int listeningGetSsp,
    @JsonKey(name: "exp_Stamina")
    @Default(defaultGlobalExpStamina)
    double expStamina,
    @JsonKey(name: "luck") @Default(defaultGlobalLuck) int luck,
  }) = _Global;

  static Global generateDefault() => const Global(
    configuration: Configuration(
      tickSeconds: defaultGlobalConfigurationTickSeconds,
      syncTickCount: defaultGlobalConfigurationSyncTickCount,
      listeningGaugeGain: defaultGlobalConfigurationListeningGaugeGain,
      epBoxRequirement: defaultGlobalConfigurationEpBoxRequirement,
      sspBoxRequirement: defaultGlobalConfigurationSspBoxRequirement,
      staminaBoxRequirement: defaultGlobalConfigurationStaminaBoxRequirement,
      showIdPwLogin: true,
    ),
    //
    listeningGauge: defaultGlobalListeningGauge,
    staminaChargeDelay: defaultGlobalStaminaChargeDelay,
    gaugeDecrease: defaultGlobalGaugeDecrease,
    listeningGetEp: defaultGlobalListeningGetEp,
    staminaChargeRate: defaultGlobalStaminaChargeRate,
    gaugeDecreaseDelay: defaultGlobalGaugeDecreaseDelay,
    listeningGetEpProba: defaultGlobalListeningGetEpProba,
    staminaUse: defaultGlobalStaminaUse,
    listeningGetSsp: defaultGlobalListeningGetSsp,
    expStamina: defaultGlobalExpStamina,
    luck: defaultGlobalLuck,
  );

  factory Global.fromJson(Map<String, dynamic> json) => _$GlobalFromJson(json);

  factory Global.fromFirstore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Global.fromJson(snapshot.data() as Map<String, dynamic>);

  static Map<String, Object?> toFirestore(Global object, SetOptions? options) =>
      object.toJson();
}

@freezed
class Configuration with _$Configuration {
  const factory Configuration({
    @SecondConverter()
    @JsonKey(name: "tickSeconds")
    @Default(defaultGlobalConfigurationTickSeconds)
    Duration tickSeconds,
    @JsonKey(name: "syncTickCount")
    @Default(defaultGlobalConfigurationSyncTickCount)
    int syncTickCount,
    @JsonKey(name: "listeningGaugeGain")
    @Default(defaultGlobalConfigurationListeningGaugeGain)
    int listeningGaugeGain,
    @JsonKey(name: "staminaBoxRequirement")
    @Default(defaultGlobalConfigurationStaminaBoxRequirement)
    int staminaBoxRequirement,
    @JsonKey(name: "sspBoxRequirement")
    @Default(defaultGlobalConfigurationSspBoxRequirement)
    int sspBoxRequirement,
    @JsonKey(name: "epBoxRequirement")
    @Default(defaultGlobalConfigurationEpBoxRequirement)
    int epBoxRequirement,
    @Default(true) @JsonKey(name: "showIdPwLogin") bool showIdPwLogin,
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}
