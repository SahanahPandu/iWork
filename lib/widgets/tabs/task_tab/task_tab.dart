import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import 'supervisor/issue_tab_bar_view.dart';
import 'supervisor/verification_tab_bar_view.dart';

class TaskStackOverTab extends StatefulWidget {
  const TaskStackOverTab({Key? key}) : super(key: key);

  @override
  TaskStackOverTabState createState() => TaskStackOverTabState();
}

class TaskStackOverTabState extends State<TaskStackOverTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        children: [
          Container(
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                IssueTabbarView(),
                VerifyTabbarView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
