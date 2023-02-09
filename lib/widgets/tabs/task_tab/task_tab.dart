import 'package:eswm/utils/device/sizes.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../config/palette.dart';
import '../../../config/resource.dart';
import '../../../models/task/supervisor/supervisor_task.dart';
import '../../../screens/schedule_verification/schedule_verification_main.dart';
import '../../../utils/icon/custom_icon.dart';
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

  @override
  void initState() {
    _tabController =
        TabController(length: 2, animationDuration: Duration.zero, vsync: this);
    defaultTab.value = true;
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
                  defaultTab.value = true;
                } else {
                  defaultTab.value = false;
                }
              },
              tabs: const [
                Tab(
                  text: 'Isu',
                ),
                Tab(
                  text: 'Pengesahan',
                ),
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
                      constraints: const BoxConstraints(minHeight: 310),
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
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        constraints: const BoxConstraints(minHeight: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CustomIcon.exclamation,
                                color: Colors.orange, size: 14),
                            const SizedBox(width: 10),
                            Text("Tiada isu untuk diambil tindakan.",
                                style: TextStyle(color: grey500)),
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return displayOpsButton(context);
                }
              } else {
                if (isTaskDataFetched) {
                  if (widget.scheduleData!.data.sah != null) {
                    isTaskExist = true;

                    /// Verification cards listing
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        color: white,
                        child: const ScheduleVerificationMain());
                  } else {
                    isTaskExist = false;
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        constraints: const BoxConstraints(minHeight: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CustomIcon.exclamation,
                                color: Colors.orange, size: 14),
                            const SizedBox(width: 10),
                            Text("Tiada tugasan untuk disah",
                                style: TextStyle(color: grey500)),
                          ],
                        ),
                      ),
                    );
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

  Container displayOpsButton(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: (Sizes().screenHeight(context) * 0.48) - kToolbarHeight),
      //height: (Sizes().screenHeight(context) * 0.5) - kToolbarHeight,
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
