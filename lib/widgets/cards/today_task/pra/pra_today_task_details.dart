import 'package:flutter/material.dart';

//import files
import '../../../../utils/calendar/date.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../buttons/ecuti_button.dart';
import '../../../buttons/time_log_button.dart';

class PraTodayTaskDetails extends StatefulWidget {
  final String timeIn;
  final String timeOut;
  final Function getTimeLog;

  const PraTodayTaskDetails(
      {Key? key,
      required this.timeIn,
      required this.timeOut,
      required this.getTimeLog})
      : super(key: key);

  @override
  State<PraTodayTaskDetails> createState() => _PraTodayTaskDetailsState();
}

class _PraTodayTaskDetailsState extends State<PraTodayTaskDetails> {
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
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Tugasan Hari Ini (7.00 pg - 12.30 ptg)",
          style: TextStyle(
            color: Colors.white,
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
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
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
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TimeLogButton(getTimeLog: widget.getTimeLog),
            const SizedBox(
              width: 15,
            ),
            const Expanded(
              child: EcutiButton(),
            ),
          ],
        )
      ],
    );
  }
}
