import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    required String id,
    required String name,
    required String description,
    required String time,
  }) = _Comment;
}