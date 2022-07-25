import 'package:eswm/config/config.dart';
import 'package:eswm/config/resource.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import 'package:eswm/widgets/cards/today_task/pra/pra_today_task_details.dart';
import 'package:eswm/config/dimen.dart';
import 'package:eswm/utils/device.dart';
import 'package:eswm/widgets/cards/today_task/compactor_panel/compactor_panel_today_task_details.dart';
import '../../../config/string.dart';
import 'supervisor/supervisor_today_task_details.dart';

class TodayTaskCard extends StatefulWidget {
  const TodayTaskCard({Key? key}) : super(key: key);

  @override
  State<TodayTaskCard> createState() => _TodayTaskCardState();
}

class _TodayTaskCardState extends State<TodayTaskCard> {
  late String timeIn = "";
  late String timeOut = "";
  final Devices _device = Devices();

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
    return Container(
      //margin: const EdgeInsets.all(2),
      padding: EdgeInsets.all(taskCardPadding),
      width: _device.screenWidth(context),
      height: 240,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: const Offset(0.0, 8.0),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            //Color.fromARGB(225, 51, 102, 255),
            //Color.fromARGB(235, 0, 204, 255),
            Color.fromARGB(220, 51, 102, 255),
            Color.fromARGB(200, 0, 220, 255),
          ],
          begin: FractionalOffset(0.0, 1.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.decal,
        ),
      ),
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
