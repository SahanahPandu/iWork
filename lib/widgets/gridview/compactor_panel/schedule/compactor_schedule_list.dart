import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../models/schedule/compactor/list/data/schedule_data/schedule_data.dart';
import '../../../../providers/schedule/compactor_panel/compactor_schedule_api.dart';
import '../../../../screens/work_schedule/compactor_panel/compactor_panel_schedule_main.dart';
import '../../../../utils/device/orientations.dart';
import '../../../cards/my_task/compactor_panel/compactor_panel_my_task_list_details.dart';

class CompactorScheduleList extends StatefulWidget {
  final dynamic passData;

  const CompactorScheduleList({Key? key, this.passData}) : super(key: key);

  @override
  State<CompactorScheduleList> createState() => _CompactorScheduleListState();
}

class _CompactorScheduleListState extends State<CompactorScheduleList> {
  late Future<List<CScheduleData?>?> _loadScheduleList;

  // static List<CScheduleData?> itemList = List<CScheduleData?>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _loadScheduleList = CompactorScheduleApi.getCompactorScheduleListData(
        context, widget.passData);
  }

  /* void _loadMore() {
    isLoading = true;
    Future<List<CScheduleData?>?> loadScheduleList2 =
        CompactorScheduleApi.getCompactorScheduleListData(
            context, widget.passData);

    loadScheduleList2.then((fetchedList) {
      if (fetchedList!.isEmpty) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          itemList.addAll(fetchedList);
        });
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CScheduleData?>?>(
        future: widget.passData != null
            ? CompactorScheduleApi.getCompactorScheduleListData(
                context, widget.passData)
            : _loadScheduleList,
        builder: (context, snapshot) {
          final scheduleDataFuture = snapshot.data;
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
                          childAspectRatio: gridRatioSchedule(context)),
                      physics: const ScrollPhysics(),
                      itemCount: scheduleDataFuture!.length,
                      itemBuilder: (context, i) {
                        /* //  itemList.add(scheduleDataFuture[i]!);
                        if (i >= 10) {
                          // Don't trigger if one async loading is already under way

                          return const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }*/
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,

                                      /// Pass compactor schedule data
                                      child: CompactorPanelScheduleMain(
                                          data: scheduleDataFuture[i],
                                          idx: i)));
                              //print("index clicked ${i - 1}");
                            },
                            child: buildTabletCard(
                                CompactorPanelMyTaskListDetails(
                                    data: scheduleDataFuture[i],
                                    button: false,
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

  bool isLoading = false;
/*
  Widget _loader() {
    return isLoading
        ? const Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
              width: 70.0,
              height: 70.0,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(child: CircularProgressIndicator())),
            ),
          )
        : const SizedBox(
            width: 0.0,
            height: 0.0,
          );
  }*/
}
