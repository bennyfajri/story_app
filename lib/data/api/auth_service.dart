import 'package:dio/dio.dart';
import 'package:story_app/data/models/login/login_request.dart';
import 'package:story_app/data/models/register/register_request.dart';
import '../../util/constant.dart';
import '../models/server_response/server_response.dart';

class AuthService {
  final Dio client;

  AuthService({required this.client});

  Future<ServerResponse> registerUser(RegisterRequest registerRequest) async {
    try {
      final response = await client.post(
        "${baseUrl}register",
        data: registerRequest.toJson(),
      );
      return ServerResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return ServerResponse.fromJson(e.response!.data);
      } else {
        throw Exception("Failed to register: ${e.message}");
      }
    }
  }

  Future<ServerResponse> loginUser(LoginRequest loginRequest) async {
    try {
      final response = await client.post(
        "${baseUrl}login",
        data: loginRequest.toJson(),
      );
      return ServerResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return ServerResponse.fromJson(e.response!.data);
      } else {
        throw Exception("Failed to register: ${e.message}");
      }
    }
  }
}
