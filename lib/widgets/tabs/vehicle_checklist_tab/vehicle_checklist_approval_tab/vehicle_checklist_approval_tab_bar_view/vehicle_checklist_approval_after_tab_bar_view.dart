import 'package:flutter/material.dart';

//import files
import '../../../../../models/vc/vc.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_view/vehicle_checklist_approval_view.dart';

class VehicleChecklistApprovalAfterTabbarView extends StatefulWidget {
  final VehicleChecklist data;
  const VehicleChecklistApprovalAfterTabbarView(
      {Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalAfterTabbarView> createState() =>
      _VehicleChecklistApprovalAfterTabbarViewState();
}

class _VehicleChecklistApprovalAfterTabbarViewState
    extends State<VehicleChecklistApprovalAfterTabbarView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: VehicleChecklistApprovalView(data: widget.data, section: 1),
    );
  }
}
