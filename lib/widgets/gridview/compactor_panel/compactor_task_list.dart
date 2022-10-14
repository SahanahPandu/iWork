import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../providers/laluan_api.dart';
import '../../../providers/vehicle_checklist_api.dart';
import '../../../screens/work_schedule/compactor_panel/compactor_panel_schedule.dart';
import '../../cards/my_task/compactor_panel/compactor_panel_my_task_list_details.dart';
import '../../cards/my_task/compactor_panel/vehicle_checklist_card_details.dart';

class CompactorTaskList extends StatefulWidget {
  final Function? topCardStatus;
  final bool main;

  const CompactorTaskList(
      {Key? key, this.topCardStatus, required this.main})
      : super(key: key);

  @override
  State<CompactorTaskList> createState() => _CompactorTaskListState();
}

class _CompactorTaskListState extends State<CompactorTaskList> {
  late Future<List> _loadLaluanData;
  late Future<List> _loadVcData;

  @override
  void initState() {
    super.initState();
    _loadLaluanData = LaluanApi.getLaluanData(context);
    _loadVcData = VehicleChecklistApi.getVehicleChecklistData(context);
  }

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
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: axisSpacing(context),
                          mainAxisSpacing: axisSpacing(context),
                          childAspectRatio: gridRatio(context)),
                      physics: widget.main == true
                          ? const NeverScrollableScrollPhysics()
                          : const ScrollPhysics(),
                      itemCount: laluanDataFuture!.length + 1,
                      itemBuilder: (context, i) {
                        if (i == 0) {
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
                                      child: CompactorPanelSchedule(
                                          data: laluanDataFuture[i - 1])));
                              //print("index clicked ${i - 1}");
                            },
                            child: buildTabletCard(
                                CompactorPanelMyTaskListDetails(
                                    data: laluanDataFuture[i - 1],
                                    button: widget.main)));
                      }));
          }
        });
  }

  //------------------------------------------------------
  // Build card details for vc/tasks.
  //------------------------------------------------------
  SizedBox buildTabletCard(redirect) {
    return SizedBox(
        child: Padding(
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
                    child: redirect))));
  }
}
