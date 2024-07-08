// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flavor_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FlavorConfig {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function() paid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function()? paid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function()? paid,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FlavorConfigFree value) free,
    required TResult Function(FlavorConfigPaid value) paid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FlavorConfigFree value)? free,
    TResult? Function(FlavorConfigPaid value)? paid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FlavorConfigFree value)? free,
    TResult Function(FlavorConfigPaid value)? paid,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlavorConfigCopyWith<$Res> {
  factory $FlavorConfigCopyWith(
          FlavorConfig value, $Res Function(FlavorConfig) then) =
      _$FlavorConfigCopyWithImpl<$Res, FlavorConfig>;
}

/// @nodoc
class _$FlavorConfigCopyWithImpl<$Res, $Val extends FlavorConfig>
    implements $FlavorConfigCopyWith<$Res> {
  _$FlavorConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FlavorConfigFreeImplCopyWith<$Res> {
  factory _$$FlavorConfigFreeImplCopyWith(_$FlavorConfigFreeImpl value,
          $Res Function(_$FlavorConfigFreeImpl) then) =
      __$$FlavorConfigFreeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FlavorConfigFreeImplCopyWithImpl<$Res>
    extends _$FlavorConfigCopyWithImpl<$Res, _$FlavorConfigFreeImpl>
    implements _$$FlavorConfigFreeImplCopyWith<$Res> {
  __$$FlavorConfigFreeImplCopyWithImpl(_$FlavorConfigFreeImpl _value,
      $Res Function(_$FlavorConfigFreeImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FlavorConfigFreeImpl implements FlavorConfigFree {
  const _$FlavorConfigFreeImpl();

  @override
  String toString() {
    return 'FlavorConfig.free()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FlavorConfigFreeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function() paid,
  }) {
    return free();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function()? paid,
  }) {
    return free?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function()? paid,
    required TResult orElse(),
  }) {
    if (free != null) {
      return free();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FlavorConfigFree value) free,
    required TResult Function(FlavorConfigPaid value) paid,
  }) {
    return free(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FlavorConfigFree value)? free,
    TResult? Function(FlavorConfigPaid value)? paid,
  }) {
    return free?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FlavorConfigFree value)? free,
    TResult Function(FlavorConfigPaid value)? paid,
    required TResult orElse(),
  }) {
    if (free != null) {
      return free(this);
    }
    return orElse();
  }
}

abstract class FlavorConfigFree implements FlavorConfig {
  const factory FlavorConfigFree() = _$FlavorConfigFreeImpl;
}

/// @nodoc
abstract class _$$FlavorConfigPaidImplCopyWith<$Res> {
  factory _$$FlavorConfigPaidImplCopyWith(_$FlavorConfigPaidImpl value,
          $Res Function(_$FlavorConfigPaidImpl) then) =
      __$$FlavorConfigPaidImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FlavorConfigPaidImplCopyWithImpl<$Res>
    extends _$FlavorConfigCopyWithImpl<$Res, _$FlavorConfigPaidImpl>
    implements _$$FlavorConfigPaidImplCopyWith<$Res> {
  __$$FlavorConfigPaidImplCopyWithImpl(_$FlavorConfigPaidImpl _value,
      $Res Function(_$FlavorConfigPaidImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FlavorConfigPaidImpl implements FlavorConfigPaid {
  const _$FlavorConfigPaidImpl();

  @override
  String toString() {
    return 'FlavorConfig.paid()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FlavorConfigPaidImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function() paid,
  }) {
    return paid();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function()? paid,
  }) {
    return paid?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function()? paid,
    required TResult orElse(),
  }) {
    if (paid != null) {
      return paid();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FlavorConfigFree value) free,
    required TResult Function(FlavorConfigPaid value) paid,
  }) {
    return paid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FlavorConfigFree value)? free,
    TResult? Function(FlavorConfigPaid value)? paid,
  }) {
    return paid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FlavorConfigFree value)? free,
    TResult Function(FlavorConfigPaid value)? paid,
    required TResult orElse(),
  }) {
    if (paid != null) {
      return paid(this);
    }
    return orElse();
  }
}

abstract class FlavorConfigPaid implements FlavorConfig {
  const factory FlavorConfigPaid() = _$FlavorConfigPaidImpl;
}
