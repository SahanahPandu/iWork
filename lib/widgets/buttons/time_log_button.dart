import 'package:flutter/material.dart';

//import files
import 'package:eswm/screens/time_log/time_log.dart';
import '../../config/dimen.dart';
import '../../utils/device.dart';

class TimeLogButton extends StatefulWidget {
  const TimeLogButton({Key? key}) : super(key: key);

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
          builder: (context) =>
              TimeLog(btnText: buttonText, btnColor: buttonTextColor),
        )).then((actionText) {
      if (actionText == "Masuk Kerja") {
        setState(() {
          buttonText = "Tamat Kerja";
          buttonTextColor = Colors.red;
        });
      } else if (actionText == "Tamat Kerja") {
        setState(() {
          buttonText = "Masuk Kerja";
          buttonTextColor = Colors.green;
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
          elevation: 5.0,
        ),
        onPressed: () {
          changeButtonColor();
        },
        icon: Icon(
          Icons.timer_outlined,
          //color: Colors.grey.shade800,
          color: buttonTextColor,
          size: 20,
        ),
        label: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
