import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../models/task/supervisor/supervisor_task.dart';
import '../../../widgets/cards/verification_task/vehicle_checklist/vehicle_checklist_verification_detail_list.dart';
import '../../../widgets/tabs/vehicle_checklist_tab/vehicle_checklist_approval_tab/vehicle_checklist_approval_tab.dart';

class VehicleChecklistVerification extends StatefulWidget {
  final List<Checklist>? checklistData;

  const VehicleChecklistVerification({Key? key, this.checklistData})
      : super(key: key);

  @override
  State<VehicleChecklistVerification> createState() =>
      _VehicleChecklistVerificationState();
}

class _VehicleChecklistVerificationState
    extends State<VehicleChecklistVerification> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.checklistData!.length,
      itemBuilder: (context, index) {
        var lastItem = widget.checklistData!.length - 1;
        if (index < 4) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: VehicleChecklistApprovalTab(
                        vcData: widget.checklistData![index],
                      )));
            },
            child: VehicleChecklistVerificationDetailList(
                vcData: widget.checklistData![index],
                index: index,
                lastItem: lastItem),
          );
        }
        return Container();
      },
    );
  }
}
