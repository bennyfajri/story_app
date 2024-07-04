import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

const baseUrl = "https://story-api.dicoding.dev/v1/";

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void showSnackbar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<List<int>> compressImage(List<int> bytes) async {
  int imageLength = bytes.length;
  if (imageLength < 1000000) return bytes;
  final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
  int compressQuality = 100;
  int length = imageLength;
  List<int> newByte = [];
  do {
    compressQuality -= 10;
    newByte = img.encodeJpg(
      image,
      quality: compressQuality,
    );
    length = newByte.length;
  } while (length > 1000000);
  return newByte;
}

Future<List<int>> resizeImage(List<int> bytes) async {
  int imageLength = bytes.length;
  if (imageLength < 1000000) return bytes;

  final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
  bool isWidthMoreTaller = image.width > image.height;
  int imageTall = isWidthMoreTaller ? image.width : image.height;
  double compressTall = 1;
  int length = imageLength;
  List<int> newByte = bytes;

  do {
    compressTall -= 0.1;

    final newImage = img.copyResize(
      image,
      width: isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
      height: !isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
    );

    length = newImage.length;
    if (length < 1000000) {
      newByte = img.encodeJpg(newImage);
    }
  } while (length > 1000000);

  return newByte;
}
