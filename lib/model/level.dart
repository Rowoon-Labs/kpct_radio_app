import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app_common/models/converter/second_converter.dart';
import 'package:kpct_radio_app_common/models/converter/string_converter.dart';

part 'level.freezed.dart';
part 'level.g.dart';

@freezed
class Level with _$Level {
  const factory Level({
    required String id,
    @HourConverterFromString()
    @JsonKey(name: "Condition1")
    required Duration condition1,
    @StringToIntConverter()
    @JsonKey(name: "Condition2")
    required int condition2,
    @StringToIntConverter() @JsonKey(name: "Limit_SSP") required int limitSsp,
    @StringToIntConverter() @JsonKey(name: "Reward_SSP") required int rewardSsp,
    @StringToIntConverter() @JsonKey(name: "stamina") required int stamina,
    @StringToIntConverter() @JsonKey(name: "Limit_EP") required int limitEp,
    @StringToIntConverter() @JsonKey(name: "Cost_EP") required int costEp,
    @StringToIntConverter() @JsonKey(name: "Cost_SSP") required int costSsp,
    @StringToIntConverter()
    @JsonKey(name: "Reward_Count")
    required int rewardCount,
    @StringToIntConverter() @JsonKey(name: "Reward_EP") required int rewardEp,
    // @JsonKey(name: "Reward_Gear")
    // required dynamic rewardGear,
    @StringToIntConverter() @JsonKey(name: "exp") required int exp,
    @StringToIntConverter() @JsonKey(name: "level") required int level,
    @StringToIntConverter()
    @JsonKey(name: "Limit_Probability")
    required int limitProbability,
  }) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  factory Level.fromFirstore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Level.fromJson({
    "id": snapshot.id,
    ...(snapshot.data() as Map<String, dynamic>),
  });

  static Map<String, Object?> toFirestore(Level object, SetOptions? options) =>
      object.toJson();

  const Level._();
}
