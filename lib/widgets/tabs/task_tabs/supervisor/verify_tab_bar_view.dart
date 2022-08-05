import 'package:flutter/material.dart';

import '../../../../screens/schedule_verify/schedule_verify_main.dart';

class VarifyTabbarView extends StatefulWidget {
  const VarifyTabbarView({
    Key? key,
  }) : super(key: key);

  @override
  State<VarifyTabbarView> createState() => _VarifyTabbarViewState();
}

class _VarifyTabbarViewState extends State<VarifyTabbarView> {
  bool attendanceMainCard = true;
  bool eCutiMainCard = true;
  bool rescheduleMainCard = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child:
        ScheduleVerifyMain(
            isAttendanceList: attendanceMainCard,
            isEcutiList: eCutiMainCard,
            isReschedule: rescheduleMainCard),
    );
  }
}
