import 'package:flutter/material.dart';

//import files
import '../../../../../models/task/compactor/compactor_task.dart';
import '../../../../../models/vc/detail/vc_main.dart';
import '../../../../../models/vc/list/data/vc_data/vc_list_detail.dart';
import '../../../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';

class VehicleChecklistFormAfterTabbarView extends StatefulWidget {
  final CompactorTask? compactorData;
  final VCListDetail? vcListData;

  const VehicleChecklistFormAfterTabbarView(
      {Key? key, this.compactorData, this.vcListData})
      : super(key: key);

  @override
  State<VehicleChecklistFormAfterTabbarView> createState() =>
      _VehicleChecklistFormAfterTabbarViewState();
}

class _VehicleChecklistFormAfterTabbarViewState
    extends State<VehicleChecklistFormAfterTabbarView> {
  bool emptyVC = true;
  int? vcId = -1;

  @override
  void initState() {
    if (widget.vcListData != null) {
      if (widget.vcListData!.statusCode!.code == "VC2" ||
          widget.vcListData!.statusCode!.code == "VC3") {
        emptyVC = false;
      } else if (widget.vcListData!.statusCode!.code == "VC1") {
        emptyVC = true;
      }
      vcId = widget.vcListData!.id;
    } else {
      if (widget.compactorData!.data.vehicleChecklistId!.statusCode!.code ==
              "VC2" ||
          widget.compactorData!.data.vehicleChecklistId!.statusCode!.code ==
              "VC3") {
        emptyVC = false;
      } else if (widget
              .compactorData!.data.vehicleChecklistId!.statusCode!.code ==
          "VC1") {
        emptyVC = true;
      }
      vcId = widget.compactorData!.data.vehicleChecklistId!.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !emptyVC
        ? FutureBuilder<VehicleChecklistMain?>(
            future: VehicleChecklistApi.getVehicleChecklistData(context, vcId),
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
                      return widget.vcListData != null
                          ? VehicleChecklistDetail(
                              data: snapshot.data,
                              vcListData: widget.vcListData,
                              before: false)
                          : VehicleChecklistDetail(
                              data: snapshot.data,
                              compactorData: widget.compactorData,
                              before: false);
                    }
                  }
              }
              return Container();
            })
        : widget.vcListData != null
            ? VehicleChecklistDetail(
                vcListData: widget.vcListData, before: false)
            : VehicleChecklistDetail(
                compactorData: widget.compactorData, before: false);
  }
}
