// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiStateInitial value) initial,
    required TResult Function(ApiStateLoading value) loading,
    required TResult Function(ApiStateLoaded value) loaded,
    required TResult Function(ApiStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiStateInitial value)? initial,
    TResult? Function(ApiStateLoading value)? loading,
    TResult? Function(ApiStateLoaded value)? loaded,
    TResult? Function(ApiStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiStateInitial value)? initial,
    TResult Function(ApiStateLoading value)? loading,
    TResult Function(ApiStateLoaded value)? loaded,
    TResult Function(ApiStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiStateCopyWith<$Res> {
  factory $ApiStateCopyWith(ApiState value, $Res Function(ApiState) then) =
      _$ApiStateCopyWithImpl<$Res, ApiState>;
}

/// @nodoc
class _$ApiStateCopyWithImpl<$Res, $Val extends ApiState>
    implements $ApiStateCopyWith<$Res> {
  _$ApiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApiStateInitialImplCopyWith<$Res> {
  factory _$$ApiStateInitialImplCopyWith(_$ApiStateInitialImpl value,
          $Res Function(_$ApiStateInitialImpl) then) =
      __$$ApiStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiStateInitialImplCopyWithImpl<$Res>
    extends _$ApiStateCopyWithImpl<$Res, _$ApiStateInitialImpl>
    implements _$$ApiStateInitialImplCopyWith<$Res> {
  __$$ApiStateInitialImplCopyWithImpl(
      _$ApiStateInitialImpl _value, $Res Function(_$ApiStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiStateInitialImpl implements ApiStateInitial {
  const _$ApiStateInitialImpl();

  @override
  String toString() {
    return 'ApiState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
    TResult Function(String message)? error,
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
    required TResult Function(ApiStateInitial value) initial,
    required TResult Function(ApiStateLoading value) loading,
    required TResult Function(ApiStateLoaded value) loaded,
    required TResult Function(ApiStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiStateInitial value)? initial,
    TResult? Function(ApiStateLoading value)? loading,
    TResult? Function(ApiStateLoaded value)? loaded,
    TResult? Function(ApiStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiStateInitial value)? initial,
    TResult Function(ApiStateLoading value)? loading,
    TResult Function(ApiStateLoaded value)? loaded,
    TResult Function(ApiStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ApiStateInitial implements ApiState {
  const factory ApiStateInitial() = _$ApiStateInitialImpl;
}

/// @nodoc
abstract class _$$ApiStateLoadingImplCopyWith<$Res> {
  factory _$$ApiStateLoadingImplCopyWith(_$ApiStateLoadingImpl value,
          $Res Function(_$ApiStateLoadingImpl) then) =
      __$$ApiStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApiStateLoadingImplCopyWithImpl<$Res>
    extends _$ApiStateCopyWithImpl<$Res, _$ApiStateLoadingImpl>
    implements _$$ApiStateLoadingImplCopyWith<$Res> {
  __$$ApiStateLoadingImplCopyWithImpl(
      _$ApiStateLoadingImpl _value, $Res Function(_$ApiStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiStateLoadingImpl implements ApiStateLoading {
  const _$ApiStateLoadingImpl();

  @override
  String toString() {
    return 'ApiState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
    TResult Function(String message)? error,
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
    required TResult Function(ApiStateInitial value) initial,
    required TResult Function(ApiStateLoading value) loading,
    required TResult Function(ApiStateLoaded value) loaded,
    required TResult Function(ApiStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiStateInitial value)? initial,
    TResult? Function(ApiStateLoading value)? loading,
    TResult? Function(ApiStateLoaded value)? loaded,
    TResult? Function(ApiStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiStateInitial value)? initial,
    TResult Function(ApiStateLoading value)? loading,
    TResult Function(ApiStateLoaded value)? loaded,
    TResult Function(ApiStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ApiStateLoading implements ApiState {
  const factory ApiStateLoading() = _$ApiStateLoadingImpl;
}

/// @nodoc
abstract class _$$ApiStateLoadedImplCopyWith<$Res> {
  factory _$$ApiStateLoadedImplCopyWith(_$ApiStateLoadedImpl value,
          $Res Function(_$ApiStateLoadedImpl) then) =
      __$$ApiStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$ApiStateLoadedImplCopyWithImpl<$Res>
    extends _$ApiStateCopyWithImpl<$Res, _$ApiStateLoadedImpl>
    implements _$$ApiStateLoadedImplCopyWith<$Res> {
  __$$ApiStateLoadedImplCopyWithImpl(
      _$ApiStateLoadedImpl _value, $Res Function(_$ApiStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ApiStateLoadedImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$ApiStateLoadedImpl implements ApiStateLoaded {
  const _$ApiStateLoadedImpl(this.data);

  @override
  final dynamic data;

  @override
  String toString() {
    return 'ApiState.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiStateLoadedImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiStateLoadedImplCopyWith<_$ApiStateLoadedImpl> get copyWith =>
      __$$ApiStateLoadedImplCopyWithImpl<_$ApiStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiStateInitial value) initial,
    required TResult Function(ApiStateLoading value) loading,
    required TResult Function(ApiStateLoaded value) loaded,
    required TResult Function(ApiStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiStateInitial value)? initial,
    TResult? Function(ApiStateLoading value)? loading,
    TResult? Function(ApiStateLoaded value)? loaded,
    TResult? Function(ApiStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiStateInitial value)? initial,
    TResult Function(ApiStateLoading value)? loading,
    TResult Function(ApiStateLoaded value)? loaded,
    TResult Function(ApiStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ApiStateLoaded implements ApiState {
  const factory ApiStateLoaded(final dynamic data) = _$ApiStateLoadedImpl;

  dynamic get data;
  @JsonKey(ignore: true)
  _$$ApiStateLoadedImplCopyWith<_$ApiStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiStateErrorImplCopyWith<$Res> {
  factory _$$ApiStateErrorImplCopyWith(
          _$ApiStateErrorImpl value, $Res Function(_$ApiStateErrorImpl) then) =
      __$$ApiStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ApiStateErrorImplCopyWithImpl<$Res>
    extends _$ApiStateCopyWithImpl<$Res, _$ApiStateErrorImpl>
    implements _$$ApiStateErrorImplCopyWith<$Res> {
  __$$ApiStateErrorImplCopyWithImpl(
      _$ApiStateErrorImpl _value, $Res Function(_$ApiStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ApiStateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ApiStateErrorImpl implements ApiStateError {
  const _$ApiStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ApiState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiStateErrorImplCopyWith<_$ApiStateErrorImpl> get copyWith =>
      __$$ApiStateErrorImplCopyWithImpl<_$ApiStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiStateInitial value) initial,
    required TResult Function(ApiStateLoading value) loading,
    required TResult Function(ApiStateLoaded value) loaded,
    required TResult Function(ApiStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiStateInitial value)? initial,
    TResult? Function(ApiStateLoading value)? loading,
    TResult? Function(ApiStateLoaded value)? loaded,
    TResult? Function(ApiStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiStateInitial value)? initial,
    TResult Function(ApiStateLoading value)? loading,
    TResult Function(ApiStateLoaded value)? loaded,
    TResult Function(ApiStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ApiStateError implements ApiState {
  const factory ApiStateError(final String message) = _$ApiStateErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ApiStateErrorImplCopyWith<_$ApiStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
