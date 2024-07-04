import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/take_image_provider.dart';

import '../main.dart';
import '../provider/story_provider.dart';
import '../util/constant.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({
    super.key,
    required this.onSuccessUpload,
  });

  final VoidCallback onSuccessUpload;

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Story"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
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
                      child: const Text("Gallery"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _onCameraView,
                      child: const Text("Camera"),
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
                if (context.watch<StoryProvider>().isUploading)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final takeImageProvider =
                            context.read<TakeImageProvider>();
                        final storyProvider = context.read<StoryProvider>();
            
                        final imagePath = takeImageProvider.imagePath;
                        final imageFile = takeImageProvider.imageFile;
                        if (imagePath == null || imageFile == null) return;
                        final fileName = imageFile.name;
                        final bytes = await imageFile.readAsBytes();
                        final newBytes = await compressImage(bytes);
            
                        await storyProvider.addNewStory(
                            newBytes, fileName, descriptionController.text);
                        if (!storyProvider.isError) {
                          takeImageProvider.setImageFile(null);
                          takeImageProvider.setImagePath(null);
                          await storyProvider.getStories();
            
                          widget.onSuccessUpload();
                        } else {
                          if (context.mounted) {
                            showSnackbar(
                              context: context,
                              message: storyProvider.errorMessages,
                            );
                          }
                        }
                      }
                    },
                    child: Text(appLocale.add_story),
                  ),
              ],
            ),
          ),
        ),
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
