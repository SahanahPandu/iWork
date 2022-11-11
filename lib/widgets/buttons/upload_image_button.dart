import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../modal_bottom_sheet/upload_image_options.dart';

class UploadImageButton extends StatefulWidget {
  final Function? getImageName;

  const UploadImageButton({Key? key, required this.getImageName})
      : super(key: key);

  @override
  State<UploadImageButton> createState() => _UploadImageButtonState();
}

class _UploadImageButtonState extends State<UploadImageButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: userRole == 100
              ? const EdgeInsets.symmetric(horizontal: 20)
              : null,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              showUploadImageOption(context, widget.getImageName);
            },
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => const Color(0xff0033c2)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff3269F8))),
            child: const Text(
              "Muat Naik Gambar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(
          height: userRole == 100 ? 10 : 5,
        ),
        const Center(
          child: Text(
            "Format jpeg & png",
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
