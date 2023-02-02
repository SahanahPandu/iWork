import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../config/resource.dart';
import '../../../config/string.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import '../../buttons/time_log_button.dart';
import 'ba/ba_today_task_details.dart';
import 'compactor_panel/compactor_panel_today_task_details.dart';
import 'eo/eo_today_task_details.dart';
import 'pra/pra_today_task_details.dart';
import 'supervisor/supervisor_today_task_details.dart';

class TodayTaskCard extends StatefulWidget {
  final String? workTime;
  final String timeIn;
  final String timeOut;
  final Function? refresh;
  final GlobalKey<TimeLogButtonState>? timeLogButtonKey;
  final dynamic scheduleData;

  const TodayTaskCard({
    Key? key,
    this.workTime,
    required this.timeIn,
    required this.timeOut,
    this.refresh,
    this.timeLogButtonKey,
    this.scheduleData,
  }) : super(key: key);

  @override
  State<TodayTaskCard> createState() => _TodayTaskCardState();
}

class _TodayTaskCardState extends State<TodayTaskCard> {
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
            scheduleData: widget.scheduleData);
      case 200:
        return PraTodayTaskDetails(
          timeIn: widget.timeIn,
          timeOut: widget.timeOut,
          workTime: widget.workTime,
          refresh: widget.refresh,
          timeLogButtonKey: widget.timeLogButtonKey,
        );
      case 300:
        return SupervisorTodayTaskDetails(
            scheduleData: widget.scheduleData,
        );
      case 400:
        return const EOTodayTaskDetails();
      case 500:
      case 600:
      case 700:
        return const BATodayTaskDetails();
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
