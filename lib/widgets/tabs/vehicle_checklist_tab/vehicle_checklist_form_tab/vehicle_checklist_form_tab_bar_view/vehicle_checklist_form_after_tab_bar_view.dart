import 'package:flutter/material.dart';

//import files
import '../../../../../models/task/compactor/compactor_task.dart';
import '../../../../../models/vc/vc_main.dart';
import '../../../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';

class VehicleChecklistFormAfterTabbarView extends StatefulWidget {
  final CompactorTask? compactorData;

  const VehicleChecklistFormAfterTabbarView({Key? key, this.compactorData})
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
    if (widget.compactorData!.data!.vehicleChecklistId!.statusCode!.code ==
            "VC2" ||
        widget.compactorData!.data!.vehicleChecklistId!.statusCode!.code ==
            "VC3") {
      emptyVC = false;
    } else if (widget
            .compactorData!.data!.vehicleChecklistId!.statusCode!.code ==
        "VC1") {
      emptyVC = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !emptyVC
        ? FutureBuilder<VehicleChecklistMain?>(
            future: VehicleChecklistApi.getVehicleChecklistData(
                context, widget.compactorData!.data!.vehicleChecklistId!.id),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Some error occurred!"),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return VehicleChecklistDetail(
                          data: snapshot.data,
                          compactorData: widget.compactorData,
                          before: false);
                    }
                  }
              }
              return Container();
            })
        : VehicleChecklistDetail(
            compactorData: widget.compactorData, before: false);
  }
}
