import 'package:flutter/material.dart';

//import files
import '../../../../../models/vc/vc.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';

class VehicleChecklistFormBeforeTabbarView extends StatefulWidget {
  final VehicleChecklist data;

  const VehicleChecklistFormBeforeTabbarView({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistFormBeforeTabbarView> createState() =>
      _VehicleChecklistFormBeforeTabbarViewState();
}

class _VehicleChecklistFormBeforeTabbarViewState
    extends State<VehicleChecklistFormBeforeTabbarView> {
  @override
  Widget build(BuildContext context) {
    return VehicleChecklistDetail(data: widget.data, before: true);
  }
}
