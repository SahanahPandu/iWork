import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/icon/custom_icon.dart';
import 'package:eswm/models/attendance_log/attendance_logs_details.dart';

class AttendanceLogDetails extends StatefulWidget {
  final AttendanceLogsDetails data;

  const AttendanceLogDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<AttendanceLogDetails> createState() => _AttendanceLogDetailsState();
}

class _AttendanceLogDetailsState extends State<AttendanceLogDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: white),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.data.attendanceDate,
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
                        Text(
                            widget.data.clockIn != null
                                ? widget.data.clockIn!
                                : "-",
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
                        Text(
                            widget.data.clockOut != null
                                ? widget.data.clockOut!
                                : "-",
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
