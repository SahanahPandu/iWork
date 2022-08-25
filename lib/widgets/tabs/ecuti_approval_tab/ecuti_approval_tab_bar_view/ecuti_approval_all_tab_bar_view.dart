import 'package:flutter/material.dart';

//import files
import '../../../../screens/e_cuti/supervisor/supervisor_leave_list.dart';

class EcutiApprovalAllTabBarView extends StatefulWidget {
  const EcutiApprovalAllTabBarView({Key? key}) : super(key: key);

  @override
  State<EcutiApprovalAllTabBarView> createState() =>
      _EcutiApprovalAllTabBarViewState();
}

class _EcutiApprovalAllTabBarViewState
    extends State<EcutiApprovalAllTabBarView> {
  @override
  Widget build(BuildContext context) {
    return const SupervisorLeaveList();
  }
}
