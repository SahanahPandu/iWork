import 'package:file_picker/file_picker.dart';

class FilePickerClass {
  static getFilePathName() async {
    String fileName = "";

    FilePickerResult? files = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (files != null) {
      PlatformFile file = files.files.first;

      fileName = file.name;
    }

    return fileName;
  }
}
