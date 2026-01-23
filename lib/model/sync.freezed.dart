// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sync _$SyncFromJson(Map<String, dynamic> json) {
  return _Sync.fromJson(json);
}

/// @nodoc
mixin _$Sync {
  int get tick => throw _privateConstructorUsedError;
  set tick(int value) => throw _privateConstructorUsedError;
  double get gainedExp => throw _privateConstructorUsedError;
  set gainedExp(double value) => throw _privateConstructorUsedError;
  int get consumedStamina => throw _privateConstructorUsedError;
  set consumedStamina(int value) => throw _privateConstructorUsedError;
  int get gainedListeningGauge => throw _privateConstructorUsedError;
  set gainedListeningGauge(int value) => throw _privateConstructorUsedError;
  Duration get elapsedPlayDuration => throw _privateConstructorUsedError;
  set elapsedPlayDuration(Duration value) => throw _privateConstructorUsedError;

  /// Serializes this Sync to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sync
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncCopyWith<Sync> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncCopyWith<$Res> {
  factory $SyncCopyWith(Sync value, $Res Function(Sync) then) =
      _$SyncCopyWithImpl<$Res, Sync>;
  @useResult
  $Res call(
      {int tick,
      double gainedExp,
      int consumedStamina,
      int gainedListeningGauge,
      Duration elapsedPlayDuration});
}

/// @nodoc
class _$SyncCopyWithImpl<$Res, $Val extends Sync>
    implements $SyncCopyWith<$Res> {
  _$SyncCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sync
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tick = null,
    Object? gainedExp = null,
    Object? consumedStamina = null,
    Object? gainedListeningGauge = null,
    Object? elapsedPlayDuration = null,
  }) {
    return _then(_value.copyWith(
      tick: null == tick
          ? _value.tick
          : tick // ignore: cast_nullable_to_non_nullable
              as int,
      gainedExp: null == gainedExp
          ? _value.gainedExp
          : gainedExp // ignore: cast_nullable_to_non_nullable
              as double,
      consumedStamina: null == consumedStamina
          ? _value.consumedStamina
          : consumedStamina // ignore: cast_nullable_to_non_nullable
              as int,
      gainedListeningGauge: null == gainedListeningGauge
          ? _value.gainedListeningGauge
          : gainedListeningGauge // ignore: cast_nullable_to_non_nullable
              as int,
      elapsedPlayDuration: null == elapsedPlayDuration
          ? _value.elapsedPlayDuration
          : elapsedPlayDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncImplCopyWith<$Res> implements $SyncCopyWith<$Res> {
  factory _$$SyncImplCopyWith(
          _$SyncImpl value, $Res Function(_$SyncImpl) then) =
      __$$SyncImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int tick,
      double gainedExp,
      int consumedStamina,
      int gainedListeningGauge,
      Duration elapsedPlayDuration});
}

/// @nodoc
class __$$SyncImplCopyWithImpl<$Res>
    extends _$SyncCopyWithImpl<$Res, _$SyncImpl>
    implements _$$SyncImplCopyWith<$Res> {
  __$$SyncImplCopyWithImpl(_$SyncImpl _value, $Res Function(_$SyncImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sync
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tick = null,
    Object? gainedExp = null,
    Object? consumedStamina = null,
    Object? gainedListeningGauge = null,
    Object? elapsedPlayDuration = null,
  }) {
    return _then(_$SyncImpl(
      tick: null == tick
          ? _value.tick
          : tick // ignore: cast_nullable_to_non_nullable
              as int,
      gainedExp: null == gainedExp
          ? _value.gainedExp
          : gainedExp // ignore: cast_nullable_to_non_nullable
              as double,
      consumedStamina: null == consumedStamina
          ? _value.consumedStamina
          : consumedStamina // ignore: cast_nullable_to_non_nullable
              as int,
      gainedListeningGauge: null == gainedListeningGauge
          ? _value.gainedListeningGauge
          : gainedListeningGauge // ignore: cast_nullable_to_non_nullable
              as int,
      elapsedPlayDuration: null == elapsedPlayDuration
          ? _value.elapsedPlayDuration
          : elapsedPlayDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncImpl extends _Sync {
  _$SyncImpl(
      {this.tick = 0,
      this.gainedExp = 0,
      this.consumedStamina = 0,
      this.gainedListeningGauge = 0,
      this.elapsedPlayDuration = Duration.zero})
      : super._();

  factory _$SyncImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncImplFromJson(json);

  @override
  @JsonKey()
  int tick;
  @override
  @JsonKey()
  double gainedExp;
  @override
  @JsonKey()
  int consumedStamina;
  @override
  @JsonKey()
  int gainedListeningGauge;
  @override
  @JsonKey()
  Duration elapsedPlayDuration;

  @override
  String toString() {
    return 'Sync(tick: $tick, gainedExp: $gainedExp, consumedStamina: $consumedStamina, gainedListeningGauge: $gainedListeningGauge, elapsedPlayDuration: $elapsedPlayDuration)';
  }

  /// Create a copy of Sync
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncImplCopyWith<_$SyncImpl> get copyWith =>
      __$$SyncImplCopyWithImpl<_$SyncImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncImplToJson(
      this,
    );
  }
}

abstract class _Sync extends Sync {
  factory _Sync(
      {int tick,
      double gainedExp,
      int consumedStamina,
      int gainedListeningGauge,
      Duration elapsedPlayDuration}) = _$SyncImpl;
  _Sync._() : super._();

  factory _Sync.fromJson(Map<String, dynamic> json) = _$SyncImpl.fromJson;

  @override
  int get tick;
  set tick(int value);
  @override
  double get gainedExp;
  set gainedExp(double value);
  @override
  int get consumedStamina;
  set consumedStamina(int value);
  @override
  int get gainedListeningGauge;
  set gainedListeningGauge(int value);
  @override
  Duration get elapsedPlayDuration;
  set elapsedPlayDuration(Duration value);

  /// Create a copy of Sync
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncImplCopyWith<_$SyncImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
