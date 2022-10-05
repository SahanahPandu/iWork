import 'package:flutter/material.dart';

class SelectEmployeeButton extends StatefulWidget {
  final Function? onClick;

  const SelectEmployeeButton({Key? key, this.onClick}) : super(key: key);

  @override
  State<SelectEmployeeButton> createState() => _SelectEmployeeButtonState();
}

class _SelectEmployeeButtonState extends State<SelectEmployeeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.onClick != null) {
          widget.onClick!();
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 5,
        shadowColor: Colors.white,
      ),
      child: const Text(
        "Pilih Pekerja",
        style: TextStyle(
          fontSize: 13,
          color: Color(0xff34A853),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
