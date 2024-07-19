import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class BuildCachedImage extends StatelessWidget {
  const BuildCachedImage({
    super.key,
    required this.photoUrl,
    required this.id,
    this.isLongImage = false,
  });

  final String photoUrl;
  final String id;
  final bool isLongImage;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: CachedNetworkImage(
        imageUrl: photoUrl,
        alignment: Alignment.center,
        width: double.infinity,
        fit: BoxFit.fitHeight,
        progressIndicatorBuilder: (context, url, progress) {
          return Container(
            color: Colors.grey,
            height: 300,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        },
        errorWidget: (context, error, stackTrace) => Container(
          height: 300,
          color: Colors.grey,
          child: const Center(
            child: Icon(
              Icons.error_outline,
              size: 26,
            ),
          ),
        ),
        cacheManager: CacheManager(
          Config(
            id,
            stalePeriod: const Duration(days: 3),
            maxNrOfCacheObjects: 10,
          ),
        ),
      ),
    );
  }
}
