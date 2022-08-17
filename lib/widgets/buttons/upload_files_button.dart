// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../utils/file_picker.dart';

class UploadFilesButton extends StatefulWidget {
  String textLampiran;

  UploadFilesButton({Key? key, required this.textLampiran}) : super(key: key);

  @override
  State<UploadFilesButton> createState() => _UploadFilesButtonState();
}

class _UploadFilesButtonState extends State<UploadFilesButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            String getFileName = await FilePickerClass.getFilePathName();

            setState(() {
              widget.textLampiran = getFileName;
            });
          },
          icon: (widget.textLampiran != "")
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 28,
                )
              : const Icon(
                  Icons.cloud_upload,
                  size: 28,
                ),
          label: Text(
            (widget.textLampiran != "")
                ? widget.textLampiran
                : "Muat Naik Lampiran",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff3269F8),
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 5.0,
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
