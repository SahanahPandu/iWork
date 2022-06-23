// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

//import files
import "package:eswm/widgets/alert/alert_dialog.dart";

class TimeLogRippleButton extends StatefulWidget {
  late String btnText;
  late Color btnColor;

  TimeLogRippleButton({Key? key, required this.btnText, required this.btnColor})
      : super(key: key);

  @override
  State<TimeLogRippleButton> createState() => _TimeLogRippleButtonState();
}

class _TimeLogRippleButtonState extends State<TimeLogRippleButton> {
  @override
  Widget build(BuildContext context) {
    return RippleAnimation(
      delay: const Duration(milliseconds: 100),
      //duration: const Duration(milliseconds: 2000),
      repeat: true,
      color: widget.btnColor,
      minRadius: 40,
      ripplesCount: 15,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showAlertDialog(
                    context,
                    "Pengesahan",
                    "Adakah anda pasti untuk masuk kerja sekarang?",
                    "Batal",
                    widget.btnText);
              }).then((actionText) {
            if (actionText == "Masuk Kerja" || actionText == "Tamat Kerja") {
              Navigator.pop(context, actionText);
            }
          });
        },
        child: Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
            color: widget.btnColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              widget.btnText,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
