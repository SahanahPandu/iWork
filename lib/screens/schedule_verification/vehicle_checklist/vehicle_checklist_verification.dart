import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../providers/vehicle_checklist_api.dart';
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
  late Future<List> _loadVehicleChecklistData;

  @override
  void initState() {
    _loadVehicleChecklistData =
        VehicleChecklistApi.getVehicleChecklistData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
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
                itemCount: dataFuture?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: VehicleChecklistApprovalTab(
                                data: dataFuture![index],
                              )));
                    },
                    child: VehicleChecklistVerificationDetailList(
                      data: dataFuture![index],
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
