import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../models/vc/detail/vc_main.dart';
import '../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../widgets/cards/verification_task/vehicle_checklist/vehicle_checklist_verification_detail_list.dart';
import '../../../widgets/tabs/vehicle_checklist_tab/vehicle_checklist_approval_tab/vehicle_checklist_approval_tab.dart';

class VehicleChecklistVerification extends StatefulWidget {
  const VehicleChecklistVerification({Key? key}) : super(key: key);

  @override
  State<VehicleChecklistVerification> createState() =>
      _VehicleChecklistVerificationState();
}

class _VehicleChecklistVerificationState
    extends State<VehicleChecklistVerification> {
  late Future<VehicleChecklistMain?>? _loadVehicleChecklistData;

  @override
  void initState() {
    _loadVehicleChecklistData = VehicleChecklistApi.getVehicleChecklist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VehicleChecklistMain?>(
      future: _loadVehicleChecklistData,
      builder: (context, snapshot) {
        final dataFuture = snapshot.data;

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text("Some errors occurred!"),
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: VehicleChecklistApprovalTab(
                                  data: dataFuture!)));
                    },
                    child: VehicleChecklistVerificationDetailList(
                      data: dataFuture!,
                      index: index,
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
