import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';


part 'login_result.freezed.dart';
part 'login_result.g.dart';

@freezed
class LoginResult with _$LoginResult {
  const LoginResult._();

  factory LoginResult({
    required String userId,
    required String name,
    required String token,
}) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);

  String toJsonString() => jsonEncode(toJson());

  factory LoginResult.fromJsonDecode(String json) => LoginResult.fromJson(jsonDecode(json));
}