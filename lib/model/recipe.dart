import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app_common/models/converter/string_converter.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    @JsonKey(name: "gear_ID") required String gearId,
    @StringToIntConverter() @JsonKey(name: "cost_SSP") required int costSsp,
    @StringToIntConverter() @JsonKey(name: "cost_EP") required int costEp,
    @StringToIntConverter()
    @JsonKey(name: "probability")
    required int probability,
    @JsonKey(name: "stuff1") required String? stuff1,
    @JsonKey(name: "stuff2") required String? stuff2,
    @JsonKey(name: "stuff3") required String? stuff3,
    @JsonKey(name: "stuff4") required String? stuff4,
    @JsonKey(name: "stuff5") required String? stuff5,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, Object?> json) => _$RecipeFromJson(json);

  factory Recipe.fromFirstore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Recipe.fromJson({
    "id": snapshot.id,
    ...(snapshot.data() as Map<String, dynamic>),
  });

  static Map<String, Object?> toFirestore(Recipe object, SetOptions? options) =>
      object.toJson();

  const Recipe._();
}
