import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import files
import '../../utils/device/sizes.dart';
import '../../utils/media/image_picker.dart';

Future<dynamic>? showUploadImageOption(
    BuildContext context, Function? getImageName) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (builder) {
        return SizedBox(
          height: Sizes().screenHeight(context) * 0.2,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.camera).then((imageFile) {
                      if (imageFile != null) {
                        Navigator.pop(context, imageFile);
                        getImageName!(imageFile);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 120,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 40,
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.gallery).then((imageFile) {
                      if (imageFile != null) {
                        Navigator.pop(context, imageFile);
                        getImageName!(imageFile);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 120,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: 40,
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
  return null;
}
