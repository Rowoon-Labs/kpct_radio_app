import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app_common/models/converter/string_converter.dart';

part 'draw.freezed.dart';
part 'draw.g.dart';

enum DrawId {
  @JsonValue("free_radio")
  freeRadio,
  @JsonValue("stamina_radio")
  staminaRadio,
  @JsonValue("ssp_radio")
  sspRadio,

  @JsonValue("free_lg")
  freeLg,
  @JsonValue("stamina_lg")
  staminaLg,
  @JsonValue("ssp_lg")
  sspLg,

  @JsonValue("ep_box")
  epBox,

  @JsonValue("ssp_box_ex")
  sspBoxEx,
  @JsonValue("ep_box_ex")
  epBoxEx,
}

@freezed
class Draw with _$Draw {
  const factory Draw({
    required String id,
    @StringToIntConverter() @JsonKey(name: "Rate") required int rate,
    @JsonKey(name: "draw_ID") required DrawId drawId,
    @StringToIntConverter() @JsonKey(name: "max") required int max,
    @StringToIntConverter() @JsonKey(name: "mn") required int mn,
    @JsonKey(name: "result") required String result,
  }) = _Draw;

  factory Draw.fromJson(Map<String, Object?> json) => _$DrawFromJson(json);

  factory Draw.fromFirstore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Draw.fromJson({
    "id": snapshot.id,
    ...(snapshot.data() as Map<String, dynamic>),
  });

  static Map<String, Object?> toFirestore(Draw object, SetOptions? options) =>
      object.toJson();

  const Draw._();
}
