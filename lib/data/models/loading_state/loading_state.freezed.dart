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
mixin _$LoadingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingStateCopyWith<$Res> {
  factory $LoadingStateCopyWith(
          LoadingState value, $Res Function(LoadingState) then) =
      _$LoadingStateCopyWithImpl<$Res, LoadingState>;
}

/// @nodoc
class _$LoadingStateCopyWithImpl<$Res, $Val extends LoadingState>
    implements $LoadingStateCopyWith<$Res> {
  _$LoadingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadingStateLoadingImplCopyWith<$Res> {
  factory _$$LoadingStateLoadingImplCopyWith(_$LoadingStateLoadingImpl value,
          $Res Function(_$LoadingStateLoadingImpl) then) =
      __$$LoadingStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStateLoadingImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateLoadingImpl>
    implements _$$LoadingStateLoadingImplCopyWith<$Res> {
  __$$LoadingStateLoadingImplCopyWithImpl(_$LoadingStateLoadingImpl _value,
      $Res Function(_$LoadingStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateLoadingImpl implements LoadingStateLoading {
  const _$LoadingStateLoadingImpl();

  @override
  String toString() {
    return 'LoadingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
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
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingStateLoading implements LoadingState {
  const factory LoadingStateLoading() = _$LoadingStateLoadingImpl;
}

/// @nodoc
abstract class _$$LoadingStateLoadedImplCopyWith<$Res> {
  factory _$$LoadingStateLoadedImplCopyWith(_$LoadingStateLoadedImpl value,
          $Res Function(_$LoadingStateLoadedImpl) then) =
      __$$LoadingStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$LoadingStateLoadedImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateLoadedImpl>
    implements _$$LoadingStateLoadedImplCopyWith<$Res> {
  __$$LoadingStateLoadedImplCopyWithImpl(_$LoadingStateLoadedImpl _value,
      $Res Function(_$LoadingStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$LoadingStateLoadedImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$LoadingStateLoadedImpl implements LoadingStateLoaded {
  const _$LoadingStateLoadedImpl([this.data]);

  @override
  final dynamic data;

  @override
  String toString() {
    return 'LoadingState.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateLoadedImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingStateLoadedImplCopyWith<_$LoadingStateLoadedImpl> get copyWith =>
      __$$LoadingStateLoadedImplCopyWithImpl<_$LoadingStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic data) loaded,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic data)? loaded,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic data)? loaded,
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
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadingStateLoaded implements LoadingState {
  const factory LoadingStateLoaded([final dynamic data]) =
      _$LoadingStateLoadedImpl;

  dynamic get data;
  @JsonKey(ignore: true)
  _$$LoadingStateLoadedImplCopyWith<_$LoadingStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
