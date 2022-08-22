// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:eswm/config/config.dart';
import 'package:eswm/utils/custom_icon.dart';

//import files
import 'package:eswm/screens/time_log/time_log.dart';
// import '../../config/dimen.dart';
// import '../../utils/device.dart';

class TimeLogButton extends StatefulWidget {
  Function getTimeLog;

  TimeLogButton({Key? key, required this.getTimeLog}) : super(key: key);

  @override
  State<TimeLogButton> createState() => _TimeLogButtonState();
}

class _TimeLogButtonState extends State<TimeLogButton> {
  //final Devices _device = Devices();

  Color buttonColor = const Color(0xff52A834);
  Color buttonTextColor = Colors.white;
  Color iconColor = Colors.white;
  String buttonText = "Masuk Kerja";

  changeButtonColor() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: TimeLog(
              btnText: buttonText,
              btnColor: buttonColor,
            ))).then((actionText) {
      widget.getTimeLog(actionText);
      if (actionText == "Masuk Kerja") {
        setState(() {
          buttonText = "Tamat Kerja";
          buttonColor = const Color(0xffE04141);
        });
      } else if (actionText == "Tamat Kerja") {
        setState(() {
          //disabled button
          buttonText = "Masuk Kerja";
          buttonColor = const Color(0xffD9D9D9);
          buttonTextColor = const Color(0xff969696);
          iconColor = const Color(0xff969696);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 46,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          padding: const EdgeInsets.all(13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          elevation: userRole == 200 ? 5.0 : 1,
        ),
        onPressed: () {
          if (buttonColor != const Color(0xffD9D9D9)) {
            changeButtonColor();
          }
        },
        icon: Icon(
          CustomIcon.timerOutline,
          color: iconColor,
          size: 15,
        ),
        label: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: userRole == 200 ? 15 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
