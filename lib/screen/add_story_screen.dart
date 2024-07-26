import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/image_gallery_provider.dart';
import 'package:story_app/provider/take_image_provider.dart';
import 'package:story_app/widgets/image_item_widget.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({
    super.key,
    required this.onSuccessUpload,
    required this.onAddLocation,
  });

  final VoidCallback onSuccessUpload;
  final VoidCallback onAddLocation;

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            expandedHeight: size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: Consumer<TakeImageProvider>(
                builder: (context, takeImgProvider, child) {
                  if (takeImgProvider.imagePath != null) {
                    final imagePath = takeImgProvider.imagePath;
                    return kIsWeb
                        ? Image.network(
                            imagePath.toString(),
                            fit: BoxFit.fitHeight,
                          )
                        : Image.file(
                            File(imagePath.toString()),
                            fit: BoxFit.fitHeight,
                          );
                  } else {
                    return Container(
                      color: Colors.grey,
                    );
                  }
                },
              ),
            ),
            bottom: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: Consumer<ImageGalleryProvider>(
                      builder: (context, provider, child) {
                        return provider.paths.map(
                          loading: (value) {
                            return const SizedBox.shrink();
                          },
                          loaded: (value) {
                            final paths = value.data;
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<AssetPathEntity>(
                                isExpanded: true,
                                elevation: 16,
                                value: provider.filterPath ?? paths.firstOrNull,
                                items: paths
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: provider.setFilterPath,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined),
                  )
                ],
              ),
            ),
          ),
          Consumer<ImageGalleryProvider>(
            builder: (context, provider, child) {
              return provider.images.map(
                loading: (value) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                loaded: (value) {
                  final images = value.data;
                  return SliverGrid.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      return ImageItemWidget(
                        entity: image,
                        option: const ThumbnailOption(
                          size: ThumbnailSize.square(200),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
