import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/image_gallery_provider.dart';
import 'package:story_app/provider/take_image_provider.dart';
import 'package:story_app/routes/router_delegate.dart';
import 'package:story_app/util/constant.dart';
import 'package:story_app/widgets/image_item_widget.dart';
import 'package:story_app/widgets/loading_widget.dart';

import '../my_app.dart';

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
  final scrollController = ScrollController();

  _onCameraView() async {
    final provider = context.read<TakeImageProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);

      /// go to add filter on images
    }
  }

  int findChildIndexBuilder({
    required String id,
    required List<AssetEntity> assets,
  }) {
    return assets.indexWhere((AssetEntity e) => e.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.go(MyRoute.home);
          },
        ),
        titleSpacing: 0,
        title: Text(appLocale.add_story),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Next"),
          )
        ],
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Consumer<TakeImageProvider>(
                builder: (context, takeImgProvider, child) {
                  if (takeImgProvider.imagePath != null) {
                    final imagePath = takeImgProvider.imagePath;
                    return Container(
                      color: Colors.black,
                      child: kIsWeb
                          ? Image.network(
                              imagePath.toString(),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagePath.toString()),
                              fit: BoxFit.cover,
                            ),
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
                          empty: (value) {
                            return const SliverToBoxAdapter(
                              child: Center(
                                child: Text('No images folder'),
                              ),
                            );
                          },
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
                    onPressed: _onCameraView,
                    icon: const Icon(Icons.camera_alt_outlined),
                  )
                ],
              ),
            ),
          ),
          Consumer<ImageGalleryProvider>(
            builder: (context, provider, child) {
              final imagesProvider =
                  context.watch<ImageGalleryProvider>().images;
              return imagesProvider.map(
                empty: (value) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('No images Found'),
                      ),
                    ),
                  );
                },
                loading: (value) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                loaded: (value) {
                  final images = value.data;
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Builder(
                        builder: (context) {
                          final image = images[index];
                          if (index == images.length - 1) {
                            provider.loadMore();
                            return loadWidget;
                          }
                          if (index > images.length) {
                            return const SizedBox.shrink();
                          }
                          return ImageItemWidget(
                            entity: image,
                            option: const ThumbnailOption(
                              size: ThumbnailSize.square(200),
                            ),
                            onTap: () async {
                              final imageFile = await image.file;
                              final xFile = await assetEntityToXFile(imageFile);
                              if (context.mounted) {
                                final takeImageProvider =
                                    Provider.of<TakeImageProvider>(
                                  context,
                                  listen: false,
                                );
                                takeImageProvider.setImageFile(xFile);
                                takeImageProvider.setImagePath(imageFile?.path);
                                scrollController.animateTo(0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              }
                            },
                          );
                        },
                      ),
                      childCount: images.length,
                      findChildIndexCallback: (Key? key) {
                        if (key is ValueKey<String>) {
                          return findChildIndexBuilder(
                            id: key.value,
                            assets: images,
                          );
                        }
                        return null;
                      },
                    ),
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
