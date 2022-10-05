import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/date.dart';
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
        title: _collapseTitle(),
        alwaysShowLeadingAndAction: false,
        headerWidget: _header(context),
        collapseHeight: 85,
        fullyStretchable: true,
        body: [
          _scrollBody(),
        ],
        backgroundColor: transparent,
        appBarColor: const Color(0xff2b7fe8));
  }

  SafeArea _scrollBody() {
    return SafeArea(
        child: Container(
            height: 860, color: white, child: const TaskStackOverTab()));
  }

  Row _collapseTitle() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            backgroundColor: white54,
            radius: 20,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.hakuhodo-global.com/wp_admin/wp-content/uploads/2017/11/Shuntaro_Ito2square.jpg"),
              radius: 18,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              Date.getTodayDate(),
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
      ],
    );
  }

  Widget _header(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10, bottom: 5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: white54,
                  radius: 20,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.hakuhodo-global.com/wp_admin/wp-content/uploads/2017/11/Shuntaro_Ito2square.jpg"),
                    radius: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Hi, Suhaimi!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              //height: Sizes().screenHeight(context) * 0.26,
              child: TodayTaskCard(),
            ),
          ),
        ],
      ),
    );
  }
}
