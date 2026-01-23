// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unlock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Unlock _$UnlockFromJson(Map<String, dynamic> json) {
  return _Unlock.fromJson(json);
}

/// @nodoc
mixin _$Unlock {
  String get id => throw _privateConstructorUsedError;
  @StringToGearTierConverter()
  @JsonKey(name: 'tier')
  GearTier get tier => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's1cost_EP')
  int get s1costEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's2cost_EP')
  int get s2costEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's3cost_EP')
  int get s3costEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's4cost_EP')
  int get s4costEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's5cost_EP')
  int get s5costEp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's1cost_SSP')
  int get s1costSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's2cost_SSP')
  int get s2costSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's3cost_SSP')
  int get s3costSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's4cost_SSP')
  int get s4costSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's5cost_SSP')
  int get s5costSsp => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's1_Probability')
  int get s1Probability => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's2_Probability')
  int get s2Probability => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's3_Probability')
  int get s3Probability => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's4_Probability')
  int get s4Probability => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: 's5_Probability')
  int get s5Probability => throw _privateConstructorUsedError;

  /// Serializes this Unlock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Unlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnlockCopyWith<Unlock> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnlockCopyWith<$Res> {
  factory $UnlockCopyWith(Unlock value, $Res Function(Unlock) then) =
      _$UnlockCopyWithImpl<$Res, Unlock>;
  @useResult
  $Res call(
      {String id,
      @StringToGearTierConverter() @JsonKey(name: 'tier') GearTier tier,
      @StringToIntConverter() @JsonKey(name: 's1cost_EP') int s1costEp,
      @StringToIntConverter() @JsonKey(name: 's2cost_EP') int s2costEp,
      @StringToIntConverter() @JsonKey(name: 's3cost_EP') int s3costEp,
      @StringToIntConverter() @JsonKey(name: 's4cost_EP') int s4costEp,
      @StringToIntConverter() @JsonKey(name: 's5cost_EP') int s5costEp,
      @StringToIntConverter() @JsonKey(name: 's1cost_SSP') int s1costSsp,
      @StringToIntConverter() @JsonKey(name: 's2cost_SSP') int s2costSsp,
      @StringToIntConverter() @JsonKey(name: 's3cost_SSP') int s3costSsp,
      @StringToIntConverter() @JsonKey(name: 's4cost_SSP') int s4costSsp,
      @StringToIntConverter() @JsonKey(name: 's5cost_SSP') int s5costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's1_Probability')
      int s1Probability,
      @StringToIntConverter()
      @JsonKey(name: 's2_Probability')
      int s2Probability,
      @StringToIntConverter()
      @JsonKey(name: 's3_Probability')
      int s3Probability,
      @StringToIntConverter()
      @JsonKey(name: 's4_Probability')
      int s4Probability,
      @StringToIntConverter()
      @JsonKey(name: 's5_Probability')
      int s5Probability});
}

/// @nodoc
class _$UnlockCopyWithImpl<$Res, $Val extends Unlock>
    implements $UnlockCopyWith<$Res> {
  _$UnlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Unlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tier = null,
    Object? s1costEp = null,
    Object? s2costEp = null,
    Object? s3costEp = null,
    Object? s4costEp = null,
    Object? s5costEp = null,
    Object? s1costSsp = null,
    Object? s2costSsp = null,
    Object? s3costSsp = null,
    Object? s4costSsp = null,
    Object? s5costSsp = null,
    Object? s1Probability = null,
    Object? s2Probability = null,
    Object? s3Probability = null,
    Object? s4Probability = null,
    Object? s5Probability = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as GearTier,
      s1costEp: null == s1costEp
          ? _value.s1costEp
          : s1costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s2costEp: null == s2costEp
          ? _value.s2costEp
          : s2costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s3costEp: null == s3costEp
          ? _value.s3costEp
          : s3costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s4costEp: null == s4costEp
          ? _value.s4costEp
          : s4costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s5costEp: null == s5costEp
          ? _value.s5costEp
          : s5costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s1costSsp: null == s1costSsp
          ? _value.s1costSsp
          : s1costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s2costSsp: null == s2costSsp
          ? _value.s2costSsp
          : s2costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s3costSsp: null == s3costSsp
          ? _value.s3costSsp
          : s3costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s4costSsp: null == s4costSsp
          ? _value.s4costSsp
          : s4costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s5costSsp: null == s5costSsp
          ? _value.s5costSsp
          : s5costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s1Probability: null == s1Probability
          ? _value.s1Probability
          : s1Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s2Probability: null == s2Probability
          ? _value.s2Probability
          : s2Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s3Probability: null == s3Probability
          ? _value.s3Probability
          : s3Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s4Probability: null == s4Probability
          ? _value.s4Probability
          : s4Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s5Probability: null == s5Probability
          ? _value.s5Probability
          : s5Probability // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnlockImplCopyWith<$Res> implements $UnlockCopyWith<$Res> {
  factory _$$UnlockImplCopyWith(
          _$UnlockImpl value, $Res Function(_$UnlockImpl) then) =
      __$$UnlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @StringToGearTierConverter() @JsonKey(name: 'tier') GearTier tier,
      @StringToIntConverter() @JsonKey(name: 's1cost_EP') int s1costEp,
      @StringToIntConverter() @JsonKey(name: 's2cost_EP') int s2costEp,
      @StringToIntConverter() @JsonKey(name: 's3cost_EP') int s3costEp,
      @StringToIntConverter() @JsonKey(name: 's4cost_EP') int s4costEp,
      @StringToIntConverter() @JsonKey(name: 's5cost_EP') int s5costEp,
      @StringToIntConverter() @JsonKey(name: 's1cost_SSP') int s1costSsp,
      @StringToIntConverter() @JsonKey(name: 's2cost_SSP') int s2costSsp,
      @StringToIntConverter() @JsonKey(name: 's3cost_SSP') int s3costSsp,
      @StringToIntConverter() @JsonKey(name: 's4cost_SSP') int s4costSsp,
      @StringToIntConverter() @JsonKey(name: 's5cost_SSP') int s5costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's1_Probability')
      int s1Probability,
      @StringToIntConverter()
      @JsonKey(name: 's2_Probability')
      int s2Probability,
      @StringToIntConverter()
      @JsonKey(name: 's3_Probability')
      int s3Probability,
      @StringToIntConverter()
      @JsonKey(name: 's4_Probability')
      int s4Probability,
      @StringToIntConverter()
      @JsonKey(name: 's5_Probability')
      int s5Probability});
}

/// @nodoc
class __$$UnlockImplCopyWithImpl<$Res>
    extends _$UnlockCopyWithImpl<$Res, _$UnlockImpl>
    implements _$$UnlockImplCopyWith<$Res> {
  __$$UnlockImplCopyWithImpl(
      _$UnlockImpl _value, $Res Function(_$UnlockImpl) _then)
      : super(_value, _then);

  /// Create a copy of Unlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tier = null,
    Object? s1costEp = null,
    Object? s2costEp = null,
    Object? s3costEp = null,
    Object? s4costEp = null,
    Object? s5costEp = null,
    Object? s1costSsp = null,
    Object? s2costSsp = null,
    Object? s3costSsp = null,
    Object? s4costSsp = null,
    Object? s5costSsp = null,
    Object? s1Probability = null,
    Object? s2Probability = null,
    Object? s3Probability = null,
    Object? s4Probability = null,
    Object? s5Probability = null,
  }) {
    return _then(_$UnlockImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as GearTier,
      s1costEp: null == s1costEp
          ? _value.s1costEp
          : s1costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s2costEp: null == s2costEp
          ? _value.s2costEp
          : s2costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s3costEp: null == s3costEp
          ? _value.s3costEp
          : s3costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s4costEp: null == s4costEp
          ? _value.s4costEp
          : s4costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s5costEp: null == s5costEp
          ? _value.s5costEp
          : s5costEp // ignore: cast_nullable_to_non_nullable
              as int,
      s1costSsp: null == s1costSsp
          ? _value.s1costSsp
          : s1costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s2costSsp: null == s2costSsp
          ? _value.s2costSsp
          : s2costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s3costSsp: null == s3costSsp
          ? _value.s3costSsp
          : s3costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s4costSsp: null == s4costSsp
          ? _value.s4costSsp
          : s4costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s5costSsp: null == s5costSsp
          ? _value.s5costSsp
          : s5costSsp // ignore: cast_nullable_to_non_nullable
              as int,
      s1Probability: null == s1Probability
          ? _value.s1Probability
          : s1Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s2Probability: null == s2Probability
          ? _value.s2Probability
          : s2Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s3Probability: null == s3Probability
          ? _value.s3Probability
          : s3Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s4Probability: null == s4Probability
          ? _value.s4Probability
          : s4Probability // ignore: cast_nullable_to_non_nullable
              as int,
      s5Probability: null == s5Probability
          ? _value.s5Probability
          : s5Probability // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnlockImpl extends _Unlock {
  const _$UnlockImpl(
      {required this.id,
      @StringToGearTierConverter() @JsonKey(name: 'tier') required this.tier,
      @StringToIntConverter()
      @JsonKey(name: 's1cost_EP')
      required this.s1costEp,
      @StringToIntConverter()
      @JsonKey(name: 's2cost_EP')
      required this.s2costEp,
      @StringToIntConverter()
      @JsonKey(name: 's3cost_EP')
      required this.s3costEp,
      @StringToIntConverter()
      @JsonKey(name: 's4cost_EP')
      required this.s4costEp,
      @StringToIntConverter()
      @JsonKey(name: 's5cost_EP')
      required this.s5costEp,
      @StringToIntConverter()
      @JsonKey(name: 's1cost_SSP')
      required this.s1costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's2cost_SSP')
      required this.s2costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's3cost_SSP')
      required this.s3costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's4cost_SSP')
      required this.s4costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's5cost_SSP')
      required this.s5costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's1_Probability')
      required this.s1Probability,
      @StringToIntConverter()
      @JsonKey(name: 's2_Probability')
      required this.s2Probability,
      @StringToIntConverter()
      @JsonKey(name: 's3_Probability')
      required this.s3Probability,
      @StringToIntConverter()
      @JsonKey(name: 's4_Probability')
      required this.s4Probability,
      @StringToIntConverter()
      @JsonKey(name: 's5_Probability')
      required this.s5Probability})
      : super._();

  factory _$UnlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnlockImplFromJson(json);

  @override
  final String id;
  @override
  @StringToGearTierConverter()
  @JsonKey(name: 'tier')
  final GearTier tier;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's1cost_EP')
  final int s1costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's2cost_EP')
  final int s2costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's3cost_EP')
  final int s3costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's4cost_EP')
  final int s4costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's5cost_EP')
  final int s5costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's1cost_SSP')
  final int s1costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's2cost_SSP')
  final int s2costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's3cost_SSP')
  final int s3costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's4cost_SSP')
  final int s4costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's5cost_SSP')
  final int s5costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's1_Probability')
  final int s1Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's2_Probability')
  final int s2Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's3_Probability')
  final int s3Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's4_Probability')
  final int s4Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's5_Probability')
  final int s5Probability;

  @override
  String toString() {
    return 'Unlock(id: $id, tier: $tier, s1costEp: $s1costEp, s2costEp: $s2costEp, s3costEp: $s3costEp, s4costEp: $s4costEp, s5costEp: $s5costEp, s1costSsp: $s1costSsp, s2costSsp: $s2costSsp, s3costSsp: $s3costSsp, s4costSsp: $s4costSsp, s5costSsp: $s5costSsp, s1Probability: $s1Probability, s2Probability: $s2Probability, s3Probability: $s3Probability, s4Probability: $s4Probability, s5Probability: $s5Probability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnlockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.s1costEp, s1costEp) ||
                other.s1costEp == s1costEp) &&
            (identical(other.s2costEp, s2costEp) ||
                other.s2costEp == s2costEp) &&
            (identical(other.s3costEp, s3costEp) ||
                other.s3costEp == s3costEp) &&
            (identical(other.s4costEp, s4costEp) ||
                other.s4costEp == s4costEp) &&
            (identical(other.s5costEp, s5costEp) ||
                other.s5costEp == s5costEp) &&
            (identical(other.s1costSsp, s1costSsp) ||
                other.s1costSsp == s1costSsp) &&
            (identical(other.s2costSsp, s2costSsp) ||
                other.s2costSsp == s2costSsp) &&
            (identical(other.s3costSsp, s3costSsp) ||
                other.s3costSsp == s3costSsp) &&
            (identical(other.s4costSsp, s4costSsp) ||
                other.s4costSsp == s4costSsp) &&
            (identical(other.s5costSsp, s5costSsp) ||
                other.s5costSsp == s5costSsp) &&
            (identical(other.s1Probability, s1Probability) ||
                other.s1Probability == s1Probability) &&
            (identical(other.s2Probability, s2Probability) ||
                other.s2Probability == s2Probability) &&
            (identical(other.s3Probability, s3Probability) ||
                other.s3Probability == s3Probability) &&
            (identical(other.s4Probability, s4Probability) ||
                other.s4Probability == s4Probability) &&
            (identical(other.s5Probability, s5Probability) ||
                other.s5Probability == s5Probability));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tier,
      s1costEp,
      s2costEp,
      s3costEp,
      s4costEp,
      s5costEp,
      s1costSsp,
      s2costSsp,
      s3costSsp,
      s4costSsp,
      s5costSsp,
      s1Probability,
      s2Probability,
      s3Probability,
      s4Probability,
      s5Probability);

  /// Create a copy of Unlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnlockImplCopyWith<_$UnlockImpl> get copyWith =>
      __$$UnlockImplCopyWithImpl<_$UnlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnlockImplToJson(
      this,
    );
  }
}

abstract class _Unlock extends Unlock {
  const factory _Unlock(
      {required final String id,
      @StringToGearTierConverter()
      @JsonKey(name: 'tier')
      required final GearTier tier,
      @StringToIntConverter()
      @JsonKey(name: 's1cost_EP')
      required final int s1costEp,
      @StringToIntConverter()
      @JsonKey(name: 's2cost_EP')
      required final int s2costEp,
      @StringToIntConverter()
      @JsonKey(name: 's3cost_EP')
      required final int s3costEp,
      @StringToIntConverter()
      @JsonKey(name: 's4cost_EP')
      required final int s4costEp,
      @StringToIntConverter()
      @JsonKey(name: 's5cost_EP')
      required final int s5costEp,
      @StringToIntConverter()
      @JsonKey(name: 's1cost_SSP')
      required final int s1costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's2cost_SSP')
      required final int s2costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's3cost_SSP')
      required final int s3costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's4cost_SSP')
      required final int s4costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's5cost_SSP')
      required final int s5costSsp,
      @StringToIntConverter()
      @JsonKey(name: 's1_Probability')
      required final int s1Probability,
      @StringToIntConverter()
      @JsonKey(name: 's2_Probability')
      required final int s2Probability,
      @StringToIntConverter()
      @JsonKey(name: 's3_Probability')
      required final int s3Probability,
      @StringToIntConverter()
      @JsonKey(name: 's4_Probability')
      required final int s4Probability,
      @StringToIntConverter()
      @JsonKey(name: 's5_Probability')
      required final int s5Probability}) = _$UnlockImpl;
  const _Unlock._() : super._();

  factory _Unlock.fromJson(Map<String, dynamic> json) = _$UnlockImpl.fromJson;

  @override
  String get id;
  @override
  @StringToGearTierConverter()
  @JsonKey(name: 'tier')
  GearTier get tier;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's1cost_EP')
  int get s1costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's2cost_EP')
  int get s2costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's3cost_EP')
  int get s3costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's4cost_EP')
  int get s4costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's5cost_EP')
  int get s5costEp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's1cost_SSP')
  int get s1costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's2cost_SSP')
  int get s2costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's3cost_SSP')
  int get s3costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's4cost_SSP')
  int get s4costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's5cost_SSP')
  int get s5costSsp;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's1_Probability')
  int get s1Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's2_Probability')
  int get s2Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's3_Probability')
  int get s3Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's4_Probability')
  int get s4Probability;
  @override
  @StringToIntConverter()
  @JsonKey(name: 's5_Probability')
  int get s5Probability;

  /// Create a copy of Unlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnlockImplCopyWith<_$UnlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
