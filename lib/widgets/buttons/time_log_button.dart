// ignore_for_file: must_be_immutable

import 'package:eswm/config/config.dart';
import 'package:eswm/utils/custom_icon.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/screens/time_log/time_log.dart';
import '../../config/dimen.dart';
import '../../utils/device.dart';

class TimeLogButton extends StatefulWidget {
  Function getTimeLog;

  TimeLogButton({Key? key, required this.getTimeLog}) : super(key: key);

  @override
  State<TimeLogButton> createState() => _TimeLogButtonState();
}

class _TimeLogButtonState extends State<TimeLogButton> {
  final Devices _device = Devices();

  Color buttonTextColor = Colors.green;
  String buttonText = "Masuk Kerja";

  changeButtonColor() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimeLog(
            btnText: buttonText,
            btnColor: buttonTextColor,
          ),
        )).then((actionText) {
      widget.getTimeLog(actionText);
      if (actionText == "Masuk Kerja") {
        setState(() {
          buttonText = "Tamat Kerja";
          buttonTextColor = Colors.red;
        });
      } else if (actionText == "Tamat Kerja") {
        setState(() {
          buttonText = "Masuk Kerja";
          buttonTextColor = Colors.grey;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _device.screenWidth(context) * (buttonWidth(context)),
      height: _device.screenHeight(context) * (buttonHeight(context)),
      //color: Colors.white,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: userRole == 200? 5.0 : 1,
        ),
        onPressed: () {
          if (buttonTextColor != Colors.grey) {
            changeButtonColor();
          }
        },
        icon: Icon(
          CustomIcon.timerOutline,
          //color: Colors.grey.shade800,
          color: buttonTextColor,
          size: 20,
        ),
        label: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: userRole == 200? 17 : 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
