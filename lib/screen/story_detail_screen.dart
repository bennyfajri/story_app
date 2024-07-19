import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_data_generator/random_data_generator.dart';
import 'package:story_app/data/models/comment/comment.dart';
import 'package:story_app/data/models/story/story.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/widgets/cached_image.dart';
import 'package:story_app/widgets/comment_item.dart';
import 'package:story_app/widgets/error_empty_page.dart';
import 'package:story_app/widgets/person_header.dart';
import 'package:story_app/widgets/post_action.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:geocoding/geocoding.dart' as geo;

import '../my_app.dart';

class StoryDetailScreen extends StatefulWidget {
  final String storyId;

  const StoryDetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late GoogleMapController mapController;
  late Set<Marker> markers = {};
  geo.Placemark? placemark;
  String? address;
  bool isLocationHidden = false;
  final postLikes = Random().nextInt(10000).toString();

  @override
  Widget build(BuildContext context) {
    final storyProvider = context.watch<StoryProvider>();
    final detailStoryState = storyProvider.detailStoryState;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: detailStoryState.map(
        initial: (value) {
          return Container();
        },
        loading: (value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        loaded: (value) {
          final detailStory = value.data as Story?;
          String timeAgo = timeago.format(
            DateTime.parse(detailStory?.createdAt ?? ""),
          );

          List<Comment> comments = [];
          comments.add(
            Comment(
              id: detailStory?.id ?? "",
              name: detailStory?.name ?? "",
              description: detailStory?.description ?? "",
              time: timeago.format(
                DateTime.parse(detailStory?.createdAt ?? ""),
                locale: "en_short",
              ),
            ),
          );
          comments.addAll(
            List.generate(
              Random().nextInt(12),
              (index) => Comment(
                id: "$index",
                name: RandomData.generateRandomCarCompanyName(),
                description: RandomData.generateRandomCarName(),
                time: timeago.format(
                  DateTime.now().subtract(
                    Duration(
                      seconds: Random().nextInt(10000),
                    ),
                  ),
                  locale: "en_short",
                ),
              ),
            ),
          );

          return screenWidth > 600
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
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.separated(
                                      separatorBuilder: (_, __) =>
                                      const SizedBox(height: 8),
                                      itemBuilder: (context, index) {
                                        final comment = comments[index];
                                        return CommentItem(
                                          name: comment.name,
                                          description: comment.description,
                                          time: comment.time,
                                        );
                                      },
                                      itemCount: comments.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                    ),
                                    const PostAction(),
                                    const SizedBox(height: 4),
                                    Localizations.override(
                                      context: context,
                                      locale: const Locale("en"),
                                      child: Builder(
                                        builder: (context) => Text(
                                          "$postLikes ${appLocale.likes}",
                                          style: Theme.of(context).textTheme.titleSmall,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      timeAgo,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 8),
                                    if (detailStory?.lat != null)
                                      buildDetailMap(context, detailStory)
                                  ],
                                ),
                              ),
                            ),
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
                            const PostAction(),
                            const SizedBox(height: 8),
                            Localizations.override(
                              context: context,
                              locale: const Locale("en"),
                              child: Builder(
                                builder: (context) => Text(
                                  "$postLikes ${appLocale.likes}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              timeAgo,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final comment = comments[index];
                                return CommentItem(
                                  name: comment.name,
                                  description: comment.description,
                                  time: comment.time,
                                );
                              },
                              itemCount: comments.length,
                              shrinkWrap: true,
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      if (detailStory?.lat != null)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: buildDetailMap(context, detailStory),
                        )
                    ],
                  ),
                );
        },
        error: (value) {
          return ErrorEmptyPage(
            title: appLocale.oops,
            message: value.message,
            messageButton: appLocale.try_again,
            onPressed: () async {
              await storyProvider.getDetailStory(widget.storyId);
            },
          );
        },
      ),
    );
  }

  Widget buildDetailMap(BuildContext context, Story? detailStory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              appLocale.location,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  isLocationHidden = !isLocationHidden;
                });
              },
              icon: Icon(
                  isLocationHidden ? Icons.arrow_upward : Icons.arrow_downward),
            )
          ],
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isLocationHidden ? 0 : 200,
          child: Container(
            height: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  zoom: 18,
                  target: LatLng(
                    detailStory?.lat ?? 0,
                    detailStory?.lon ?? 0,
                  )),
              markers: markers,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) async {
                final latLng = LatLng(
                  detailStory?.lat ?? 0,
                  detailStory?.lon ?? 0,
                );
                final info = await geo.placemarkFromCoordinates(
                  latLng.latitude,
                  latLng.longitude,
                );
                final place = info[0];
                final street = place.street!;
                final storyAddress =
                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                setState(() {
                  placemark = place;
                  address = "$street, $storyAddress";
                });
                defineMarker(latLng, street, storyAddress);
              },
            ),
          ),
        ),
        Text(
          address ?? "",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
