import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class FilePickerClass {
  static getFilePathName(updateLampiran) async {
    String fileName = "";

    FilePickerResult? files = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (files != null) {
      PlatformFile file = files.files.first;

      File compressedFile = await FlutterNativeImage.compressImage(file.path!,
          quality: 50, percentage: 50);

      fileName = file.name;

      updateLampiran(fileName, compressedFile.path);
    }

    return fileName;
  }
}
