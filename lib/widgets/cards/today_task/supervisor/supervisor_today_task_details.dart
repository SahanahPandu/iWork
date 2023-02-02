import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/task/supervisor/supervisor_task.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../buttons/enotis_button.dart';
import '../../../buttons/time_log_button.dart';

class SupervisorTodayTaskDetails extends StatefulWidget {
  final SupervisorTask scheduleData;

  const SupervisorTodayTaskDetails({
    Key? key,
    required this.scheduleData,
  }) : super(key: key);

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
    todayDate = Date.getTheDate(DateTime.now(), '', "dd MMM yyyy", 'ms');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.scheduleData.data.startWork != ""
              ? "Tugasan Hari Ini (${widget.scheduleData.data.startWork} - ${widget.scheduleData.data.stopWork})"
              : "Tugasan Hari ini ( --:-- )",
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
            if (widget.scheduleData.data.startWork != "")
              const Icon(
                CustomIcon.timerOutline,
                color: Color(0xffA0FD57),
                size: 18,
              ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.scheduleData.data.startWork!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: white,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            if (widget.scheduleData.data.stopWork != "")
              const Icon(
                CustomIcon.timerOutline,
                color: Color(0xffA0FD57),
                size: 18,
              ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.scheduleData.data.stopWork!,
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
          children: const [
            TimeLogButton(),
            ENotisButton(),
          ],
        )
      ],
    );
  }
}
