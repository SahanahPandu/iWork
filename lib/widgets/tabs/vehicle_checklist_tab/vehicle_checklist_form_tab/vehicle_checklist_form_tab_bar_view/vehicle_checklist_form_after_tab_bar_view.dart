import 'package:flutter/material.dart';

//import files
import '../../../../../models/vc/vc.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';

class VehicleChecklistFormAfterTabbarView extends StatefulWidget {
  final VehicleChecklist data;

  const VehicleChecklistFormAfterTabbarView({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistFormAfterTabbarView> createState() =>
      _VehicleChecklistFormAfterTabbarViewState();
}

class _VehicleChecklistFormAfterTabbarViewState
    extends State<VehicleChecklistFormAfterTabbarView> {
  @override
  Widget build(BuildContext context) {
    return VehicleChecklistDetail(data: widget.data);
  }
}
