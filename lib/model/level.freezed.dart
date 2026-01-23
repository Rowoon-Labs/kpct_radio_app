// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Level _$LevelFromJson(Map<String, dynamic> json) {
  return _Level.fromJson(json);
}

/// @nodoc
mixin _$Level {
  String get id => throw _privateConstructorUsedError;
  @HourConverterFromString()
  @JsonKey(name: "Condition1")
  Duration get condition1 => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Condition2")
  int get condition2 => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Limit_SSP")
  int get limitSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Reward_SSP")
  int get rewardSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "stamina")
  int get stamina => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Limit_EP")
  int get limitEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Cost_EP")
  int get costEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Cost_SSP")
  int get costSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Reward_Count")
  int get rewardCount => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Reward_EP")
  int get rewardEp =>
      throw _privateConstructorUsedError; // @JsonKey(name: "Reward_Gear")
// required dynamic rewardGear,
  @StringToIntConverter()
  @JsonKey(name: "exp")
  int get exp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "level")
  int get level => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Limit_Probability")
  int get limitProbability => throw _privateConstructorUsedError;

  /// Serializes this Level to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LevelCopyWith<Level> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelCopyWith<$Res> {
  factory $LevelCopyWith(Level value, $Res Function(Level) then) =
      _$LevelCopyWithImpl<$Res, Level>;
  @useResult
  $Res call(
      {String id,
      @HourConverterFromString()
      @JsonKey(name: "Condition1")
      Duration condition1,
      @StringToIntConverter() @JsonKey(name: "Condition2") int condition2,
      @StringToIntConverter() @JsonKey(name: "Limit_SSP") int limitSsp,
      @StringToIntConverter() @JsonKey(name: "Reward_SSP") int rewardSsp,
      @StringToIntConverter() @JsonKey(name: "stamina") int stamina,
      @StringToIntConverter() @JsonKey(name: "Limit_EP") int limitEp,
      @StringToIntConverter() @JsonKey(name: "Cost_EP") int costEp,
      @StringToIntConverter() @JsonKey(name: "Cost_SSP") int costSsp,
      @StringToIntConverter() @JsonKey(name: "Reward_Count") int rewardCount,
      @StringToIntConverter() @JsonKey(name: "Reward_EP") int rewardEp,
      @StringToIntConverter() @JsonKey(name: "exp") int exp,
      @StringToIntConverter() @JsonKey(name: "level") int level,
      @StringToIntConverter()
      @JsonKey(name: "Limit_Probability")
      int limitProbability});
}

/// @nodoc
class _$LevelCopyWithImpl<$Res, $Val extends Level>
    implements $LevelCopyWith<$Res> {
  _$LevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? condition1 = null,
    Object? condition2 = null,
    Object? limitSsp = null,
    Object? rewardSsp = null,
    Object? stamina = null,
    Object? limitEp = null,
    Object? costEp = null,
    Object? costSsp = null,
    Object? rewardCount = null,
    Object? rewardEp = null,
    Object? exp = null,
    Object? level = null,
    Object? limitProbability = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      condition1: null == condition1
          ? _value.condition1
          : condition1 // ignore: cast_nullable_to_non_nullable
              as Duration,
      condition2: null == condition2
          ? _value.condition2
          : condition2 // ignore: cast_nullable_to_non_nullable
              as int,
      limitSsp: null == limitSsp
          ? _value.limitSsp
          : limitSsp // ignore: cast_nullable_to_non_nullable
              as int,
      rewardSsp: null == rewardSsp
          ? _value.rewardSsp
          : rewardSsp // ignore: cast_nullable_to_non_nullable
              as int,
      stamina: null == stamina
          ? _value.stamina
          : stamina // ignore: cast_nullable_to_non_nullable
              as int,
      limitEp: null == limitEp
          ? _value.limitEp
          : limitEp // ignore: cast_nullable_to_non_nullable
              as int,
      costEp: null == costEp
          ? _value.costEp
          : costEp // ignore: cast_nullable_to_non_nullable
              as int,
      costSsp: null == costSsp
          ? _value.costSsp
          : costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      rewardCount: null == rewardCount
          ? _value.rewardCount
          : rewardCount // ignore: cast_nullable_to_non_nullable
              as int,
      rewardEp: null == rewardEp
          ? _value.rewardEp
          : rewardEp // ignore: cast_nullable_to_non_nullable
              as int,
      exp: null == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      limitProbability: null == limitProbability
          ? _value.limitProbability
          : limitProbability // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LevelImplCopyWith<$Res> implements $LevelCopyWith<$Res> {
  factory _$$LevelImplCopyWith(
          _$LevelImpl value, $Res Function(_$LevelImpl) then) =
      __$$LevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @HourConverterFromString()
      @JsonKey(name: "Condition1")
      Duration condition1,
      @StringToIntConverter() @JsonKey(name: "Condition2") int condition2,
      @StringToIntConverter() @JsonKey(name: "Limit_SSP") int limitSsp,
      @StringToIntConverter() @JsonKey(name: "Reward_SSP") int rewardSsp,
      @StringToIntConverter() @JsonKey(name: "stamina") int stamina,
      @StringToIntConverter() @JsonKey(name: "Limit_EP") int limitEp,
      @StringToIntConverter() @JsonKey(name: "Cost_EP") int costEp,
      @StringToIntConverter() @JsonKey(name: "Cost_SSP") int costSsp,
      @StringToIntConverter() @JsonKey(name: "Reward_Count") int rewardCount,
      @StringToIntConverter() @JsonKey(name: "Reward_EP") int rewardEp,
      @StringToIntConverter() @JsonKey(name: "exp") int exp,
      @StringToIntConverter() @JsonKey(name: "level") int level,
      @StringToIntConverter()
      @JsonKey(name: "Limit_Probability")
      int limitProbability});
}

/// @nodoc
class __$$LevelImplCopyWithImpl<$Res>
    extends _$LevelCopyWithImpl<$Res, _$LevelImpl>
    implements _$$LevelImplCopyWith<$Res> {
  __$$LevelImplCopyWithImpl(
      _$LevelImpl _value, $Res Function(_$LevelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? condition1 = null,
    Object? condition2 = null,
    Object? limitSsp = null,
    Object? rewardSsp = null,
    Object? stamina = null,
    Object? limitEp = null,
    Object? costEp = null,
    Object? costSsp = null,
    Object? rewardCount = null,
    Object? rewardEp = null,
    Object? exp = null,
    Object? level = null,
    Object? limitProbability = null,
  }) {
    return _then(_$LevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      condition1: null == condition1
          ? _value.condition1
          : condition1 // ignore: cast_nullable_to_non_nullable
              as Duration,
      condition2: null == condition2
          ? _value.condition2
          : condition2 // ignore: cast_nullable_to_non_nullable
              as int,
      limitSsp: null == limitSsp
          ? _value.limitSsp
          : limitSsp // ignore: cast_nullable_to_non_nullable
              as int,
      rewardSsp: null == rewardSsp
          ? _value.rewardSsp
          : rewardSsp // ignore: cast_nullable_to_non_nullable
              as int,
      stamina: null == stamina
          ? _value.stamina
          : stamina // ignore: cast_nullable_to_non_nullable
              as int,
      limitEp: null == limitEp
          ? _value.limitEp
          : limitEp // ignore: cast_nullable_to_non_nullable
              as int,
      costEp: null == costEp
          ? _value.costEp
          : costEp // ignore: cast_nullable_to_non_nullable
              as int,
      costSsp: null == costSsp
          ? _value.costSsp
          : costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      rewardCount: null == rewardCount
          ? _value.rewardCount
          : rewardCount // ignore: cast_nullable_to_non_nullable
              as int,
      rewardEp: null == rewardEp
          ? _value.rewardEp
          : rewardEp // ignore: cast_nullable_to_non_nullable
              as int,
      exp: null == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      limitProbability: null == limitProbability
          ? _value.limitProbability
          : limitProbability // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelImpl extends _Level {
  const _$LevelImpl(
      {required this.id,
      @HourConverterFromString()
      @JsonKey(name: "Condition1")
      required this.condition1,
      @StringToIntConverter()
      @JsonKey(name: "Condition2")
      required this.condition2,
      @StringToIntConverter()
      @JsonKey(name: "Limit_SSP")
      required this.limitSsp,
      @StringToIntConverter()
      @JsonKey(name: "Reward_SSP")
      required this.rewardSsp,
      @StringToIntConverter() @JsonKey(name: "stamina") required this.stamina,
      @StringToIntConverter() @JsonKey(name: "Limit_EP") required this.limitEp,
      @StringToIntConverter() @JsonKey(name: "Cost_EP") required this.costEp,
      @StringToIntConverter() @JsonKey(name: "Cost_SSP") required this.costSsp,
      @StringToIntConverter()
      @JsonKey(name: "Reward_Count")
      required this.rewardCount,
      @StringToIntConverter()
      @JsonKey(name: "Reward_EP")
      required this.rewardEp,
      @StringToIntConverter() @JsonKey(name: "exp") required this.exp,
      @StringToIntConverter() @JsonKey(name: "level") required this.level,
      @StringToIntConverter()
      @JsonKey(name: "Limit_Probability")
      required this.limitProbability})
      : super._();

  factory _$LevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelImplFromJson(json);

  @override
  final String id;
  @override
  @HourConverterFromString()
  @JsonKey(name: "Condition1")
  final Duration condition1;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Condition2")
  final int condition2;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Limit_SSP")
  final int limitSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Reward_SSP")
  final int rewardSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "stamina")
  final int stamina;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Limit_EP")
  final int limitEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Cost_EP")
  final int costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Cost_SSP")
  final int costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Reward_Count")
  final int rewardCount;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Reward_EP")
  final int rewardEp;
// @JsonKey(name: "Reward_Gear")
// required dynamic rewardGear,
  @override
  @StringToIntConverter()
  @JsonKey(name: "exp")
  final int exp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "level")
  final int level;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Limit_Probability")
  final int limitProbability;

  @override
  String toString() {
    return 'Level(id: $id, condition1: $condition1, condition2: $condition2, limitSsp: $limitSsp, rewardSsp: $rewardSsp, stamina: $stamina, limitEp: $limitEp, costEp: $costEp, costSsp: $costSsp, rewardCount: $rewardCount, rewardEp: $rewardEp, exp: $exp, level: $level, limitProbability: $limitProbability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.condition1, condition1) ||
                other.condition1 == condition1) &&
            (identical(other.condition2, condition2) ||
                other.condition2 == condition2) &&
            (identical(other.limitSsp, limitSsp) ||
                other.limitSsp == limitSsp) &&
            (identical(other.rewardSsp, rewardSsp) ||
                other.rewardSsp == rewardSsp) &&
            (identical(other.stamina, stamina) || other.stamina == stamina) &&
            (identical(other.limitEp, limitEp) || other.limitEp == limitEp) &&
            (identical(other.costEp, costEp) || other.costEp == costEp) &&
            (identical(other.costSsp, costSsp) || other.costSsp == costSsp) &&
            (identical(other.rewardCount, rewardCount) ||
                other.rewardCount == rewardCount) &&
            (identical(other.rewardEp, rewardEp) ||
                other.rewardEp == rewardEp) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.limitProbability, limitProbability) ||
                other.limitProbability == limitProbability));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      condition1,
      condition2,
      limitSsp,
      rewardSsp,
      stamina,
      limitEp,
      costEp,
      costSsp,
      rewardCount,
      rewardEp,
      exp,
      level,
      limitProbability);

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      __$$LevelImplCopyWithImpl<_$LevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelImplToJson(
      this,
    );
  }
}

abstract class _Level extends Level {
  const factory _Level(
      {required final String id,
      @HourConverterFromString()
      @JsonKey(name: "Condition1")
      required final Duration condition1,
      @StringToIntConverter()
      @JsonKey(name: "Condition2")
      required final int condition2,
      @StringToIntConverter()
      @JsonKey(name: "Limit_SSP")
      required final int limitSsp,
      @StringToIntConverter()
      @JsonKey(name: "Reward_SSP")
      required final int rewardSsp,
      @StringToIntConverter()
      @JsonKey(name: "stamina")
      required final int stamina,
      @StringToIntConverter()
      @JsonKey(name: "Limit_EP")
      required final int limitEp,
      @StringToIntConverter()
      @JsonKey(name: "Cost_EP")
      required final int costEp,
      @StringToIntConverter()
      @JsonKey(name: "Cost_SSP")
      required final int costSsp,
      @StringToIntConverter()
      @JsonKey(name: "Reward_Count")
      required final int rewardCount,
      @StringToIntConverter()
      @JsonKey(name: "Reward_EP")
      required final int rewardEp,
      @StringToIntConverter() @JsonKey(name: "exp") required final int exp,
      @StringToIntConverter() @JsonKey(name: "level") required final int level,
      @StringToIntConverter()
      @JsonKey(name: "Limit_Probability")
      required final int limitProbability}) = _$LevelImpl;
  const _Level._() : super._();

  factory _Level.fromJson(Map<String, dynamic> json) = _$LevelImpl.fromJson;

  @override
  String get id;
  @override
  @HourConverterFromString()
  @JsonKey(name: "Condition1")
  Duration get condition1;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Condition2")
  int get condition2;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Limit_SSP")
  int get limitSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Reward_SSP")
  int get rewardSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "stamina")
  int get stamina;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Limit_EP")
  int get limitEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Cost_EP")
  int get costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Cost_SSP")
  int get costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Reward_Count")
  int get rewardCount;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Reward_EP")
  int get rewardEp; // @JsonKey(name: "Reward_Gear")
// required dynamic rewardGear,
  @override
  @StringToIntConverter()
  @JsonKey(name: "exp")
  int get exp;
  @override
  @StringToIntConverter()
  @JsonKey(name: "level")
  int get level;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Limit_Probability")
  int get limitProbability;

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
