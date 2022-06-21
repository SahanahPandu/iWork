import 'package:eswm/utils/responsive.dart';
import 'package:flutter/material.dart';

class TimeInButton extends StatefulWidget {
  const TimeInButton({Key? key}) : super(key: key);

  @override
  State<TimeInButton> createState() => _TimeInButtonState();
}

class _TimeInButtonState extends State<TimeInButton> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: screenWidth(context) * 0.40,
      height: screenHeight(context) * 0.05,
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
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const ECuti(),
          //     ));
        },
        icon: Icon(
          Icons.timer_outlined,
          color: Colors.grey.shade800,
          size: 20,
        ),
        label: Text(
          "Masuk Kerja",
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
