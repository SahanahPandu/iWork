import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/config.dart';
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../models/task/compactor/compactor_task.dart';
import '../../../models/task/compactor/data/schedule/schedule.dart';
import '../../../providers/task/compactor_panel/compactor_task_api.dart';
import '../../../screens/work_schedule/compactor_panel/compactor_panel_schedule_main.dart';
import '../../../utils/device/orientations.dart';
import '../../cards/my_task/compactor_panel/compactor_panel_my_task_list_details.dart';
import '../../cards/my_task/compactor_panel/vehicle_checklist_card_details.dart';

class CompactorTaskList extends StatefulWidget {
  final bool main;
  final CompactorTask? data;

  const CompactorTaskList({Key? key, required this.main, this.data})
      : super(key: key);

  @override
  State<CompactorTaskList> createState() => _CompactorTaskListState();
}

class _CompactorTaskListState extends State<CompactorTaskList> {
  late Future<List<Schedule>?> _loadLaluanList;

  @override
  void initState() {
    super.initState();
    _loadLaluanList = CompactorTaskApi.getCompactorScheduleList();
  }

  /// --------------------------------------------------------------------------------------------
  ///  CONDITION    ||        VC                        ||        Schedule
  /// --------------------------------------------------------------------------------------------
  ///     0         ||    Null                          ||    Null
  ///     1         ||    Not started                   ||    Not started
  ///     2         ||    Done Before VC (In Progress)  ||    Not started
  ///     3         ||    Done Before VC (In Progress)  ||    In Progress (slided start work)
  ///     4         ||    Done Before VC (In Progress)  ||    Completed (slided start & end work)
  ///     5         ||    Done Before & After VC (Done) ||    Completed (slided start & end work)
  /// --------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Schedule>?>(
        future: _loadLaluanList,
        builder: (context, snapshot) {
          final laluanDataFuture = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Container(
                  margin: Orientations().isTabletPortrait(context)
                      ? const EdgeInsets.symmetric(horizontal: 10)
                      : const EdgeInsets.symmetric(horizontal: 18),
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: axisSpacing(context),
                          mainAxisSpacing: axisSpacing(context),
                          childAspectRatio: widget.main == true
                              ? gridRatio(context)
                              : gridRatioSchedule(context)),
                      physics: widget.main == true
                          ? const NeverScrollableScrollPhysics()
                          : const ScrollPhysics(),
                      itemCount: widget.main == true
                          ? laluanDataFuture!.length + 1
                          : laluanDataFuture!.length,
                      itemBuilder: (context, i) {
                        if (widget.main == true && i == 0) {
                          return buildTabletCard(VehicleChecklistCardDetails(
                              compactorData: widget.data));
                        }

                        listLength = laluanDataFuture.length;
                        routeNames = List.generate(listLength, (index) => '',
                            growable: true);
                        for (int j = 0; j < laluanDataFuture.length; j++) {
                          if (laluanDataFuture[j].statusCode == null) {
                            cpSchedule[j] = 0;
                          } else if (laluanDataFuture[j].statusCode!.code ==
                              "SBM") {
                            cpSchedule[j] = 1;
                          } else if (laluanDataFuture[j].statusCode!.code ==
                              "SBT") {
                            cpSchedule[j] = 2;
                          } else if (laluanDataFuture[j].statusCode!.code ==
                              "STG") {
                            cpSchedule[j] = 3;
                          } else {
                            cpSchedule[j] = 0;
                          }
                          routeNames[j] = laluanDataFuture[j].mainRoute!;
                        }
                       // print(routeNames);
                       // print(cpSchedule);
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: CompactorPanelScheduleMain(
                                          data: widget.main == true
                                              ? laluanDataFuture[i - 1]
                                              : laluanDataFuture[i],
                                          idx: widget.main == true
                                              ? i - 1
                                              : i)));
                              //print("index clicked ${i - 1}");
                            },
                            child: buildTabletCard(
                                CompactorPanelMyTaskListDetails(
                                    data: widget.main == true
                                        ? laluanDataFuture[i - 1]
                                        : laluanDataFuture[i],
                                    compactorData: widget.data,
                                    button: widget.main,
                                    idx: i)));
                      }));
          }
        });
  }

  //------------------------------------------------------
  // Build card details for vc/tasks.
  //------------------------------------------------------
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
