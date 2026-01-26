// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play_list_modal_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PlayListModalEvent {
  PlayList get playList => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PlayList playList) onPlayListPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PlayList playList)? onPlayListPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PlayList playList)? onPlayListPressed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_onPlayListPressed value) onPlayListPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_onPlayListPressed value)? onPlayListPressed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_onPlayListPressed value)? onPlayListPressed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of PlayListModalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayListModalEventCopyWith<PlayListModalEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayListModalEventCopyWith<$Res> {
  factory $PlayListModalEventCopyWith(
    PlayListModalEvent value,
    $Res Function(PlayListModalEvent) then,
  ) = _$PlayListModalEventCopyWithImpl<$Res, PlayListModalEvent>;
  @useResult
  $Res call({PlayList playList});

  $PlayListCopyWith<$Res> get playList;
}

/// @nodoc
class _$PlayListModalEventCopyWithImpl<$Res, $Val extends PlayListModalEvent>
    implements $PlayListModalEventCopyWith<$Res> {
  _$PlayListModalEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayListModalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? playList = null}) {
    return _then(
      _value.copyWith(
            playList:
                null == playList
                    ? _value.playList
                    : playList // ignore: cast_nullable_to_non_nullable
                        as PlayList,
          )
          as $Val,
    );
  }

  /// Create a copy of PlayListModalEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayListCopyWith<$Res> get playList {
    return $PlayListCopyWith<$Res>(_value.playList, (value) {
      return _then(_value.copyWith(playList: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$onPlayListPressedImplCopyWith<$Res>
    implements $PlayListModalEventCopyWith<$Res> {
  factory _$$onPlayListPressedImplCopyWith(
    _$onPlayListPressedImpl value,
    $Res Function(_$onPlayListPressedImpl) then,
  ) = __$$onPlayListPressedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlayList playList});

  @override
  $PlayListCopyWith<$Res> get playList;
}

/// @nodoc
class __$$onPlayListPressedImplCopyWithImpl<$Res>
    extends _$PlayListModalEventCopyWithImpl<$Res, _$onPlayListPressedImpl>
    implements _$$onPlayListPressedImplCopyWith<$Res> {
  __$$onPlayListPressedImplCopyWithImpl(
    _$onPlayListPressedImpl _value,
    $Res Function(_$onPlayListPressedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayListModalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? playList = null}) {
    return _then(
      _$onPlayListPressedImpl(
        playList:
            null == playList
                ? _value.playList
                : playList // ignore: cast_nullable_to_non_nullable
                    as PlayList,
      ),
    );
  }
}

/// @nodoc

class _$onPlayListPressedImpl implements _onPlayListPressed {
  const _$onPlayListPressedImpl({required this.playList});

  @override
  final PlayList playList;

  @override
  String toString() {
    return 'PlayListModalEvent.onPlayListPressed(playList: $playList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$onPlayListPressedImpl &&
            (identical(other.playList, playList) ||
                other.playList == playList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playList);

  /// Create a copy of PlayListModalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$onPlayListPressedImplCopyWith<_$onPlayListPressedImpl> get copyWith =>
      __$$onPlayListPressedImplCopyWithImpl<_$onPlayListPressedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PlayList playList) onPlayListPressed,
  }) {
    return onPlayListPressed(playList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PlayList playList)? onPlayListPressed,
  }) {
    return onPlayListPressed?.call(playList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PlayList playList)? onPlayListPressed,
    required TResult orElse(),
  }) {
    if (onPlayListPressed != null) {
      return onPlayListPressed(playList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_onPlayListPressed value) onPlayListPressed,
  }) {
    return onPlayListPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_onPlayListPressed value)? onPlayListPressed,
  }) {
    return onPlayListPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_onPlayListPressed value)? onPlayListPressed,
    required TResult orElse(),
  }) {
    if (onPlayListPressed != null) {
      return onPlayListPressed(this);
    }
    return orElse();
  }
}

abstract class _onPlayListPressed implements PlayListModalEvent {
  const factory _onPlayListPressed({required final PlayList playList}) =
      _$onPlayListPressedImpl;

  @override
  PlayList get playList;

  /// Create a copy of PlayListModalEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$onPlayListPressedImplCopyWith<_$onPlayListPressedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayListModalState {
  List<PlayList> get playLists => throw _privateConstructorUsedError;
  PlayList? get selectedPlayList => throw _privateConstructorUsedError;
  Video? get selectedVideo => throw _privateConstructorUsedError;

  /// Create a copy of PlayListModalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayListModalStateCopyWith<PlayListModalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayListModalStateCopyWith<$Res> {
  factory $PlayListModalStateCopyWith(
    PlayListModalState value,
    $Res Function(PlayListModalState) then,
  ) = _$PlayListModalStateCopyWithImpl<$Res, PlayListModalState>;
  @useResult
  $Res call({
    List<PlayList> playLists,
    PlayList? selectedPlayList,
    Video? selectedVideo,
  });

  $PlayListCopyWith<$Res>? get selectedPlayList;
  $VideoCopyWith<$Res>? get selectedVideo;
}

/// @nodoc
class _$PlayListModalStateCopyWithImpl<$Res, $Val extends PlayListModalState>
    implements $PlayListModalStateCopyWith<$Res> {
  _$PlayListModalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayListModalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playLists = null,
    Object? selectedPlayList = freezed,
    Object? selectedVideo = freezed,
  }) {
    return _then(
      _value.copyWith(
            playLists:
                null == playLists
                    ? _value.playLists
                    : playLists // ignore: cast_nullable_to_non_nullable
                        as List<PlayList>,
            selectedPlayList:
                freezed == selectedPlayList
                    ? _value.selectedPlayList
                    : selectedPlayList // ignore: cast_nullable_to_non_nullable
                        as PlayList?,
            selectedVideo:
                freezed == selectedVideo
                    ? _value.selectedVideo
                    : selectedVideo // ignore: cast_nullable_to_non_nullable
                        as Video?,
          )
          as $Val,
    );
  }

  /// Create a copy of PlayListModalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayListCopyWith<$Res>? get selectedPlayList {
    if (_value.selectedPlayList == null) {
      return null;
    }

    return $PlayListCopyWith<$Res>(_value.selectedPlayList!, (value) {
      return _then(_value.copyWith(selectedPlayList: value) as $Val);
    });
  }

  /// Create a copy of PlayListModalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VideoCopyWith<$Res>? get selectedVideo {
    if (_value.selectedVideo == null) {
      return null;
    }

    return $VideoCopyWith<$Res>(_value.selectedVideo!, (value) {
      return _then(_value.copyWith(selectedVideo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayListModalStateImplCopyWith<$Res>
    implements $PlayListModalStateCopyWith<$Res> {
  factory _$$PlayListModalStateImplCopyWith(
    _$PlayListModalStateImpl value,
    $Res Function(_$PlayListModalStateImpl) then,
  ) = __$$PlayListModalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PlayList> playLists,
    PlayList? selectedPlayList,
    Video? selectedVideo,
  });

  @override
  $PlayListCopyWith<$Res>? get selectedPlayList;
  @override
  $VideoCopyWith<$Res>? get selectedVideo;
}

/// @nodoc
class __$$PlayListModalStateImplCopyWithImpl<$Res>
    extends _$PlayListModalStateCopyWithImpl<$Res, _$PlayListModalStateImpl>
    implements _$$PlayListModalStateImplCopyWith<$Res> {
  __$$PlayListModalStateImplCopyWithImpl(
    _$PlayListModalStateImpl _value,
    $Res Function(_$PlayListModalStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayListModalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playLists = null,
    Object? selectedPlayList = freezed,
    Object? selectedVideo = freezed,
  }) {
    return _then(
      _$PlayListModalStateImpl(
        playLists:
            null == playLists
                ? _value._playLists
                : playLists // ignore: cast_nullable_to_non_nullable
                    as List<PlayList>,
        selectedPlayList:
            freezed == selectedPlayList
                ? _value.selectedPlayList
                : selectedPlayList // ignore: cast_nullable_to_non_nullable
                    as PlayList?,
        selectedVideo:
            freezed == selectedVideo
                ? _value.selectedVideo
                : selectedVideo // ignore: cast_nullable_to_non_nullable
                    as Video?,
      ),
    );
  }
}

/// @nodoc

class _$PlayListModalStateImpl implements _PlayListModalState {
  const _$PlayListModalStateImpl({
    final List<PlayList> playLists = const [],
    this.selectedPlayList = null,
    this.selectedVideo = null,
  }) : _playLists = playLists;

  final List<PlayList> _playLists;
  @override
  @JsonKey()
  List<PlayList> get playLists {
    if (_playLists is EqualUnmodifiableListView) return _playLists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playLists);
  }

  @override
  @JsonKey()
  final PlayList? selectedPlayList;
  @override
  @JsonKey()
  final Video? selectedVideo;

  @override
  String toString() {
    return 'PlayListModalState(playLists: $playLists, selectedPlayList: $selectedPlayList, selectedVideo: $selectedVideo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayListModalStateImpl &&
            const DeepCollectionEquality().equals(
              other._playLists,
              _playLists,
            ) &&
            (identical(other.selectedPlayList, selectedPlayList) ||
                other.selectedPlayList == selectedPlayList) &&
            (identical(other.selectedVideo, selectedVideo) ||
                other.selectedVideo == selectedVideo));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_playLists),
    selectedPlayList,
    selectedVideo,
  );

  /// Create a copy of PlayListModalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayListModalStateImplCopyWith<_$PlayListModalStateImpl> get copyWith =>
      __$$PlayListModalStateImplCopyWithImpl<_$PlayListModalStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PlayListModalState implements PlayListModalState {
  const factory _PlayListModalState({
    final List<PlayList> playLists,
    final PlayList? selectedPlayList,
    final Video? selectedVideo,
  }) = _$PlayListModalStateImpl;

  @override
  List<PlayList> get playLists;
  @override
  PlayList? get selectedPlayList;
  @override
  Video? get selectedVideo;

  /// Create a copy of PlayListModalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayListModalStateImplCopyWith<_$PlayListModalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
