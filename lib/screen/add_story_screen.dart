import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/add_location_provider.dart';
import 'package:story_app/provider/take_image_provider.dart';

import '../my_app.dart';
import '../provider/settings_provider.dart';
import '../provider/story_provider.dart';
import '../util/constant.dart';

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
    final settingProvider = context.watch<SettingsProvider>();
    final addLocationProvider = context.watch<AddLocationProvider>();

    final uploadState = context.watch<StoryProvider>().uploadStoryState;
    final isPremiumUser = settingProvider.isPremiumUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.add_story),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.watch<TakeImageProvider>().imagePath == null
                    ? const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      )
                    : _showImage(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _onGalleryView,
                      child: Text(appLocale.gallery),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _onCameraView,
                      child: Text(appLocale.camera),
                    ),
                  ],
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: appLocale.description_hint,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return appLocale.description_error_msg;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isPremiumUser ? widget.onAddLocation : null,
                    child: Text(
                      addLocationProvider.pickedAddress != null
                          ? appLocale.change_location
                          : appLocale.add_location,
                    ),
                  ),
                ),
                if (addLocationProvider.pickedAddress != null)
                  const SizedBox(height: 8),
                if (addLocationProvider.pickedAddress != null)
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Expanded(
                        child: Text(
                          addLocationProvider.pickedAddress!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                if (!isPremiumUser)
                  Text(
                    appLocale.only_premium_feature,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                const SizedBox(height: 36),
                uploadState.map(
                  initial: (value) {
                    return buildUploadButton(context);
                  },
                  loading: (value) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  loaded: (value) {
                    return buildUploadButton(context);
                  },
                  error: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showSnackbar(
                        context: context,
                        message: value.message,
                      );
                    });
                    return buildUploadButton(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildUploadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            final takeImageProvider = context.read<TakeImageProvider>();
            final locationProvider = context.read<AddLocationProvider>();
            final storyProvider = context.read<StoryProvider>();

            final imagePath = takeImageProvider.imagePath;
            final imageFile = takeImageProvider.imageFile;
            if (imagePath == null || imageFile == null) return;
            final fileName = imageFile.name;
            final bytes = await imageFile.readAsBytes();
            final newBytes = await compressImage(bytes);

            final addNewStory = await storyProvider.addNewStory(
              newBytes,
              fileName,
              descriptionController.text,
              locationProvider.pickedLatLng?.latitude,
              locationProvider.pickedLatLng?.longitude,
            );
            if (addNewStory) {
              takeImageProvider.setImageFile(null);
              takeImageProvider.setImagePath(null);
              locationProvider.setPickedAddress(null);
              locationProvider.setPickedLatLng(null);
              await storyProvider.getStories(true);

              widget.onSuccessUpload();
            }
          }
        },
        child: Text(appLocale.add_story),
      ),
    );
  }

  _onGalleryView() async {
    final provider = context.read<TakeImageProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

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
    }
  }

  Widget _showImage() {
    final imagePath = context.read<TakeImageProvider>().imagePath;

    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }
}
