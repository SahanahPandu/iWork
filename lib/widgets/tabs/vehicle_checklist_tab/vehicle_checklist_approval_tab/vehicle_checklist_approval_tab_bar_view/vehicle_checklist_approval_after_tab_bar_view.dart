import 'package:flutter/material.dart';

//import files
import '../../../../../models/vc/detail/vc_main.dart';
import '../../../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../../../screens/vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_view/vehicle_checklist_approval_view.dart';
import '../../../../custom_scroll/custom_scroll.dart';

class VehicleChecklistApprovalAfterTabbarView extends StatefulWidget {
  final dynamic vcData;
  final int? vcId;
  final String? routeName;

  const VehicleChecklistApprovalAfterTabbarView(
      {Key? key, required this.vcData, this.vcId, this.routeName})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalAfterTabbarView> createState() =>
      _VehicleChecklistApprovalAfterTabbarViewState();
}

class _VehicleChecklistApprovalAfterTabbarViewState
    extends State<VehicleChecklistApprovalAfterTabbarView> {
  VehicleChecklistMain? checklistData;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
          child: FutureBuilder<VehicleChecklistMain?>(
              future: VehicleChecklistApi.getVehicleChecklistData(
                  context, widget.vcId),
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
                        checklistData = snapshot.data!;
                        return VehicleChecklistApprovalView(
                            data: checklistData,
                            section: 1,
                            vehicleName: widget.vcData.vehicleNo,
                            routeName: widget.routeName);
                      }
                    }
                }
                return Container();
              })),
    );
  }
}
