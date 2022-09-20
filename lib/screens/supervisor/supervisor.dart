import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../widgets/tabs/task_tab/task_tab.dart';

class Supervisor extends StatefulWidget {
  const Supervisor({Key? key}) : super(key: key);

  @override
  State<Supervisor> createState() => _SupervisorState();
}

class _SupervisorState extends State<Supervisor> {
  @override
  Widget build(BuildContext context) {
    return ExpandCollapseHeader(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Tugasan Hari Ini (9.00 pg - 5.00 ptg)",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "15 September 2022",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        alwaysShowLeadingAndAction: false,
        headerWidget: _header(context),
        fullyStretchable: true,
        body: [
          SafeArea(
              child: Container(
                  height: 860, color: white, child: const TaskStackOverTab())),
        ],
        backgroundColor: transparent,
        appBarColor: const Color(0xff2b7fe8));
  }

  Widget _header(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 5),
            child: Text(
              "Hi, Suhaimi!",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              //height: Devices().screenHeight(context) * 0.26,
              child: TodayTaskCard(),
            ),
          ),
        ],
      ),
    );
  }
}
