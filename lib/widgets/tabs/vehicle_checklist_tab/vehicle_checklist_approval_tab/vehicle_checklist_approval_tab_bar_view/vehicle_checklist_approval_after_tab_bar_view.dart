import 'package:flutter/material.dart';

//import files
import '../../../../../models/vc/vc_main.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_view/vehicle_checklist_approval_view.dart';
import '../../../../custom_scroll/custom_scroll.dart';

class VehicleChecklistApprovalAfterTabbarView extends StatefulWidget {
  final VehicleChecklistMain data;

  const VehicleChecklistApprovalAfterTabbarView({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalAfterTabbarView> createState() =>
      _VehicleChecklistApprovalAfterTabbarViewState();
}

class _VehicleChecklistApprovalAfterTabbarViewState
    extends State<VehicleChecklistApprovalAfterTabbarView> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: VehicleChecklistApprovalView(data: widget.data, section: 1),
      ),
    );
  }
}
