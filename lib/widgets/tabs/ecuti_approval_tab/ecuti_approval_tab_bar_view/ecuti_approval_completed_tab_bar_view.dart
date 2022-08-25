import 'package:flutter/material.dart';

//import files
import '../../../../screens/e_cuti/supervisor/supervisor_leave_list.dart';

class EcutiApprovalCompletedTabBarView extends StatefulWidget {
  const EcutiApprovalCompletedTabBarView({Key? key}) : super(key: key);

  @override
  State<EcutiApprovalCompletedTabBarView> createState() =>
      _EcutiApprovalCompletedTabBarViewState();
}

class _EcutiApprovalCompletedTabBarViewState
    extends State<EcutiApprovalCompletedTabBarView> {
  @override
  Widget build(BuildContext context) {
    return const SupervisorLeaveList(status: [3]);
  }
}
