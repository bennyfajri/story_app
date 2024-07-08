import 'package:dio/dio.dart';
import 'package:story_app/util/constant.dart';

import '../models/server_response/server_response.dart';

class StoryService {
  final Dio client;

  StoryService({required this.client});

  Future<ServerResponse> addNewStory({
    required String desc,
    required List<int> bytes,
    required fileName,
    required String token,
    double? lat,
    double? lng,
  }) async {
    final multipartFile = MultipartFile.fromBytes(
      bytes,
      filename: fileName,
    );
    final mapData = lat != null || lng != null
        ? {
            "description": desc,
            "photo": multipartFile,
            "lat": lat,
            "lon": lng,
          }
        : {
            "description": desc,
            "photo": multipartFile,
          };
    final formData = FormData.fromMap(mapData);

    try {
      final response = await client.post(
        "${baseUrl}stories",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token",
          },
        ),
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

  Future<ServerResponse> getStories({
    required String token,
    int? page = 1,
    int? size = 10,
    String? location,
  }) async {
    try {
      final response = await client.get(
        "${baseUrl}stories",
        queryParameters: {
          "page": page,
          "size": size,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
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

  Future<ServerResponse> getDetailStories({
    required String id,
    required String token,
    String? location,
  }) async {
    try {
      final response = await client.get(
        "${baseUrl}stories/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
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
