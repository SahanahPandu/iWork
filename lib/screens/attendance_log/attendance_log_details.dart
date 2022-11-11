import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../models/attendance_log/attendance_log.dart';
import '../../utils/icon/custom_icon.dart';

class AttendanceLogDetails extends StatefulWidget {
  final AttendanceLog data;

  const AttendanceLogDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<AttendanceLogDetails> createState() => _AttendanceLogDetailsState();
}

class _AttendanceLogDetailsState extends State<AttendanceLogDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Day 5:
        buildAttendanceLogByDay(widget.data.day5.date, widget.data.day5.timeIn,
            widget.data.day5.timeOut),

        //Day 4:
        buildAttendanceLogByDay(widget.data.day4.date, widget.data.day4.timeIn,
            widget.data.day4.timeOut),

        //Day 3:
        buildAttendanceLogByDay(widget.data.day3.date, widget.data.day3.timeIn,
            widget.data.day3.timeOut),

        //Day 2:
        buildAttendanceLogByDay(widget.data.day2.date, widget.data.day2.timeIn,
            widget.data.day2.timeOut),

        //Day 1:
        buildAttendanceLogByDay(widget.data.day1.date, widget.data.day1.timeIn,
            widget.data.day1.timeOut),
      ],
    );
  }

  Column buildAttendanceLogByDay(String date, String timeIn, String timeOut) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: white),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(date,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Icon(CustomIcon.timerOutline, size: 16, color: greenCustom),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Log Masuk",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 5),
                        Text(timeIn,
                            style: TextStyle(
                                fontSize: 14,
                                color: greenCustom,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Icon(CustomIcon.timerOutline, size: 16, color: greenCustom),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Log Keluar",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 5),
                        Text(timeOut,
                            style: TextStyle(
                                fontSize: 14,
                                color: greenCustom,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(height: 0.5),
        )
      ],
    );
  }
}
