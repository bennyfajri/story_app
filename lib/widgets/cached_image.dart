import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class BuildCachedImage extends StatelessWidget {
  const BuildCachedImage({
    super.key,
    required this.photoUrl,
    required this.id,
  });

  final String photoUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photoUrl,
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
      fit: BoxFit.contain,
      errorWidget: (context, error, stackTrace) => Container(
        color: Colors.grey,
        child: const Icon(
          Icons.error_outline,
        ),
      ),
      cacheManager: CacheManager(
        Config(
          id,
          stalePeriod: const Duration(days: 3),
          maxNrOfCacheObjects: 10,
        ),
      ),
    );
  }
}
