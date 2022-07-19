import 'package:flutter/material.dart';

import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import 'compactor_panel/compactor_panel_my_task_list_details.dart';
import 'compactor_panel/vehicle_checklist_card_details.dart';

class CompactorTaskCard extends StatefulWidget {
  const CompactorTaskCard({Key? key}) : super(key: key);

  @override
  State<CompactorTaskCard> createState() => _CompactorTaskCardState();
}

class _CompactorTaskCardState extends State<CompactorTaskCard> {
  //------------------------------------------------------
  // Build card details for vc/tasks.
  //------------------------------------------------------
  SizedBox buildTabletCard(redirect) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          //Tugasan Card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: grey500,
          elevation: 5,
          child: Padding(padding: const EdgeInsets.all(6), child: redirect),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        primary: false,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            left: 10, top: 5.0, bottom: 3, right: 10.0),
        crossAxisSpacing: axisSpacing(context),
        mainAxisSpacing: axisSpacing(context),
        shrinkWrap: true,
        childAspectRatio: gridRatio(context),
        children: [
          buildTabletCard(const VehicleChecklistCardDetails()),
          buildTabletCard(const CompactorPanelMyTaskListDetails())
        ]);
  }
}
