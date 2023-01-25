import 'package:flutter/material.dart';

//import files
import '../../../../../models/task/compactor/compactor_task.dart';
import '../../../../../models/vc/detail/vc_main.dart';
import '../../../../../models/vc/list/data/vc_data/vc_list_detail.dart';
import '../../../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';

class VehicleChecklistFormBeforeTabbarView extends StatefulWidget {
  final CompactorTask? compactorData;
  final VCListDetail? vcListData;

  const VehicleChecklistFormBeforeTabbarView(
      {Key? key, this.compactorData, this.vcListData})
      : super(key: key);

  @override
  State<VehicleChecklistFormBeforeTabbarView> createState() =>
      _VehicleChecklistFormBeforeTabbarViewState();
}

class _VehicleChecklistFormBeforeTabbarViewState
    extends State<VehicleChecklistFormBeforeTabbarView> {
  bool emptyVC = true;
  int? vcId = -1;

  @override
  void initState() {
    if (widget.vcListData == null) {
      if (widget.compactorData!.data!.vehicleChecklistId != null) {
        vcId = widget.compactorData!.data!.vehicleChecklistId!.id;
        emptyVC = false;
      } else {
        emptyVC = true;
      }
    } else {
      if (widget.vcListData!.statusCode != null) {
        vcId = widget.vcListData!.id;
        emptyVC = false;
      } else {
        emptyVC = true;
      }
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
                              before: true)
                          : VehicleChecklistDetail(
                              data: snapshot.data,
                              compactorData: widget.compactorData,
                              before: true);
                    }
                  }
              }
              return Container();
            })
        : widget.vcListData != null
            ? VehicleChecklistDetail(
                vcListData: widget.vcListData, before: true)
            : VehicleChecklistDetail(
                compactorData: widget.compactorData, before: true);
  }
}
