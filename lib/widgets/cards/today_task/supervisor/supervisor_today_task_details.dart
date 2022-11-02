import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../buttons/enotis_button.dart';
import '../../../buttons/time_log_button.dart';

class SupervisorTodayTaskDetails extends StatefulWidget {
  final String timeIn;
  final String timeOut;
  final Function getTimeLog;

  const SupervisorTodayTaskDetails(
      {Key? key,
      required this.timeIn,
      required this.timeOut,
      required this.getTimeLog})
      : super(key: key);

  @override
  State<SupervisorTodayTaskDetails> createState() =>
      _SupervisorTodayTaskDetailsState();
}

class _SupervisorTodayTaskDetailsState
    extends State<SupervisorTodayTaskDetails> {
  String todayDate = "0";

  @override
  void initState() {
    super.initState();
    todayDate = Date.getTodayDate2();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tugasan Hari Ini (9.00 pg - 5.00 ptg)",
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              todayDate,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              icon: const Icon(
                CustomIcon.scheduleFill,
                color: Color(0xffA0FD57),
                size: 20,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            if (widget.timeIn != "")
              const Icon(
                CustomIcon.timerOutline,
                color: Color(0xffA0FD57),
                size: 18,
              ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.timeIn,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: white,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            if (widget.timeOut != "")
              const Icon(
                CustomIcon.timerOutline,
                color: Color(0xffA0FD57),
                size: 18,
              ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.timeOut,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeLogButton(getTimeLog: widget.getTimeLog),
            const ENotisButton(),
          ],
        )
      ],
    );
  }
}
