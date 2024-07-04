// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServerResponse _$ServerResponseFromJson(Map<String, dynamic> json) {
  return _ServerResponse.fromJson(json);
}

/// @nodoc
mixin _$ServerResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  LoginResult? get loginResult => throw _privateConstructorUsedError;
  List<Story>? get listStory => throw _privateConstructorUsedError;
  Story? get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServerResponseCopyWith<ServerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerResponseCopyWith<$Res> {
  factory $ServerResponseCopyWith(
          ServerResponse value, $Res Function(ServerResponse) then) =
      _$ServerResponseCopyWithImpl<$Res, ServerResponse>;
  @useResult
  $Res call(
      {bool error,
      String message,
      LoginResult? loginResult,
      List<Story>? listStory,
      Story? story});

  $LoginResultCopyWith<$Res>? get loginResult;
  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class _$ServerResponseCopyWithImpl<$Res, $Val extends ServerResponse>
    implements $ServerResponseCopyWith<$Res> {
  _$ServerResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? loginResult = freezed,
    Object? listStory = freezed,
    Object? story = freezed,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      loginResult: freezed == loginResult
          ? _value.loginResult
          : loginResult // ignore: cast_nullable_to_non_nullable
              as LoginResult?,
      listStory: freezed == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<Story>?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LoginResultCopyWith<$Res>? get loginResult {
    if (_value.loginResult == null) {
      return null;
    }

    return $LoginResultCopyWith<$Res>(_value.loginResult!, (value) {
      return _then(_value.copyWith(loginResult: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryCopyWith<$Res>? get story {
    if (_value.story == null) {
      return null;
    }

    return $StoryCopyWith<$Res>(_value.story!, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServerResponseImplCopyWith<$Res>
    implements $ServerResponseCopyWith<$Res> {
  factory _$$ServerResponseImplCopyWith(_$ServerResponseImpl value,
          $Res Function(_$ServerResponseImpl) then) =
      __$$ServerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool error,
      String message,
      LoginResult? loginResult,
      List<Story>? listStory,
      Story? story});

  @override
  $LoginResultCopyWith<$Res>? get loginResult;
  @override
  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class __$$ServerResponseImplCopyWithImpl<$Res>
    extends _$ServerResponseCopyWithImpl<$Res, _$ServerResponseImpl>
    implements _$$ServerResponseImplCopyWith<$Res> {
  __$$ServerResponseImplCopyWithImpl(
      _$ServerResponseImpl _value, $Res Function(_$ServerResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? loginResult = freezed,
    Object? listStory = freezed,
    Object? story = freezed,
  }) {
    return _then(_$ServerResponseImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      loginResult: freezed == loginResult
          ? _value.loginResult
          : loginResult // ignore: cast_nullable_to_non_nullable
              as LoginResult?,
      listStory: freezed == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<Story>?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerResponseImpl implements _ServerResponse {
  _$ServerResponseImpl(
      {required this.error,
      required this.message,
      this.loginResult,
      final List<Story>? listStory,
      this.story})
      : _listStory = listStory;

  factory _$ServerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  final LoginResult? loginResult;
  final List<Story>? _listStory;
  @override
  List<Story>? get listStory {
    final value = _listStory;
    if (value == null) return null;
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Story? story;

  @override
  String toString() {
    return 'ServerResponse(error: $error, message: $message, loginResult: $loginResult, listStory: $listStory, story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.loginResult, loginResult) ||
                other.loginResult == loginResult) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, loginResult,
      const DeepCollectionEquality().hash(_listStory), story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerResponseImplCopyWith<_$ServerResponseImpl> get copyWith =>
      __$$ServerResponseImplCopyWithImpl<_$ServerResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerResponseImplToJson(
      this,
    );
  }
}

abstract class _ServerResponse implements ServerResponse {
  factory _ServerResponse(
      {required final bool error,
      required final String message,
      final LoginResult? loginResult,
      final List<Story>? listStory,
      final Story? story}) = _$ServerResponseImpl;

  factory _ServerResponse.fromJson(Map<String, dynamic> json) =
      _$ServerResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  LoginResult? get loginResult;
  @override
  List<Story>? get listStory;
  @override
  Story? get story;
  @override
  @JsonKey(ignore: true)
  _$$ServerResponseImplCopyWith<_$ServerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
