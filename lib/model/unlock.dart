import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';
import 'package:kpct_radio_app_common/models/converter/string_converter.dart';
import 'package:kpct_radio_app_common/models/converter/gear_converter.dart';

part 'unlock.freezed.dart';
part 'unlock.g.dart';

@freezed
class Unlock with _$Unlock {
  const factory Unlock({
    required String id,
    @StringToGearTierConverter() @JsonKey(name: 'tier') required GearTier tier,
    @StringToIntConverter() @JsonKey(name: 's1cost_EP') required int s1costEp,
    @StringToIntConverter() @JsonKey(name: 's2cost_EP') required int s2costEp,
    @StringToIntConverter() @JsonKey(name: 's3cost_EP') required int s3costEp,
    @StringToIntConverter() @JsonKey(name: 's4cost_EP') required int s4costEp,
    @StringToIntConverter() @JsonKey(name: 's5cost_EP') required int s5costEp,
    @StringToIntConverter() @JsonKey(name: 's1cost_SSP') required int s1costSsp,
    @StringToIntConverter() @JsonKey(name: 's2cost_SSP') required int s2costSsp,
    @StringToIntConverter() @JsonKey(name: 's3cost_SSP') required int s3costSsp,
    @StringToIntConverter() @JsonKey(name: 's4cost_SSP') required int s4costSsp,
    @StringToIntConverter() @JsonKey(name: 's5cost_SSP') required int s5costSsp,
    @StringToIntConverter()
    @JsonKey(name: 's1_Probability')
    required int s1Probability,
    @StringToIntConverter()
    @JsonKey(name: 's2_Probability')
    required int s2Probability,
    @StringToIntConverter()
    @JsonKey(name: 's3_Probability')
    required int s3Probability,
    @StringToIntConverter()
    @JsonKey(name: 's4_Probability')
    required int s4Probability,
    @StringToIntConverter()
    @JsonKey(name: 's5_Probability')
    required int s5Probability,
  }) = _Unlock;

  factory Unlock.fromJson(Map<String, Object?> json) => _$UnlockFromJson(json);

  factory Unlock.fromFirstore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Unlock.fromJson({
    "id": snapshot.id,
    ...(snapshot.data() as Map<String, dynamic>),
  });

  static Map<String, Object?> toFirestore(Unlock object, SetOptions? options) =>
      object.toJson();

  List<int> get sspCosts => [
    s1costSsp,
    s2costSsp,
    s3costSsp,
    s4costSsp,
    s5costSsp,
  ];

  List<int> get epCosts => [s1costEp, s2costEp, s3costEp, s4costEp, s5costEp];

  List<int> get probabilities => [
    s1Probability,
    s2Probability,
    s3Probability,
    s4Probability,
    s5Probability,
  ];

  ({int sspCost, int epCost, int probability})? next({
    required int numberOfAlreadyUnlockedSockets,
  }) {
    if ((numberOfAlreadyUnlockedSockets < sspCosts.length) &&
        (numberOfAlreadyUnlockedSockets < epCosts.length) &&
        (numberOfAlreadyUnlockedSockets < probabilities.length)) {
      return (
        sspCost: sspCosts[numberOfAlreadyUnlockedSockets],
        epCost: epCosts[numberOfAlreadyUnlockedSockets],
        probability: probabilities[numberOfAlreadyUnlockedSockets],
      );
    } else {
      return null;
    }
  }

  const Unlock._();
}
