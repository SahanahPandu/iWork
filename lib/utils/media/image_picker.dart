import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage(ImageSource selectedSource) async {
  File? pickedImage;
  try {
    final image = await ImagePicker().pickImage(
      source: selectedSource,
      //imageQuality: 50, //reduce the quality so that the size will reduce
    );

    if (image == null) return;

    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: 50, percentage: 50);

    // final imageTemporary = File(image.path);
    pickedImage = compressedFile;
  } on PlatformException catch (e) {
    // ignore: avoid_print
    print('Failed to pick image: $e');
  }

  return pickedImage;
}
