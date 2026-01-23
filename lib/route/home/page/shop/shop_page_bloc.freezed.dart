// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShopPageEvent {
  ShopItem get shopItem => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ShopItem shopItem) tryBuy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ShopItem shopItem)? tryBuy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ShopItem shopItem)? tryBuy,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_tryBuy value) tryBuy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_tryBuy value)? tryBuy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_tryBuy value)? tryBuy,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ShopPageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopPageEventCopyWith<ShopPageEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopPageEventCopyWith<$Res> {
  factory $ShopPageEventCopyWith(
          ShopPageEvent value, $Res Function(ShopPageEvent) then) =
      _$ShopPageEventCopyWithImpl<$Res, ShopPageEvent>;
  @useResult
  $Res call({ShopItem shopItem});

  $ShopItemCopyWith<$Res> get shopItem;
}

/// @nodoc
class _$ShopPageEventCopyWithImpl<$Res, $Val extends ShopPageEvent>
    implements $ShopPageEventCopyWith<$Res> {
  _$ShopPageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopPageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopItem = null,
  }) {
    return _then(_value.copyWith(
      shopItem: null == shopItem
          ? _value.shopItem
          : shopItem // ignore: cast_nullable_to_non_nullable
              as ShopItem,
    ) as $Val);
  }

  /// Create a copy of ShopPageEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopItemCopyWith<$Res> get shopItem {
    return $ShopItemCopyWith<$Res>(_value.shopItem, (value) {
      return _then(_value.copyWith(shopItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$tryBuyImplCopyWith<$Res>
    implements $ShopPageEventCopyWith<$Res> {
  factory _$$tryBuyImplCopyWith(
          _$tryBuyImpl value, $Res Function(_$tryBuyImpl) then) =
      __$$tryBuyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ShopItem shopItem});

  @override
  $ShopItemCopyWith<$Res> get shopItem;
}

/// @nodoc
class __$$tryBuyImplCopyWithImpl<$Res>
    extends _$ShopPageEventCopyWithImpl<$Res, _$tryBuyImpl>
    implements _$$tryBuyImplCopyWith<$Res> {
  __$$tryBuyImplCopyWithImpl(
      _$tryBuyImpl _value, $Res Function(_$tryBuyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopPageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopItem = null,
  }) {
    return _then(_$tryBuyImpl(
      shopItem: null == shopItem
          ? _value.shopItem
          : shopItem // ignore: cast_nullable_to_non_nullable
              as ShopItem,
    ));
  }
}

/// @nodoc

class _$tryBuyImpl implements _tryBuy {
  const _$tryBuyImpl({required this.shopItem});

  @override
  final ShopItem shopItem;

  @override
  String toString() {
    return 'ShopPageEvent.tryBuy(shopItem: $shopItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$tryBuyImpl &&
            (identical(other.shopItem, shopItem) ||
                other.shopItem == shopItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shopItem);

  /// Create a copy of ShopPageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$tryBuyImplCopyWith<_$tryBuyImpl> get copyWith =>
      __$$tryBuyImplCopyWithImpl<_$tryBuyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ShopItem shopItem) tryBuy,
  }) {
    return tryBuy(shopItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ShopItem shopItem)? tryBuy,
  }) {
    return tryBuy?.call(shopItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ShopItem shopItem)? tryBuy,
    required TResult orElse(),
  }) {
    if (tryBuy != null) {
      return tryBuy(shopItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_tryBuy value) tryBuy,
  }) {
    return tryBuy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_tryBuy value)? tryBuy,
  }) {
    return tryBuy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_tryBuy value)? tryBuy,
    required TResult orElse(),
  }) {
    if (tryBuy != null) {
      return tryBuy(this);
    }
    return orElse();
  }
}

abstract class _tryBuy implements ShopPageEvent {
  const factory _tryBuy({required final ShopItem shopItem}) = _$tryBuyImpl;

  @override
  ShopItem get shopItem;

  /// Create a copy of ShopPageEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$tryBuyImplCopyWith<_$tryBuyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ShopPageState {
  List<ShopItemId> get processing => throw _privateConstructorUsedError;

  /// Create a copy of ShopPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopPageStateCopyWith<ShopPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopPageStateCopyWith<$Res> {
  factory $ShopPageStateCopyWith(
          ShopPageState value, $Res Function(ShopPageState) then) =
      _$ShopPageStateCopyWithImpl<$Res, ShopPageState>;
  @useResult
  $Res call({List<ShopItemId> processing});
}

/// @nodoc
class _$ShopPageStateCopyWithImpl<$Res, $Val extends ShopPageState>
    implements $ShopPageStateCopyWith<$Res> {
  _$ShopPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
  }) {
    return _then(_value.copyWith(
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as List<ShopItemId>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShopPageStateImplCopyWith<$Res>
    implements $ShopPageStateCopyWith<$Res> {
  factory _$$ShopPageStateImplCopyWith(
          _$ShopPageStateImpl value, $Res Function(_$ShopPageStateImpl) then) =
      __$$ShopPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ShopItemId> processing});
}

/// @nodoc
class __$$ShopPageStateImplCopyWithImpl<$Res>
    extends _$ShopPageStateCopyWithImpl<$Res, _$ShopPageStateImpl>
    implements _$$ShopPageStateImplCopyWith<$Res> {
  __$$ShopPageStateImplCopyWithImpl(
      _$ShopPageStateImpl _value, $Res Function(_$ShopPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
  }) {
    return _then(_$ShopPageStateImpl(
      processing: null == processing
          ? _value._processing
          : processing // ignore: cast_nullable_to_non_nullable
              as List<ShopItemId>,
    ));
  }
}

/// @nodoc

class _$ShopPageStateImpl implements _ShopPageState {
  const _$ShopPageStateImpl({final List<ShopItemId> processing = const []})
      : _processing = processing;

  final List<ShopItemId> _processing;
  @override
  @JsonKey()
  List<ShopItemId> get processing {
    if (_processing is EqualUnmodifiableListView) return _processing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_processing);
  }

  @override
  String toString() {
    return 'ShopPageState(processing: $processing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._processing, _processing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_processing));

  /// Create a copy of ShopPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopPageStateImplCopyWith<_$ShopPageStateImpl> get copyWith =>
      __$$ShopPageStateImplCopyWithImpl<_$ShopPageStateImpl>(this, _$identity);
}

abstract class _ShopPageState implements ShopPageState {
  const factory _ShopPageState({final List<ShopItemId> processing}) =
      _$ShopPageStateImpl;

  @override
  List<ShopItemId> get processing;

  /// Create a copy of ShopPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopPageStateImplCopyWith<_$ShopPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
