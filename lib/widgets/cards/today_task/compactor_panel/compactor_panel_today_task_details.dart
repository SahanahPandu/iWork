import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/date.dart';
import '../../../buttons/ecuti_button.dart';
import '../../../buttons/time_log_button.dart';

class CompactorPanelTodayTaskDetails extends StatefulWidget {
  final String timeIn;
  final String timeOut;
  final Function getTimeLog;

  const CompactorPanelTodayTaskDetails(
      {Key? key,
      required this.timeIn,
      required this.timeOut,
      required this.getTimeLog})
      : super(key: key);

  @override
  State<CompactorPanelTodayTaskDetails> createState() =>
      _CompactorPanelTodayTaskDetailsState();
}

class _CompactorPanelTodayTaskDetailsState
    extends State<CompactorPanelTodayTaskDetails> {
  String todayDate = "0";

  @override
  void initState() {
    super.initState();
    todayDate = Date.getTodayDate();
  }

  //------------------------------------------------------
  // Build widget.
  //------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              todayTask,
              style: const TextStyle(
                color: Color(0xDDFFFFFF),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: black26,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.date_range,
                  color: white,
                  size: 29,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        Text(
          todayDate,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        Text(
          "7 pagi - 12 tengahari",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CustomIcon.timerFill,
                  color: white,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.timeIn} - ${widget.timeOut}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const EcutiButton(),
                const SizedBox(
                  width: 10,
                ),
                TimeLogButton(getTimeLog: widget.getTimeLog),
              ],
            )
          ],
        )
      ],
    );
  }
}
