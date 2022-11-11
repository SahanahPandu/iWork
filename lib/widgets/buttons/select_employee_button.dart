import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';

class SelectEmployeeButton extends StatefulWidget {
  final Function? onClick;

  const SelectEmployeeButton({Key? key, this.onClick}) : super(key: key);

  @override
  State<SelectEmployeeButton> createState() => _SelectEmployeeButtonState();
}

class _SelectEmployeeButtonState extends State<SelectEmployeeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(18), boxShadow: [
        BoxShadow(
            color: grey100,
            offset: const Offset(0, 0),
            blurRadius: 8,
            spreadRadius: 1)
      ]),
      child: ElevatedButton(
        onPressed: () {
          if (widget.onClick != null) {
            widget.onClick!();
          }
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            overlayColor: MaterialStateProperty.all(grey100),
            backgroundColor: MaterialStateProperty.all(white)),
        child: const Text(
          "Pilih Pekerja",
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff34A853),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
