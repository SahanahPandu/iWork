import 'package:eswm/utils/device/sizes.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../config/palette.dart';
import '../../../config/resource.dart';
import '../../../models/task/supervisor/supervisor_task.dart';
import '../../../screens/schedule_verification/schedule_verification_main.dart';
import '../../cards/list_card.dart';

/// temporarily disable tabBarView
//import 'supervisor/issue_tab_bar_view.dart';
//import 'supervisor/verification_tab_bar_view.dart';

class TaskStackOverTab extends StatefulWidget {
  final SupervisorTask? scheduleData;

  const TaskStackOverTab({Key? key, this.scheduleData}) : super(key: key);

  @override
  TaskStackOverTabState createState() => TaskStackOverTabState();
}

class TaskStackOverTabState extends State<TaskStackOverTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<bool> defaultTab = ValueNotifier(false);
  int sahLength = 0;
  Color isuBox = lightBlue;
  Color isuText = darkBlue;
  Color sahBox = grey300;
  Color sahText = grey500;
  Duration duration = const Duration(milliseconds: 300);
  double distance = 24.0;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, animationDuration: Duration.zero, vsync: this);
    defaultTab.value = true;
    int isAttendance = widget.scheduleData!.data.sah != null &&
            widget.scheduleData!.data.sah!.attendance!.isNotEmpty
        ? 1
        : 0;
    int isChecklist = widget.scheduleData!.data.sah != null &&
            widget.scheduleData!.data.sah!.checklist!.isNotEmpty
        ? 1
        : 0;
    int isWorkerRequest = widget.scheduleData!.data.sah != null &&
            widget.scheduleData!.data.sah!.workerRequest!.isNotEmpty
        ? 1
        : 0;
    sahLength = widget.scheduleData!.data.sah != null
        ? isAttendance + isChecklist + isWorkerRequest
        : 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: tabBoxColor,
              borderRadius: BorderRadius.circular(
                46,
              ),
            ),
            child: TabBar(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              controller: _tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    46,
                  ),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: tabShadowColor,
                      blurRadius: 2,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ]),
              labelColor: blackCustom,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              unselectedLabelColor: greyCustom,
              onTap: (index) {
                if (index == 0) {
                  setState(() {
                    defaultTab.value = true;
                    isuBox = lightBlue;
                    isuText = darkBlue;
                    sahBox = grey300;
                    sahText = grey500;
                  });
                } else {
                  setState(() {
                    defaultTab.value = false;
                    isuBox = grey300;
                    isuText = grey500;
                    sahBox = lightBlue;
                    sahText = darkBlue;
                  });
                }
              },
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Isu"),
                      const SizedBox(width: 6),
                      widget.scheduleData!.data.isu != null &&
                              widget.scheduleData!.data.isu!.isNotEmpty
                          ? Container(
                              height: 15,
                              width: 14,
                              decoration: BoxDecoration(
                                color: isuBox,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                    widget.scheduleData!.data.isu!.length
                                        .toString(),
                                    style: TextStyle(
                                        color: isuText,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500)),
                              ))
                          : Container()
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Pengesahan"),
                      const SizedBox(width: 6),
                      sahLength > 0
                          ? Container(
                              height: 15,
                              width: 14,
                              decoration: BoxDecoration(
                                color: sahBox,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(sahLength.toString(),
                                    style: TextStyle(
                                        color: sahText,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500)),
                              ))
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: defaultTab,
            builder: (BuildContext context, value, Widget? child) {
              if (value == true) {
                if (isTaskDataFetched) {
                  if (widget.scheduleData!.data.isu!.isNotEmpty) {
                    isTaskExist = true;

                    /// Issue cards listing
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      constraints: BoxConstraints(
                          minHeight: Sizes().screenHeight(context) * 0.46 -
                              kToolbarHeight),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.scheduleData!.data.isu!.length,
                            itemBuilder: (context, index) {
                              return ListCard(
                                data: widget.scheduleData!.data.isu![index],
                                type: "Laluan",
                                screen: "isu",
                                listIndex: index,
                              );
                            },
                          ),
                          //CardListView(type: 'Laluan', passData: widget.scheduleData, screens: "isu"),
                        ],
                      ),
                    );
                  } else {
                    isTaskExist = false;
                    return _displayNoTask(context,
                        "Tiada isu perlu diselesaikan\npada ${widget.scheduleData!.data.scheduleDate!}");
                  }
                } else {
                  return displayOpsButton(context);
                }
              } else {
                if (isTaskDataFetched) {
                  if (widget.scheduleData!.data.sah != null &&
                      (widget.scheduleData!.data.sah!.checklist!.isNotEmpty ||
                          widget
                              .scheduleData!.data.sah!.attendance!.isNotEmpty ||
                          widget.scheduleData!.data.sah!.workerRequest!
                              .isNotEmpty)) {
                    isTaskExist = true;

                    /// Verification cards listing
                    return Container(
                        constraints: BoxConstraints(
                            minHeight: Sizes().screenHeight(context) * 0.46 -
                                kToolbarHeight),
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                        color: white,
                        child: ScheduleVerificationMain(
                            sahData: widget.scheduleData!.data.sah));
                  } else {
                    isTaskExist = false;
                    return _displayNoTask(context,
                        "Tiada pengesahan perlu diselesaikan\npada ${widget.scheduleData!.data.scheduleDate!}");
                  }
                } else {
                  return displayOpsButton(context);
                }
              }
            }),

        /// temporarily disable tabBarView
        /*SizedBox(
          height: 1000,
          child: TabBarView(
            controller: _tabController,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: IssueTabbarView(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: VerifyTabbarView(),
              ),
            ],
          ),
        ),*/
      ],
    );
  }

  Container _displayNoTask(BuildContext context, String str) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      constraints: BoxConstraints(
          minHeight: Sizes().screenHeight(context) * 0.46 - kToolbarHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 160, child: Image.asset(noApproval)),
          const SizedBox(height: 20),
          Text(str,
              style: TextStyle(color: grey500, height: 1.5, fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Container displayOpsButton(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: (Sizes().screenHeight(context) * 0.46) - kToolbarHeight),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 78, width: 78, child: Image.asset(opsImg)),
            SizedBox(
              height: 40,
              width: 180,
              child: TextButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0x0f0c057a)),
                    backgroundColor: MaterialStateProperty.all(transparent)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sila Muat Semula",
                      style: TextStyle(
                          color: grey500,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.refresh, size: 18, color: blue),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    refresh.value = !refresh.value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
