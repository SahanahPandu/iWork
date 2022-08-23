import 'package:flutter/material.dart';

import '../../../../../models/vc/vc.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_view/vehicle_checklist_approval_view.dart';

class VehicleChecklistApprovalBeforeTabbarView extends StatefulWidget {
  final VehicleChecklist data;

  const VehicleChecklistApprovalBeforeTabbarView({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalBeforeTabbarView> createState() =>
      _VehicleChecklistApprovalBeforeTabbarViewState();
}

class _VehicleChecklistApprovalBeforeTabbarViewState
    extends State<VehicleChecklistApprovalBeforeTabbarView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: VehicleChecklistApprovalView(data: widget.data, section: 0),
    );
  }
}
