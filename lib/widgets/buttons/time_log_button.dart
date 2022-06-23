import 'package:flutter/material.dart';

//import files
import 'package:eswm/screens/time_log/time_log.dart';

class TimeLogButton extends StatefulWidget {
  const TimeLogButton({Key? key}) : super(key: key);

  @override
  State<TimeLogButton> createState() => _TimeLogButtonState();
}

class _TimeLogButtonState extends State<TimeLogButton> {
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
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.40,
      height: size.height * 0.05,
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
