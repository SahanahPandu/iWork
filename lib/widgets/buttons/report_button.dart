import 'package:flutter/material.dart';

class ReportButton extends StatefulWidget {
  const ReportButton({Key? key}) : super(key: key);

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.red,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: () {},
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 20,
      ),
      label: const Text(
        "Lapor Isu",
        style: TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}
