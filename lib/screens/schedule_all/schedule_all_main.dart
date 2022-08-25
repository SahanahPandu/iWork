import 'package:flutter/material.dart';

//import files
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
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: barShadowColor,
              offset: const Offset(0, 3),
              blurRadius: 8,
            )
          ]),
          child: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack,
                  color: blackCustom, size: 22),
            ),
            title: Center(
              child: Text(
                "Jadual Tugasan",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CustomIcon.filter,
                  color: blackCustom,
                  size: 13,
                ),
              ),
            ],
          ),
        ),
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
                      "Senarai Laluan Tugasan :",
                      style: TextStyle(
                          color: blackCustom,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
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
