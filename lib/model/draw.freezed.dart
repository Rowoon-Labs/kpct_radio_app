// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Draw _$DrawFromJson(Map<String, dynamic> json) {
  return _Draw.fromJson(json);
}

/// @nodoc
mixin _$Draw {
  String get id => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "Rate")
  int get rate => throw _privateConstructorUsedError;
  @JsonKey(name: "draw_ID")
  DrawId get drawId => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "max")
  int get max => throw _privateConstructorUsedError;
  @StringToIntConverter()
  @JsonKey(name: "mn")
  int get mn => throw _privateConstructorUsedError;
  @JsonKey(name: "result")
  String get result => throw _privateConstructorUsedError;

  /// Serializes this Draw to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Draw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawCopyWith<Draw> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawCopyWith<$Res> {
  factory $DrawCopyWith(Draw value, $Res Function(Draw) then) =
      _$DrawCopyWithImpl<$Res, Draw>;
  @useResult
  $Res call(
      {String id,
      @StringToIntConverter() @JsonKey(name: "Rate") int rate,
      @JsonKey(name: "draw_ID") DrawId drawId,
      @StringToIntConverter() @JsonKey(name: "max") int max,
      @StringToIntConverter() @JsonKey(name: "mn") int mn,
      @JsonKey(name: "result") String result});
}

/// @nodoc
class _$DrawCopyWithImpl<$Res, $Val extends Draw>
    implements $DrawCopyWith<$Res> {
  _$DrawCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Draw
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? rate = null,
    Object? drawId = null,
    Object? max = null,
    Object? mn = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      drawId: null == drawId
          ? _value.drawId
          : drawId // ignore: cast_nullable_to_non_nullable
              as DrawId,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      mn: null == mn
          ? _value.mn
          : mn // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrawImplCopyWith<$Res> implements $DrawCopyWith<$Res> {
  factory _$$DrawImplCopyWith(
          _$DrawImpl value, $Res Function(_$DrawImpl) then) =
      __$$DrawImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @StringToIntConverter() @JsonKey(name: "Rate") int rate,
      @JsonKey(name: "draw_ID") DrawId drawId,
      @StringToIntConverter() @JsonKey(name: "max") int max,
      @StringToIntConverter() @JsonKey(name: "mn") int mn,
      @JsonKey(name: "result") String result});
}

/// @nodoc
class __$$DrawImplCopyWithImpl<$Res>
    extends _$DrawCopyWithImpl<$Res, _$DrawImpl>
    implements _$$DrawImplCopyWith<$Res> {
  __$$DrawImplCopyWithImpl(_$DrawImpl _value, $Res Function(_$DrawImpl) _then)
      : super(_value, _then);

  /// Create a copy of Draw
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? rate = null,
    Object? drawId = null,
    Object? max = null,
    Object? mn = null,
    Object? result = null,
  }) {
    return _then(_$DrawImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      drawId: null == drawId
          ? _value.drawId
          : drawId // ignore: cast_nullable_to_non_nullable
              as DrawId,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      mn: null == mn
          ? _value.mn
          : mn // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawImpl extends _Draw {
  const _$DrawImpl(
      {required this.id,
      @StringToIntConverter() @JsonKey(name: "Rate") required this.rate,
      @JsonKey(name: "draw_ID") required this.drawId,
      @StringToIntConverter() @JsonKey(name: "max") required this.max,
      @StringToIntConverter() @JsonKey(name: "mn") required this.mn,
      @JsonKey(name: "result") required this.result})
      : super._();

  factory _$DrawImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawImplFromJson(json);

  @override
  final String id;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Rate")
  final int rate;
  @override
  @JsonKey(name: "draw_ID")
  final DrawId drawId;
  @override
  @StringToIntConverter()
  @JsonKey(name: "max")
  final int max;
  @override
  @StringToIntConverter()
  @JsonKey(name: "mn")
  final int mn;
  @override
  @JsonKey(name: "result")
  final String result;

  @override
  String toString() {
    return 'Draw(id: $id, rate: $rate, drawId: $drawId, max: $max, mn: $mn, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.drawId, drawId) || other.drawId == drawId) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.mn, mn) || other.mn == mn) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, rate, drawId, max, mn, result);

  /// Create a copy of Draw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawImplCopyWith<_$DrawImpl> get copyWith =>
      __$$DrawImplCopyWithImpl<_$DrawImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawImplToJson(
      this,
    );
  }
}

abstract class _Draw extends Draw {
  const factory _Draw(
      {required final String id,
      @StringToIntConverter() @JsonKey(name: "Rate") required final int rate,
      @JsonKey(name: "draw_ID") required final DrawId drawId,
      @StringToIntConverter() @JsonKey(name: "max") required final int max,
      @StringToIntConverter() @JsonKey(name: "mn") required final int mn,
      @JsonKey(name: "result") required final String result}) = _$DrawImpl;
  const _Draw._() : super._();

  factory _Draw.fromJson(Map<String, dynamic> json) = _$DrawImpl.fromJson;

  @override
  String get id;
  @override
  @StringToIntConverter()
  @JsonKey(name: "Rate")
  int get rate;
  @override
  @JsonKey(name: "draw_ID")
  DrawId get drawId;
  @override
  @StringToIntConverter()
  @JsonKey(name: "max")
  int get max;
  @override
  @StringToIntConverter()
  @JsonKey(name: "mn")
  int get mn;
  @override
  @JsonKey(name: "result")
  String get result;

  /// Create a copy of Draw
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawImplCopyWith<_$DrawImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
