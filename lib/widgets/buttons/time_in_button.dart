import 'package:flutter/material.dart';

class TimeInButton extends StatefulWidget {
  const TimeInButton({Key? key}) : super(key: key);

  @override
  State<TimeInButton> createState() => _TimeInButtonState();
}

class _TimeInButtonState extends State<TimeInButton> {
  Color buttonTextColor = Colors.green;
  String buttonText = "Masuk Kerja";

  changeButtonColor() {
    setState(() {
      buttonTextColor = Colors.red;
      buttonText = "Tamat Kerja";
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
