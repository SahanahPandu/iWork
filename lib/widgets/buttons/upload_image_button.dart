// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../modal_bottom_sheet/upload_image_options.dart';

class UploadImageButton extends StatefulWidget {
  Function? getImageName;
  UploadImageButton({Key? key, required this.getImageName}) : super(key: key);

  @override
  State<UploadImageButton> createState() => _UploadImageButtonState();
}

class _UploadImageButtonState extends State<UploadImageButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showUploadImageOption(context, widget.getImageName);
          },
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff3269F8),
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 5.0,
          ),
          icon: const Icon(
            Icons.cloud_upload,
            size: 28,
          ),
          label: const Text(
            "Muat Naik Lampiran",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Center(
          child: Text(
            "Format fail .jpeg & .png sahaja",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xff969696),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
