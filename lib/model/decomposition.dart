import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app_common/models/converter/string_converter.dart';

part 'decomposition.freezed.dart';
part 'decomposition.g.dart';

@freezed
class Decomposition with _$Decomposition {
  const factory Decomposition({
    required String id,
    @JsonKey(name: "gear_ID") required String gearId,
    @StringToIntConverter() @JsonKey(name: "cost_EP") required int costEp,
    @StringToIntConverter() @JsonKey(name: "cost_SSP") required int costSsp,
    @StringToIntConverter() @JsonKey(name: "result_max") required int resultMax,
    @StringToIntConverter() @JsonKey(name: "result_min") required int resultMin,
    @JsonKey(name: "result1") required String? result1,
    @JsonKey(name: "result2") required String? result2,
    @JsonKey(name: "result3") required String? result3,
    @JsonKey(name: "result4") required String? result4,
    @JsonKey(name: "result5") required String? result5,
    @JsonKey(name: "result6") required String? result6,
    @JsonKey(name: "result7") required String? result7,
    @JsonKey(name: "result8") required String? result8,
  }) = _Decomposition;

  factory Decomposition.fromJson(Map<String, Object?> json) =>
      _$DecompositionFromJson(json);

  factory Decomposition.fromFirstore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Decomposition.fromJson({
    "id": snapshot.id,
    ...(snapshot.data() as Map<String, dynamic>),
  });

  static Map<String, Object?> toFirestore(
    Decomposition object,
    SetOptions? options,
  ) => object.toJson();

  const Decomposition._();
}
