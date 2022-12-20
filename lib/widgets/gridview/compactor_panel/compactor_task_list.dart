import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../providers/task/compactor_task_api.dart';
import '../../../providers/vehicle_checklist_api.dart';
import '../../../screens/work_schedule/compactor_panel/compactor_panel_schedule_main.dart';
import '../../../utils/device/orientations.dart';
import '../../cards/my_task/compactor_panel/compactor_panel_my_task_list_details.dart';
import '../../cards/my_task/compactor_panel/vehicle_checklist_card_details.dart';

class CompactorTaskList extends StatefulWidget {
  final Function? topCardStatus;
  final bool main;

  const CompactorTaskList({Key? key, this.topCardStatus, required this.main})
      : super(key: key);

  @override
  State<CompactorTaskList> createState() => _CompactorTaskListState();
}

class _CompactorTaskListState extends State<CompactorTaskList> {
  late Future<List> _loadVcData;
  Future<List<dynamic>>? _loadLaluanData;

  @override
  void initState() {
    super.initState();
    _loadLaluanData = CompactorTaskApi.getCompactorSchedule();
    _loadVcData = VehicleChecklistApi.getVehicleChecklistData(context);
  }

  /// --------------------------------------------------------------------------------------------
  ///  CONDITION    ||        VC                        ||        Schedule
  /// --------------------------------------------------------------------------------------------
  ///     0         ||    Null                          ||    Null
  ///     1         ||    Not started                   ||    Not started
  ///     2         ||    Done Before VC (In Progress)  ||    Not started
  ///     3         ||    Done Before VC (In Progress)  ||    In progress (slided start work)
  ///     4         ||    Done Before VC (In progress)  ||    Completed (slided start & end work)
  ///     5         ||    Done Before & After VC (Done) ||    Completed (slided start & end work)
  /// --------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: _loadLaluanData,
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
                          return FutureBuilder<List>(
                              future: _loadVcData,
                              builder: (context, snapshot) {
                                final vcDataFuture = snapshot.data;

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
                                      return buildTabletCard(
                                          VehicleChecklistCardDetails(
                                              data: vcDataFuture![i]));
                                    }
                                }
                              });
                        }
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: CompactorPanelScheduleMain(
                                          data: widget.main == true
                                              ? laluanDataFuture[i - 1]
                                              : laluanDataFuture[i])));
                              //print("index clicked ${i - 1}");
                            },
                            child: buildTabletCard(
                                CompactorPanelMyTaskListDetails(
                                    data: widget.main == true
                                        ? laluanDataFuture[i - 1]
                                        : laluanDataFuture[i],
                                    button: widget.main)));
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
