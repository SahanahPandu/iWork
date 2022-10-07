import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../screens/schedule_verification/schedule_verification_main.dart';
import '../../listview/card_list_view.dart';

/// temporarily disable tabBarView
//import 'supervisor/issue_tab_bar_view.dart';
//import 'supervisor/verification_tab_bar_view.dart';

class TaskStackOverTab extends StatefulWidget {
  const TaskStackOverTab({Key? key}) : super(key: key);

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
                /// Issue cards listing
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  constraints: const BoxConstraints(minHeight: 500),
                  child: Column(
                    children: const [
                      SizedBox(height: 10),
                      CardListView(type: 'Laluan', screens: "isu"),
                    ],
                  ),
                );
              } else {
                /// Verification cards listing
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: white,
                    child: const ScheduleVerificationMain());
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
}
