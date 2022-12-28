import 'package:flutter/material.dart';

//import files
import '../../../../../models/task/compactor/data/schedule/schedule.dart';
import '../../../../../models/vc/vc_main.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';

class VehicleChecklistFormAfterTabbarView extends StatefulWidget {
  final Schedule? scheduleData;

  const VehicleChecklistFormAfterTabbarView({Key? key, this.scheduleData})
      : super(key: key);

  @override
  State<VehicleChecklistFormAfterTabbarView> createState() =>
      _VehicleChecklistFormAfterTabbarViewState();
}

class _VehicleChecklistFormAfterTabbarViewState
    extends State<VehicleChecklistFormAfterTabbarView> {
  late VehicleChecklistMain? scheduleData;
  bool emptyVC = true;

  @override
  void initState() {
    if (widget.scheduleData!.vehicleChecklistId!.statusCode!.code == "VC2" ||
        widget.scheduleData!.vehicleChecklistId!.statusCode!.code == "VC3") {
      emptyVC = false;
    } else if (widget.scheduleData!.vehicleChecklistId!.statusCode!.code ==
        "VC1") {
      emptyVC = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VehicleChecklistDetail(
        before: false, scheduleData: widget.scheduleData);
  }
}
