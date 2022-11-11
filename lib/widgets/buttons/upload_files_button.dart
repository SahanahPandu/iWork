// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../utils/media/file_picker.dart';

class UploadFilesButton extends StatefulWidget {
  String lampiranName;
  Function(String)? updateLampiran;

  UploadFilesButton({
    Key? key,
    required this.lampiranName,
    this.updateLampiran,
  }) : super(key: key);

  @override
  State<UploadFilesButton> createState() => _UploadFilesButtonState();
}

class _UploadFilesButtonState extends State<UploadFilesButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 42,
          child: ElevatedButton(
            onPressed: () async {
              String getFileName = await FilePickerClass.getFilePathName();
              widget.updateLampiran!(getFileName);
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
            // icon: (widget.textLampiran != "")
            //     ? const Icon(
            //         Icons.check_circle,
            //         color: Colors.green,
            //         size: 28,
            //       )
            //     : const Icon(
            //         Icons.cloud_upload,
            //         size: 28,
            //       ),
            child: Text(
              (widget.lampiranName != "")
                  ? widget.lampiranName
                  : "Muat Naik Lampiran",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Center(
          child: Text(
            "Format .jpeg , .png & .pdf sahaja",
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
