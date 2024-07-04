import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/models/login/login_result.dart';

import '../story/story.dart';

part 'server_response.freezed.dart';
part 'server_response.g.dart';

@freezed
class ServerResponse with _$ServerResponse {
  factory ServerResponse({
    required bool error,
    required String message,
    LoginResult? loginResult,
    List<Story>? listStory,
    Story? story,
}) = _ServerResponse;

  factory ServerResponse.fromJson(Map<String, dynamic> json) => _$ServerResponseFromJson(json);
}