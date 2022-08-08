import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../screens/schedule_verification/schedule_verification_main.dart';


class VarifyTabbarView extends StatefulWidget {
  const VarifyTabbarView({
    Key? key,
  }) : super(key: key);

  @override
  State<VarifyTabbarView> createState() => _VarifyTabbarViewState();
}

class _VarifyTabbarViewState extends State<VarifyTabbarView> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child:
        ScheduleVerificationMain(
            isAttendanceList: attendanceMainCard,
            isEcutiList: eCutiMainCard,
            isReschedule: rescheduleMainCard),
    );
  }
}
