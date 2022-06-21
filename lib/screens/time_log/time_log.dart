import 'package:eswm/widgets/buttons/time_log_ripple_button.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/palette.dart';

class TimeLog extends StatefulWidget {
  final String btnText;
  final Color btnColor;

  const TimeLog({Key? key, required this.btnText, required this.btnColor})
      : super(key: key);

  @override
  State<TimeLog> createState() => _TimeLogState();
}

class _TimeLogState extends State<TimeLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        elevation: 4,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey.shade900,
          ),
        ),
        title: Center(
          child: Text(
            "Log Masa",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.history,
              color: Colors.grey.shade800,
              size: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: [
              Text(
                "Jumaat . 20 May",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "7:05:00",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(45),
                child: TimeLogRippleButton(
                    btnText: widget.btnText, btnColor: widget.btnColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
