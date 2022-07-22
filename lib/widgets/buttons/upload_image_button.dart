import 'package:flutter/material.dart';

class UploadImageButton extends StatefulWidget {
  const UploadImageButton({Key? key}) : super(key: key);

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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade800,
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
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "*Maksimum 500kb.Format fail .jpeg & .png sahaja",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
