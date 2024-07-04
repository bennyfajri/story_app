import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:story_app/main.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/widgets/cached_image.dart';
import 'package:story_app/widgets/error_empty_page.dart';
import 'package:story_app/widgets/person_header.dart';
import 'package:story_app/widgets/post_action.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryDetailScreen extends StatelessWidget {
  final String storyId;

  const StoryDetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    final storyProvider = context.watch<StoryProvider>();
    final detailStory = storyProvider.story;
    final screenWidth = MediaQuery.of(context).size.width;
    String timeAgo = timeago.format(
      DateTime.parse(detailStory?.createdAt ?? ""),
    );

    return Scaffold(
      body: storyProvider.isError
          ? ErrorEmptyPage(
              title: appLocale.oops,
              message: storyProvider.errorMessages,
              messageButton: appLocale.try_again,
              onPressed: () async {
                await storyProvider.getDetailStory(storyId);
              })
          : screenWidth > 600
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black87,
                        child: BuildCachedImage(
                          photoUrl: detailStory?.photoUrl ?? "",
                          id: detailStory?.id ?? "",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PersonHeader(
                              creatorName: detailStory?.name ?? "",
                              isTrailing: true,
                            ),
                            const Divider(),
                            const SizedBox(height: 4),
                            const SizedBox(height: 4),
                            Text(
                              detailStory?.description ?? "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              timeAgo,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 24),
                            const PostAction()
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      BuildCachedImage(
                        photoUrl: detailStory?.photoUrl ?? "",
                        id: detailStory?.id ?? "",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PersonHeader(
                              creatorName: detailStory?.name ?? "",
                              isTrailing: true,
                            ),
                            const Divider(),
                            const SizedBox(height: 4),
                            const SizedBox(height: 4),
                            Text(
                              detailStory?.description ?? "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              timeAgo,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 24),
                            const PostAction()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
