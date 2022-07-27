import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage(ImageSource selectedSource) async {
  File? pickedImage;
  try {
    final image = await ImagePicker().pickImage(source: selectedSource);

    if (image == null) return;

    final imageTemporary = File(image.path);
    pickedImage = imageTemporary;
  } on PlatformException catch (e) {
    // ignore: avoid_print
    print('Failed to pick image: $e');
  }

  return pickedImage;
}
