import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/calendar/date.dart';
import '../../utils/icon/custom_icon.dart';
import 'package:eswm/models/attendance_log/attendance_logs_details.dart';

class AttendanceLogDetails extends StatefulWidget {
  final AttendanceLogsDetails data;

  const AttendanceLogDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<AttendanceLogDetails> createState() => _AttendanceLogDetailsState();
}

class _AttendanceLogDetailsState extends State<AttendanceLogDetails> {
  Color iconColor = greyCustom;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: white,
            border: Border(
              bottom: BorderSide(color: greyCustom, width: 0.8),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  Date.getTheDate(widget.data.attendanceDate, 'yyyy-MM-dd',
                      "dd/MM/yyyy", "ms"),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Icon(CustomIcon.timerOutline, size: 16, color: iconColor),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Log Masuk",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 5),
                        Text(
                            widget.data.clockIn != null
                                ? Date.getTheTimeOfDay(
                                        widget.data.clockIn!, "HH:mm", "ms")
                                    .format(context)
                                : "-",
                            style: TextStyle(
                                fontSize: 14,
                                color: iconColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Icon(CustomIcon.timerOutline, size: 16, color: iconColor),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Log Keluar",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 5),
                        Text(
                            widget.data.clockOut != null
                                ? Date.getTheTimeOfDay(
                                        widget.data.clockOut!, "HH:mm", "ms")
                                    .format(context)
                                : "-",
                            style: TextStyle(
                                fontSize: 14,
                                color: iconColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   child: Divider(
        //     thickness: 0.8,
        //     color: Color(0xff969696),
        //     // indent: 0,
        //     // endIndent: 0,
        //   ),
        // ),
      ],
    );
  }
}
