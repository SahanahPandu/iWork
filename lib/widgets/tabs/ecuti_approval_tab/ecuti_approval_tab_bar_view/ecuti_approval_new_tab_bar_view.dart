import 'package:flutter/material.dart';

//import files
import '../../../../screens/e_cuti/supervisor/supervisor_leave_list.dart';

class EcutiApprovalNewTabBarView extends StatefulWidget {
  const EcutiApprovalNewTabBarView({Key? key}) : super(key: key);

  @override
  State<EcutiApprovalNewTabBarView> createState() =>
      _EcutiApprovalNewTabBarViewState();
}

class _EcutiApprovalNewTabBarViewState
    extends State<EcutiApprovalNewTabBarView> {
  @override
  Widget build(BuildContext context) {
    return const SupervisorLeaveList(status: [1, 2]);
  }
}
