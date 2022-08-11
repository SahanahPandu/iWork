import 'package:flutter/material.dart';

import '../../utils/custom_icon.dart';
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../widgets/gridview/compactor_panel/compactor_task_list.dart';
import '../../widgets/listview/card_list_view.dart';

class ScheduleAllMainScreen extends StatefulWidget {
  const ScheduleAllMainScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleAllMainScreen> createState() => _ScheduleIssueMainScreen();
}

class _ScheduleIssueMainScreen extends State<ScheduleAllMainScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        elevation: 1,
        shadowColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:
              Icon(CustomIcon.arrowBack, color: Colors.grey.shade900, size: 15),
        ),
        title: Center(
          child: Text(
            "Jadual Tugasan",
            style: TextStyle(
              fontSize: 18,
              color: grey800,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_alt_rounded,
              color: grey800,
              size: 22,
            ),
          ),
        ],
      ),
      body: userRole == 100
          ? Column(
              children: const [
                CompactorTaskList(isButton: false),
              ],
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: Text(
                      "Senarai Laluan Tugasan Hari Ini:",
                      style: TextStyle(
                          color: grey500,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: userRole != 200 ? 15 : 0,
                    ),
                    child: CardListView(
                      type: "Laluan",
                      screens: "drawer",
                    ),
                  ),
                ],
              )),
    );
  }
}
