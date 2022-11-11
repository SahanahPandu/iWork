import 'package:flutter/material.dart';

//import files
import '../../../../screens/e_cuti/supervisor/supervisor_leave_list.dart';

class EcutiApprovalRejectedTabBarView extends StatefulWidget {
  const EcutiApprovalRejectedTabBarView({Key? key}) : super(key: key);

  @override
  State<EcutiApprovalRejectedTabBarView> createState() =>
      _EcutiApprovalRejectedTabBarViewState();
}

class _EcutiApprovalRejectedTabBarViewState
    extends State<EcutiApprovalRejectedTabBarView> {
  @override
  Widget build(BuildContext context) {
    return const SupervisorLeaveList(status: [4]);
  }
}
