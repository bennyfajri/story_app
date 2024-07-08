import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/models/story/story.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/widgets/cached_image.dart';
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
                        child: SingleChildScrollView(
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
                              const PostAction(),
                              const SizedBox(height: 16),
                              if (detailStory?.lat != null)
                                buildDetailMap(context, detailStory)
                            ],
                          ),
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
                          ],
                        ),
                      ),
                      const PostAction(),
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
        Text(
          appLocale.location,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
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
