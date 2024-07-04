import 'package:freezed_annotation/freezed_annotation.dart';


part 'story.freezed.dart';
part 'story.g.dart';


@freezed
class Story with _$Story {
  factory Story({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required String createdAt,
    required double? lat,
    required double? lon,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}