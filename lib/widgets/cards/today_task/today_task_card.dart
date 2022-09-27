import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import 'ba/ba_today_task_details.dart';
import 'compactor_panel/compactor_panel_today_task_details.dart';
import 'eo/eo_today_task_details.dart';
import 'supervisor/supervisor_today_task_details.dart';
import 'pra/pra_today_task_details.dart';
import '../../../config/config.dart';
import '../../../config/resource.dart';
import '../../../config/string.dart';

class TodayTaskCard extends StatefulWidget {
  const TodayTaskCard({Key? key}) : super(key: key);

  @override
  State<TodayTaskCard> createState() => _TodayTaskCardState();
}

class _TodayTaskCardState extends State<TodayTaskCard> {
  late String timeIn = "";
  late String timeOut = "";

  getTimeLog(actionText) {
    String currentTime = DateFormat("hh:mm a").format(DateTime.now());

    if (actionText == "Masuk Kerja") {
      setState(() {
        timeIn = currentTime;
      });
    } else if (actionText == "Tamat Kerja") {
      setState(() {
        timeOut = currentTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes().screenWidth(context),
      height: userRole == 100
          ? (Orientations().isLandscape(context) ? 210 : 230)
          : null,
      child: assignRoleTaskDetails(),
    );
  }

  StatefulWidget assignRoleTaskDetails() {
    switch (userRole) {
      case 100:
        return CompactorPanelTodayTaskDetails(
            timeIn: timeIn, timeOut: timeOut, getTimeLog: getTimeLog);
      case 200:
        return PraTodayTaskDetails(
            timeIn: timeIn, timeOut: timeOut, getTimeLog: getTimeLog);
      case 300:
        return SupervisorTodayTaskDetails(
            timeIn: timeIn, timeOut: timeOut, getTimeLog: getTimeLog);
      case 400:
        return EOTodayTaskDetails(
            timeIn: timeIn, timeOut: timeOut, getTimeLog: getTimeLog);
      case 500:
        return BATodayTaskDetails(
            timeIn: timeIn, timeOut: timeOut, getTimeLog: getTimeLog);
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(idleImg),
            Text(tryAgain),
          ],
        ),
      ),
    );
  }
}
