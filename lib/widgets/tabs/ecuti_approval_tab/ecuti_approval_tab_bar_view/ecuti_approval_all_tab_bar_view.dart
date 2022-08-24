import 'package:eswm/screens/e_cuti/supervisor/supervisor_leave_list.dart';
import 'package:flutter/material.dart';

class EcutiApprovalAllTabBarView extends StatefulWidget {
  const EcutiApprovalAllTabBarView({Key? key}) : super(key: key);

  @override
  State<EcutiApprovalAllTabBarView> createState() => _EcutiApprovalAllTabBarViewState();
}

class _EcutiApprovalAllTabBarViewState extends State<EcutiApprovalAllTabBarView> {
  @override
  Widget build(BuildContext context) {
    return const SupervisorLeaveList();
  }
}
