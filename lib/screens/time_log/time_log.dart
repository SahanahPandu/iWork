import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/palette.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/buttons/time_log_ripple_button.dart';
import '../attendance_log/attendance_log_main.dart';

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
  String currentTime = DateFormat("hh:mm:ss").format(DateTime.now());
  late dynamic _timer;

  @override
  void initState() {
    _loadLiveTime();
    super.initState();
  }

  void _loadLiveTime() {
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer time) => _getTime());
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    setState(() {
      currentTime = formattedDateTime;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: barShadowColor,
              offset: const Offset(0, 3),
              blurRadius: 8,
            )
          ]),
          child: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
            ),
            title: Center(
              child: Text(
                "Log Masa",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const AttendanceLogMain(),
                          type: PageTransitionType.fade));
                },
                icon: Icon(
                  CustomIcon.history,
                  color: blackCustom,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
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
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.fiber_manual_record,
                    size: 5,
                    color: greyCustom,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    today,
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                currentTime,
                style: TextStyle(
                  fontSize: 32,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
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
