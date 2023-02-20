import 'package:flutter/material.dart';

//import files
import '../../../models/task/supervisor/supervisor_task.dart';
import '../../../widgets/cards/verification_task/attendance/verify_attendance_list_details.dart';

class AttendanceVerification extends StatefulWidget {
  final List<Attendance>? attendanceData;

  const AttendanceVerification({Key? key, this.attendanceData})
      : super(key: key);

  @override
  State<AttendanceVerification> createState() => _AttendanceVerificationState();
}

class _AttendanceVerificationState extends State<AttendanceVerification> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.attendanceData!.length,
      itemBuilder: (context, index) {
        var lastItem = widget.attendanceData!.length - 1;
        if (index < 4) {
          return VerifyAttendanceListDetails(
              data: widget.attendanceData![index],
              index: index,
              lastItem: lastItem);
        }
        return Container();
      },
    );
  }
}
