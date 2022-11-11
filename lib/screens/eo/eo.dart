import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/calendar/date.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../widgets/tabs/task_tab/task_tab.dart';

class EO extends StatefulWidget {
  const EO({Key? key}) : super(key: key);

  @override
  State<EO> createState() => _EOState();
}

class _EOState extends State<EO> {
  @override
  Widget build(BuildContext context) {
    return ExpandCollapseHeader(
        centerTitle: false,
        title: _collapseTitle(),
        alwaysShowLeadingAndAction: false,
        headerWidget: _header(context),
        collapseHeight: 85,
        headerExpandedHeight: 0.48,
        fullyStretchable: true,
        body: [_scrollBody()],
        backgroundColor: transparent,
        appBarColor: const Color(0xff2b7fe8));
  }

  SafeArea _scrollBody() {
    return SafeArea(
        child: Container(color: white, child: const TaskStackOverTab()));
  }

  Row _collapseTitle() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            backgroundColor: white54,
            radius: 18,
            child: const CircleAvatar(
              backgroundImage: NetworkImage("https://i.imgur.com/JFHjdNr.jpg"),
              radius: 16,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: white54,
                  radius: 18,
                  child: const CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://i.imgur.com/JFHjdNr.jpg"),
                    radius: 16,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Hi, Muhammad Hakim!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TodayTaskCard(),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
