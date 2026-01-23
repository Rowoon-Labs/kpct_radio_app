// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return _Recipe.fromJson(json);
}

/// @nodoc
mixin _$Recipe {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "gear_ID")
  String get gearId => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "cost_SSP")
  int get costSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "cost_EP")
  int get costEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "probability")
  int get probability => throw _privateConstructorUsedError;
  @JsonKey(name: "stuff1")
  String? get stuff1 => throw _privateConstructorUsedError;
  @JsonKey(name: "stuff2")
  String? get stuff2 => throw _privateConstructorUsedError;
  @JsonKey(name: "stuff3")
  String? get stuff3 => throw _privateConstructorUsedError;
  @JsonKey(name: "stuff4")
  String? get stuff4 => throw _privateConstructorUsedError;
  @JsonKey(name: "stuff5")
  String? get stuff5 => throw _privateConstructorUsedError;

  /// Serializes this Recipe to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeCopyWith<Recipe> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) then) =
      _$RecipeCopyWithImpl<$Res, Recipe>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: "gear_ID") String gearId,
      @StringToIntConverter() @JsonKey(name: "cost_SSP") int costSsp,
      @StringToIntConverter() @JsonKey(name: "cost_EP") int costEp,
      @StringToIntConverter() @JsonKey(name: "probability") int probability,
      @JsonKey(name: "stuff1") String? stuff1,
      @JsonKey(name: "stuff2") String? stuff2,
      @JsonKey(name: "stuff3") String? stuff3,
      @JsonKey(name: "stuff4") String? stuff4,
      @JsonKey(name: "stuff5") String? stuff5});
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res, $Val extends Recipe>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gearId = null,
    Object? costSsp = null,
    Object? costEp = null,
    Object? probability = null,
    Object? stuff1 = freezed,
    Object? stuff2 = freezed,
    Object? stuff3 = freezed,
    Object? stuff4 = freezed,
    Object? stuff5 = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gearId: null == gearId
          ? _value.gearId
          : gearId // ignore: cast_nullable_to_non_nullable
              as String,
      costSsp: null == costSsp
          ? _value.costSsp
          : costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      costEp: null == costEp
          ? _value.costEp
          : costEp // ignore: cast_nullable_to_non_nullable
              as int,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as int,
      stuff1: freezed == stuff1
          ? _value.stuff1
          : stuff1 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff2: freezed == stuff2
          ? _value.stuff2
          : stuff2 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff3: freezed == stuff3
          ? _value.stuff3
          : stuff3 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff4: freezed == stuff4
          ? _value.stuff4
          : stuff4 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff5: freezed == stuff5
          ? _value.stuff5
          : stuff5 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeImplCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$$RecipeImplCopyWith(
          _$RecipeImpl value, $Res Function(_$RecipeImpl) then) =
      __$$RecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: "gear_ID") String gearId,
      @StringToIntConverter() @JsonKey(name: "cost_SSP") int costSsp,
      @StringToIntConverter() @JsonKey(name: "cost_EP") int costEp,
      @StringToIntConverter() @JsonKey(name: "probability") int probability,
      @JsonKey(name: "stuff1") String? stuff1,
      @JsonKey(name: "stuff2") String? stuff2,
      @JsonKey(name: "stuff3") String? stuff3,
      @JsonKey(name: "stuff4") String? stuff4,
      @JsonKey(name: "stuff5") String? stuff5});
}

/// @nodoc
class __$$RecipeImplCopyWithImpl<$Res>
    extends _$RecipeCopyWithImpl<$Res, _$RecipeImpl>
    implements _$$RecipeImplCopyWith<$Res> {
  __$$RecipeImplCopyWithImpl(
      _$RecipeImpl _value, $Res Function(_$RecipeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gearId = null,
    Object? costSsp = null,
    Object? costEp = null,
    Object? probability = null,
    Object? stuff1 = freezed,
    Object? stuff2 = freezed,
    Object? stuff3 = freezed,
    Object? stuff4 = freezed,
    Object? stuff5 = freezed,
  }) {
    return _then(_$RecipeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gearId: null == gearId
          ? _value.gearId
          : gearId // ignore: cast_nullable_to_non_nullable
              as String,
      costSsp: null == costSsp
          ? _value.costSsp
          : costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      costEp: null == costEp
          ? _value.costEp
          : costEp // ignore: cast_nullable_to_non_nullable
              as int,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as int,
      stuff1: freezed == stuff1
          ? _value.stuff1
          : stuff1 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff2: freezed == stuff2
          ? _value.stuff2
          : stuff2 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff3: freezed == stuff3
          ? _value.stuff3
          : stuff3 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff4: freezed == stuff4
          ? _value.stuff4
          : stuff4 // ignore: cast_nullable_to_non_nullable
              as String?,
      stuff5: freezed == stuff5
          ? _value.stuff5
          : stuff5 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeImpl extends _Recipe {
  const _$RecipeImpl(
      {required this.id,
      @JsonKey(name: "gear_ID") required this.gearId,
      @StringToIntConverter() @JsonKey(name: "cost_SSP") required this.costSsp,
      @StringToIntConverter() @JsonKey(name: "cost_EP") required this.costEp,
      @StringToIntConverter()
      @JsonKey(name: "probability")
      required this.probability,
      @JsonKey(name: "stuff1") required this.stuff1,
      @JsonKey(name: "stuff2") required this.stuff2,
      @JsonKey(name: "stuff3") required this.stuff3,
      @JsonKey(name: "stuff4") required this.stuff4,
      @JsonKey(name: "stuff5") required this.stuff5})
      : super._();

  factory _$RecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: "gear_ID")
  final String gearId;
  @override
  @StringToIntConverter()
  @JsonKey(name: "cost_SSP")
  final int costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "cost_EP")
  final int costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "probability")
  final int probability;
  @override
  @JsonKey(name: "stuff1")
  final String? stuff1;
  @override
  @JsonKey(name: "stuff2")
  final String? stuff2;
  @override
  @JsonKey(name: "stuff3")
  final String? stuff3;
  @override
  @JsonKey(name: "stuff4")
  final String? stuff4;
  @override
  @JsonKey(name: "stuff5")
  final String? stuff5;

  @override
  String toString() {
    return 'Recipe(id: $id, gearId: $gearId, costSsp: $costSsp, costEp: $costEp, probability: $probability, stuff1: $stuff1, stuff2: $stuff2, stuff3: $stuff3, stuff4: $stuff4, stuff5: $stuff5)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gearId, gearId) || other.gearId == gearId) &&
            (identical(other.costSsp, costSsp) || other.costSsp == costSsp) &&
            (identical(other.costEp, costEp) || other.costEp == costEp) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.stuff1, stuff1) || other.stuff1 == stuff1) &&
            (identical(other.stuff2, stuff2) || other.stuff2 == stuff2) &&
            (identical(other.stuff3, stuff3) || other.stuff3 == stuff3) &&
            (identical(other.stuff4, stuff4) || other.stuff4 == stuff4) &&
            (identical(other.stuff5, stuff5) || other.stuff5 == stuff5));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, gearId, costSsp, costEp,
      probability, stuff1, stuff2, stuff3, stuff4, stuff5);

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      __$$RecipeImplCopyWithImpl<_$RecipeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeImplToJson(
      this,
    );
  }
}

abstract class _Recipe extends Recipe {
  const factory _Recipe(
      {required final String id,
      @JsonKey(name: "gear_ID") required final String gearId,
      @StringToIntConverter()
      @JsonKey(name: "cost_SSP")
      required final int costSsp,
      @StringToIntConverter()
      @JsonKey(name: "cost_EP")
      required final int costEp,
      @StringToIntConverter()
      @JsonKey(name: "probability")
      required final int probability,
      @JsonKey(name: "stuff1") required final String? stuff1,
      @JsonKey(name: "stuff2") required final String? stuff2,
      @JsonKey(name: "stuff3") required final String? stuff3,
      @JsonKey(name: "stuff4") required final String? stuff4,
      @JsonKey(name: "stuff5") required final String? stuff5}) = _$RecipeImpl;
  const _Recipe._() : super._();

  factory _Recipe.fromJson(Map<String, dynamic> json) = _$RecipeImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: "gear_ID")
  String get gearId;
  @override
  @StringToIntConverter()
  @JsonKey(name: "cost_SSP")
  int get costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "cost_EP")
  int get costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "probability")
  int get probability;
  @override
  @JsonKey(name: "stuff1")
  String? get stuff1;
  @override
  @JsonKey(name: "stuff2")
  String? get stuff2;
  @override
  @JsonKey(name: "stuff3")
  String? get stuff3;
  @override
  @JsonKey(name: "stuff4")
  String? get stuff4;
  @override
  @JsonKey(name: "stuff5")
  String? get stuff5;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeImplCopyWith<_$RecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
