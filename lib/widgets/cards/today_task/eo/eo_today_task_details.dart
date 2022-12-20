import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/device/sizes.dart';
import '../../summary_task/attendance/attendance_summary.dart';
import '../../summary_task/compactor/compactor_summary.dart';
import '../../summary_task/schedule/schedule_summary.dart';

class EOTodayTaskDetails extends StatefulWidget {
  const EOTodayTaskDetails({Key? key}) : super(key: key);

  @override
  State<EOTodayTaskDetails> createState() => _EOTodayTaskDetailsState();
}

class _EOTodayTaskDetailsState extends State<EOTodayTaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Rumusan Hari Ini (${Date.getTheDate(DateTime.now().toString(), "dd/MM/yyyy", 'ms')})",
        style: TextStyle(
          color: fillColor,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              width: Sizes().screenWidth(context) * 0.42,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: cardShadowColor,
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                        spreadRadius: 3)
                  ]),
              child: const ScheduleSummary(),
            ),
            const SizedBox(width: 10),
            Container(
              height: 100,
              width: Sizes().screenWidth(context) * 0.42,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: cardShadowColor,
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                        spreadRadius: 3)
                  ]),
              child: const AttendanceSummary(),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        height: 100,
        width: Sizes().screenWidth(context),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: barShadowColor,
                  offset: const Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 3)
            ]),
        child: const CompactorSummary(),
      )
    ]);
  }
}
