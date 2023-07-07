// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userID) getPost,
    required TResult Function(Notes note) deletePost,
    required TResult Function(String value) searchPost,
    required TResult Function() sortPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userID)? getPost,
    TResult? Function(Notes note)? deletePost,
    TResult? Function(String value)? searchPost,
    TResult? Function()? sortPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userID)? getPost,
    TResult Function(Notes note)? deletePost,
    TResult Function(String value)? searchPost,
    TResult Function()? sortPost,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetPost value) getPost,
    required TResult Function(_DeletePost value) deletePost,
    required TResult Function(_SearchPost value) searchPost,
    required TResult Function(_SortPost value) sortPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetPost value)? getPost,
    TResult? Function(_DeletePost value)? deletePost,
    TResult? Function(_SearchPost value)? searchPost,
    TResult? Function(_SortPost value)? sortPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetPost value)? getPost,
    TResult Function(_DeletePost value)? deletePost,
    TResult Function(_SearchPost value)? searchPost,
    TResult Function(_SortPost value)? sortPost,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotesEventCopyWith<$Res> {
  factory $NotesEventCopyWith(
          NotesEvent value, $Res Function(NotesEvent) then) =
      _$NotesEventCopyWithImpl<$Res, NotesEvent>;
}

/// @nodoc
class _$NotesEventCopyWithImpl<$Res, $Val extends NotesEvent>
    implements $NotesEventCopyWith<$Res> {
  _$NotesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_GetPostCopyWith<$Res> {
  factory _$$_GetPostCopyWith(
          _$_GetPost value, $Res Function(_$_GetPost) then) =
      __$$_GetPostCopyWithImpl<$Res>;
  @useResult
  $Res call({String userID});
}

/// @nodoc
class __$$_GetPostCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$_GetPost>
    implements _$$_GetPostCopyWith<$Res> {
  __$$_GetPostCopyWithImpl(_$_GetPost _value, $Res Function(_$_GetPost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
  }) {
    return _then(_$_GetPost(
      null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GetPost implements _GetPost {
  const _$_GetPost(this.userID);

  @override
  final String userID;

  @override
  String toString() {
    return 'NotesEvent.getPost(userID: $userID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetPost &&
            (identical(other.userID, userID) || other.userID == userID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetPostCopyWith<_$_GetPost> get copyWith =>
      __$$_GetPostCopyWithImpl<_$_GetPost>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userID) getPost,
    required TResult Function(Notes note) deletePost,
    required TResult Function(String value) searchPost,
    required TResult Function() sortPost,
  }) {
    return getPost(userID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userID)? getPost,
    TResult? Function(Notes note)? deletePost,
    TResult? Function(String value)? searchPost,
    TResult? Function()? sortPost,
  }) {
    return getPost?.call(userID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userID)? getPost,
    TResult Function(Notes note)? deletePost,
    TResult Function(String value)? searchPost,
    TResult Function()? sortPost,
    required TResult orElse(),
  }) {
    if (getPost != null) {
      return getPost(userID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetPost value) getPost,
    required TResult Function(_DeletePost value) deletePost,
    required TResult Function(_SearchPost value) searchPost,
    required TResult Function(_SortPost value) sortPost,
  }) {
    return getPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetPost value)? getPost,
    TResult? Function(_DeletePost value)? deletePost,
    TResult? Function(_SearchPost value)? searchPost,
    TResult? Function(_SortPost value)? sortPost,
  }) {
    return getPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetPost value)? getPost,
    TResult Function(_DeletePost value)? deletePost,
    TResult Function(_SearchPost value)? searchPost,
    TResult Function(_SortPost value)? sortPost,
    required TResult orElse(),
  }) {
    if (getPost != null) {
      return getPost(this);
    }
    return orElse();
  }
}

abstract class _GetPost implements NotesEvent {
  const factory _GetPost(final String userID) = _$_GetPost;

  String get userID;
  @JsonKey(ignore: true)
  _$$_GetPostCopyWith<_$_GetPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_DeletePostCopyWith<$Res> {
  factory _$$_DeletePostCopyWith(
          _$_DeletePost value, $Res Function(_$_DeletePost) then) =
      __$$_DeletePostCopyWithImpl<$Res>;
  @useResult
  $Res call({Notes note});
}

/// @nodoc
class __$$_DeletePostCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$_DeletePost>
    implements _$$_DeletePostCopyWith<$Res> {
  __$$_DeletePostCopyWithImpl(
      _$_DeletePost _value, $Res Function(_$_DeletePost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? note = null,
  }) {
    return _then(_$_DeletePost(
      null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as Notes,
    ));
  }
}

/// @nodoc

class _$_DeletePost implements _DeletePost {
  const _$_DeletePost(this.note);

  @override
  final Notes note;

  @override
  String toString() {
    return 'NotesEvent.deletePost(note: $note)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeletePost &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeletePostCopyWith<_$_DeletePost> get copyWith =>
      __$$_DeletePostCopyWithImpl<_$_DeletePost>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userID) getPost,
    required TResult Function(Notes note) deletePost,
    required TResult Function(String value) searchPost,
    required TResult Function() sortPost,
  }) {
    return deletePost(note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userID)? getPost,
    TResult? Function(Notes note)? deletePost,
    TResult? Function(String value)? searchPost,
    TResult? Function()? sortPost,
  }) {
    return deletePost?.call(note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userID)? getPost,
    TResult Function(Notes note)? deletePost,
    TResult Function(String value)? searchPost,
    TResult Function()? sortPost,
    required TResult orElse(),
  }) {
    if (deletePost != null) {
      return deletePost(note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetPost value) getPost,
    required TResult Function(_DeletePost value) deletePost,
    required TResult Function(_SearchPost value) searchPost,
    required TResult Function(_SortPost value) sortPost,
  }) {
    return deletePost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetPost value)? getPost,
    TResult? Function(_DeletePost value)? deletePost,
    TResult? Function(_SearchPost value)? searchPost,
    TResult? Function(_SortPost value)? sortPost,
  }) {
    return deletePost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetPost value)? getPost,
    TResult Function(_DeletePost value)? deletePost,
    TResult Function(_SearchPost value)? searchPost,
    TResult Function(_SortPost value)? sortPost,
    required TResult orElse(),
  }) {
    if (deletePost != null) {
      return deletePost(this);
    }
    return orElse();
  }
}

abstract class _DeletePost implements NotesEvent {
  const factory _DeletePost(final Notes note) = _$_DeletePost;

  Notes get note;
  @JsonKey(ignore: true)
  _$$_DeletePostCopyWith<_$_DeletePost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SearchPostCopyWith<$Res> {
  factory _$$_SearchPostCopyWith(
          _$_SearchPost value, $Res Function(_$_SearchPost) then) =
      __$$_SearchPostCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$_SearchPostCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$_SearchPost>
    implements _$$_SearchPostCopyWith<$Res> {
  __$$_SearchPostCopyWithImpl(
      _$_SearchPost _value, $Res Function(_$_SearchPost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$_SearchPost(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SearchPost implements _SearchPost {
  const _$_SearchPost(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'NotesEvent.searchPost(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchPost &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchPostCopyWith<_$_SearchPost> get copyWith =>
      __$$_SearchPostCopyWithImpl<_$_SearchPost>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userID) getPost,
    required TResult Function(Notes note) deletePost,
    required TResult Function(String value) searchPost,
    required TResult Function() sortPost,
  }) {
    return searchPost(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userID)? getPost,
    TResult? Function(Notes note)? deletePost,
    TResult? Function(String value)? searchPost,
    TResult? Function()? sortPost,
  }) {
    return searchPost?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userID)? getPost,
    TResult Function(Notes note)? deletePost,
    TResult Function(String value)? searchPost,
    TResult Function()? sortPost,
    required TResult orElse(),
  }) {
    if (searchPost != null) {
      return searchPost(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetPost value) getPost,
    required TResult Function(_DeletePost value) deletePost,
    required TResult Function(_SearchPost value) searchPost,
    required TResult Function(_SortPost value) sortPost,
  }) {
    return searchPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetPost value)? getPost,
    TResult? Function(_DeletePost value)? deletePost,
    TResult? Function(_SearchPost value)? searchPost,
    TResult? Function(_SortPost value)? sortPost,
  }) {
    return searchPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetPost value)? getPost,
    TResult Function(_DeletePost value)? deletePost,
    TResult Function(_SearchPost value)? searchPost,
    TResult Function(_SortPost value)? sortPost,
    required TResult orElse(),
  }) {
    if (searchPost != null) {
      return searchPost(this);
    }
    return orElse();
  }
}

abstract class _SearchPost implements NotesEvent {
  const factory _SearchPost(final String value) = _$_SearchPost;

  String get value;
  @JsonKey(ignore: true)
  _$$_SearchPostCopyWith<_$_SearchPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SortPostCopyWith<$Res> {
  factory _$$_SortPostCopyWith(
          _$_SortPost value, $Res Function(_$_SortPost) then) =
      __$$_SortPostCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SortPostCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$_SortPost>
    implements _$$_SortPostCopyWith<$Res> {
  __$$_SortPostCopyWithImpl(
      _$_SortPost _value, $Res Function(_$_SortPost) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SortPost implements _SortPost {
  const _$_SortPost();

  @override
  String toString() {
    return 'NotesEvent.sortPost()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SortPost);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userID) getPost,
    required TResult Function(Notes note) deletePost,
    required TResult Function(String value) searchPost,
    required TResult Function() sortPost,
  }) {
    return sortPost();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userID)? getPost,
    TResult? Function(Notes note)? deletePost,
    TResult? Function(String value)? searchPost,
    TResult? Function()? sortPost,
  }) {
    return sortPost?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userID)? getPost,
    TResult Function(Notes note)? deletePost,
    TResult Function(String value)? searchPost,
    TResult Function()? sortPost,
    required TResult orElse(),
  }) {
    if (sortPost != null) {
      return sortPost();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetPost value) getPost,
    required TResult Function(_DeletePost value) deletePost,
    required TResult Function(_SearchPost value) searchPost,
    required TResult Function(_SortPost value) sortPost,
  }) {
    return sortPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetPost value)? getPost,
    TResult? Function(_DeletePost value)? deletePost,
    TResult? Function(_SearchPost value)? searchPost,
    TResult? Function(_SortPost value)? sortPost,
  }) {
    return sortPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetPost value)? getPost,
    TResult Function(_DeletePost value)? deletePost,
    TResult Function(_SearchPost value)? searchPost,
    TResult Function(_SortPost value)? sortPost,
    required TResult orElse(),
  }) {
    if (sortPost != null) {
      return sortPost(this);
    }
    return orElse();
  }
}

abstract class _SortPost implements NotesEvent {
  const factory _SortPost() = _$_SortPost;
}

/// @nodoc
mixin _$NotesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Notes> notes) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Notes> notes)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Notes> notes)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotesStateCopyWith<$Res> {
  factory $NotesStateCopyWith(
          NotesState value, $Res Function(NotesState) then) =
      _$NotesStateCopyWithImpl<$Res, NotesState>;
}

/// @nodoc
class _$NotesStateCopyWithImpl<$Res, $Val extends NotesState>
    implements $NotesStateCopyWith<$Res> {
  _$NotesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$NotesStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'NotesState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Notes> notes) success,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Notes> notes)? success,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Notes> notes)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements NotesState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$NotesStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'NotesState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Notes> notes) success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Notes> notes)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Notes> notes)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements NotesState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Notes> notes});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res>
    extends _$NotesStateCopyWithImpl<$Res, _$_Success>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_$_Success(
      null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<Notes>,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(final List<Notes> notes) : _notes = notes;

  final List<Notes> _notes;
  @override
  List<Notes> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  String toString() {
    return 'NotesState.success(notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Success &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      __$$_SuccessCopyWithImpl<_$_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Notes> notes) success,
  }) {
    return success(notes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Notes> notes)? success,
  }) {
    return success?.call(notes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Notes> notes)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(notes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements NotesState {
  const factory _Success(final List<Notes> notes) = _$_Success;

  List<Notes> get notes;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<_$_Success> get copyWith =>
      throw _privateConstructorUsedError;
}
