// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_modal_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SettingModalEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_initialize value) initialize,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_initialize value)? initialize,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_initialize value)? initialize,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingModalEventCopyWith<$Res> {
  factory $SettingModalEventCopyWith(
    SettingModalEvent value,
    $Res Function(SettingModalEvent) then,
  ) = _$SettingModalEventCopyWithImpl<$Res, SettingModalEvent>;
}

/// @nodoc
class _$SettingModalEventCopyWithImpl<$Res, $Val extends SettingModalEvent>
    implements $SettingModalEventCopyWith<$Res> {
  _$SettingModalEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingModalEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$initializeImplCopyWith<$Res> {
  factory _$$initializeImplCopyWith(
    _$initializeImpl value,
    $Res Function(_$initializeImpl) then,
  ) = __$$initializeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$initializeImplCopyWithImpl<$Res>
    extends _$SettingModalEventCopyWithImpl<$Res, _$initializeImpl>
    implements _$$initializeImplCopyWith<$Res> {
  __$$initializeImplCopyWithImpl(
    _$initializeImpl _value,
    $Res Function(_$initializeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingModalEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$initializeImpl implements _initialize {
  const _$initializeImpl();

  @override
  String toString() {
    return 'SettingModalEvent.initialize()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$initializeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_initialize value) initialize,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_initialize value)? initialize,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_initialize value)? initialize,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class _initialize implements SettingModalEvent {
  const factory _initialize() = _$initializeImpl;
}

/// @nodoc
mixin _$SettingModalState {
  bool get initialized => throw _privateConstructorUsedError;

  /// Create a copy of SettingModalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingModalStateCopyWith<SettingModalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingModalStateCopyWith<$Res> {
  factory $SettingModalStateCopyWith(
    SettingModalState value,
    $Res Function(SettingModalState) then,
  ) = _$SettingModalStateCopyWithImpl<$Res, SettingModalState>;
  @useResult
  $Res call({bool initialized});
}

/// @nodoc
class _$SettingModalStateCopyWithImpl<$Res, $Val extends SettingModalState>
    implements $SettingModalStateCopyWith<$Res> {
  _$SettingModalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingModalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? initialized = null}) {
    return _then(
      _value.copyWith(
            initialized:
                null == initialized
                    ? _value.initialized
                    : initialized // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SettingModalStateImplCopyWith<$Res>
    implements $SettingModalStateCopyWith<$Res> {
  factory _$$SettingModalStateImplCopyWith(
    _$SettingModalStateImpl value,
    $Res Function(_$SettingModalStateImpl) then,
  ) = __$$SettingModalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool initialized});
}

/// @nodoc
class __$$SettingModalStateImplCopyWithImpl<$Res>
    extends _$SettingModalStateCopyWithImpl<$Res, _$SettingModalStateImpl>
    implements _$$SettingModalStateImplCopyWith<$Res> {
  __$$SettingModalStateImplCopyWithImpl(
    _$SettingModalStateImpl _value,
    $Res Function(_$SettingModalStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingModalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? initialized = null}) {
    return _then(
      _$SettingModalStateImpl(
        initialized:
            null == initialized
                ? _value.initialized
                : initialized // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$SettingModalStateImpl implements _SettingModalState {
  const _$SettingModalStateImpl({this.initialized = false});

  @override
  @JsonKey()
  final bool initialized;

  @override
  String toString() {
    return 'SettingModalState(initialized: $initialized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingModalStateImpl &&
            (identical(other.initialized, initialized) ||
                other.initialized == initialized));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialized);

  /// Create a copy of SettingModalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingModalStateImplCopyWith<_$SettingModalStateImpl> get copyWith =>
      __$$SettingModalStateImplCopyWithImpl<_$SettingModalStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SettingModalState implements SettingModalState {
  const factory _SettingModalState({final bool initialized}) =
      _$SettingModalStateImpl;

  @override
  bool get initialized;

  /// Create a copy of SettingModalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingModalStateImplCopyWith<_$SettingModalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
