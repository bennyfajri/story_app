import 'package:flutter/material.dart';
import 'package:story_app/widgets/cached_image.dart';
import 'package:story_app/widgets/person_header.dart';
import 'package:story_app/widgets/post_action.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    required this.id,
    required this.creatorName,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat,
    this.lon,
    required this.onItemClick,
  });

  final String id;
  final String creatorName;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double? lat;
  final double? lon;
  final Function(String) onItemClick;

  @override
  Widget build(BuildContext context) {
    String timeAgo = timeago.format(DateTime.parse(createdAt));
    return InkWell(
      onTap: () {
        onItemClick(id);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PersonHeader(creatorName: creatorName, isTrailing: true,),
          ),
          const SizedBox(height: 8),
          BuildCachedImage(photoUrl: photoUrl, id: id),
          const PostAction(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge,
                  children: [
                    TextSpan(
                        text:
                        "$creatorName "),
                    TextSpan(
                      text:
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              timeAgo,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
