import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../models/schedule/compactor/list/data/schedule_data/schedule_data.dart';
import '../../../../screens/work_schedule/compactor_panel/compactor_panel_schedule_main.dart';
import '../../../cards/list_card.dart';
import '../../../cards/my_task/compactor_panel/compactor_panel_my_task_list_details.dart';

class ScheduleListTileDetail extends StatelessWidget {
  const ScheduleListTileDetail({Key? key, required this.schedule, this.index})
      : super(key: key);
  final CScheduleData schedule;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return userRole == 100
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,

                      /// Pass compactor schedule data
                      child: CompactorPanelScheduleMain(data: schedule)));
              //print("index clicked ${i - 1}");
            },
            child: buildTabletCard(
                CompactorPanelMyTaskListDetails(data: schedule, button: false)),
          )
        : ListCard(
            data: schedule,
            type: "Laluan",
            listIndex: index!,
          ); // Card
  }

  Padding buildTabletCard(redirect) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: cardListShadowColor.withOpacity(0.06),
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                      spreadRadius: 0.5)
                ]),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: redirect)));
  }
}
