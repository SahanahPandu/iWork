import 'package:flutter/material.dart';

import '../modal_bottom_sheet/upload_image_options.dart';

class ChangeImageButton extends StatefulWidget {
  final Function? getImageName;
  const ChangeImageButton({Key? key, this.getImageName}) : super(key: key);

  @override
  State<ChangeImageButton> createState() => _ChangeImageButtonState();
}

class _ChangeImageButtonState extends State<ChangeImageButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showUploadImageOption(context, widget.getImageName);
      },
      child: const Text(
        "Tukar Gambar",
        style: TextStyle(
          color: Color(0xff34A853),
          fontSize: 15,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
