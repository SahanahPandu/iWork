import 'package:flutter/material.dart';

import 'package:eswm/config/palette.dart';
import 'package:eswm/widgets/buttons/ecuti_button.dart';
import 'package:eswm/widgets/buttons/time_log_button.dart';

import '../../../../config/string.dart';
import '../../../../utils/date.dart';

class CompactorPanelTodayTaskDetails extends StatefulWidget {
  const CompactorPanelTodayTaskDetails({Key? key}) : super(key: key);

  @override
  State<CompactorPanelTodayTaskDetails> createState() => _CompactorPanelTodayTaskDetailsState();
}

class _CompactorPanelTodayTaskDetailsState extends State<CompactorPanelTodayTaskDetails> {
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
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
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
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: white,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "7:05 pagi",
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
              children: const [
                EcutiButton(),
                SizedBox(
                  width: 10,
                ),
                TimeLogButton(),
              ],
            )
          ],
        )

      ],
    );
  }
}
