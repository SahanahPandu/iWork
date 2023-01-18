import 'package:flutter/material.dart';

//import files
import '../../../../../models/vc/detail/vc_main.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_view/vehicle_checklist_approval_view.dart';
import '../../../../custom_scroll/custom_scroll.dart';

class VehicleChecklistApprovalBeforeTabbarView extends StatefulWidget {
  final VehicleChecklistMain data;

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
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: VehicleChecklistApprovalView(data: widget.data, section: 0),
      ),
    );
  }
}
