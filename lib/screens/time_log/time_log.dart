// ignore_for_file: must_be_immutable

import 'package:eswm/widgets/buttons/time_log_ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import 'package:eswm/config/palette.dart';

import '../../utils/custom_icon.dart';

class TimeLog extends StatefulWidget {
  final String btnText;
  final Color btnColor;

  const TimeLog({
    Key? key,
    required this.btnText,
    required this.btnColor,
  }) : super(key: key);

  @override
  State<TimeLog> createState() => _TimeLogState();
}

class _TimeLogState extends State<TimeLog> {
  //get current date and time
  String day = DateFormat("EEEE", 'ms').format(DateTime.now());
  String date = DateFormat("d", 'ms').format(DateTime.now());
  String month = DateFormat("MMMM", 'ms').format(DateTime.now());
  late String today = "   $date  $month ";
  String currentTime = DateFormat("HH:mm:ss").format(DateTime.now());

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
          icon:
              Icon(CustomIcon.arrowBack, color: Colors.grey.shade900, size: 18),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.fiber_manual_record,
                    size: 5,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    today,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  currentTime,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(55),
                child: TimeLogRippleButton(
                  btnText: widget.btnText,
                  btnColor: widget.btnColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
