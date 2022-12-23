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

      String? compressedFile;
      if (file.extension == "pdf") {
        //not compressed for now
        compressedFile = file.path;
      } else {
        var getCompressedFile = await FlutterNativeImage.compressImage(
            file.path!,
            quality: 50,
            percentage: 50);
        compressedFile = getCompressedFile.path;
      }

      fileName = file.name;

      updateLampiran(fileName, compressedFile);
    }

    return fileName;
  }
}
