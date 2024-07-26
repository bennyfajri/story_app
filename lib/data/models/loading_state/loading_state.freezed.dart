// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loading_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DataState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataStateCopyWith<T, $Res> {
  factory $DataStateCopyWith(
          DataState<T> value, $Res Function(DataState<T>) then) =
      _$DataStateCopyWithImpl<T, $Res, DataState<T>>;
}

/// @nodoc
class _$DataStateCopyWithImpl<T, $Res, $Val extends DataState<T>>
    implements $DataStateCopyWith<T, $Res> {
  _$DataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DataStateLoadingImplCopyWith<T, $Res> {
  factory _$$DataStateLoadingImplCopyWith(_$DataStateLoadingImpl<T> value,
          $Res Function(_$DataStateLoadingImpl<T>) then) =
      __$$DataStateLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$DataStateLoadingImplCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res, _$DataStateLoadingImpl<T>>
    implements _$$DataStateLoadingImplCopyWith<T, $Res> {
  __$$DataStateLoadingImplCopyWithImpl(_$DataStateLoadingImpl<T> _value,
      $Res Function(_$DataStateLoadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DataStateLoadingImpl<T> implements DataStateLoading<T> {
  const _$DataStateLoadingImpl();

  @override
  String toString() {
    return 'DataState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataStateLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? loaded,
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
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DataStateLoading<T> implements DataState<T> {
  const factory DataStateLoading() = _$DataStateLoadingImpl<T>;
}

/// @nodoc
abstract class _$$DataStateLoadedImplCopyWith<T, $Res> {
  factory _$$DataStateLoadedImplCopyWith(_$DataStateLoadedImpl<T> value,
          $Res Function(_$DataStateLoadedImpl<T>) then) =
      __$$DataStateLoadedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$DataStateLoadedImplCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res, _$DataStateLoadedImpl<T>>
    implements _$$DataStateLoadedImplCopyWith<T, $Res> {
  __$$DataStateLoadedImplCopyWithImpl(_$DataStateLoadedImpl<T> _value,
      $Res Function(_$DataStateLoadedImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$DataStateLoadedImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$DataStateLoadedImpl<T> implements DataStateLoaded<T> {
  const _$DataStateLoadedImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'DataState<$T>.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataStateLoadedImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataStateLoadedImplCopyWith<T, _$DataStateLoadedImpl<T>> get copyWith =>
      __$$DataStateLoadedImplCopyWithImpl<T, _$DataStateLoadedImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T data) loaded,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T data)? loaded,
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
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class DataStateLoaded<T> implements DataState<T> {
  const factory DataStateLoaded(final T data) = _$DataStateLoadedImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$DataStateLoadedImplCopyWith<T, _$DataStateLoadedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
