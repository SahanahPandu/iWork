import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/date.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/listview/card_list_view.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';

class Pra extends StatefulWidget {
  const Pra({Key? key}) : super(key: key);

  @override
  State<Pra> createState() => _PraState();
}

class _PraState extends State<Pra> {

  @override
  Widget build(BuildContext context) {
    return ExpandCollapseHeader(
        centerTitle: false,
        title: _collapseTitle(),
        alwaysShowLeadingAndAction: false,
        headerWidget: _header(context),
        fullyStretchable: true,
        body: [
          _scrollBody(),
        ],
        headerExpandedHeight: 0.48,
        fixedTitle: _fixedTitle(context),
        fixedTitleHeight: 60,
        backgroundColor: transparent,
        appBarColor: const Color(0xff2b7fe8));
  }

  SafeArea _scrollBody() {
    return SafeArea(
        child: Container(
      constraints: const BoxConstraints(minHeight: 280),
      color: white,
      padding: const EdgeInsets.all(15),
      child: const CardListView(type: "Laluan"),
    ));
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
                  "https://www.fortisconstruction.com/images/uploads/people/_small-grid/arnel_cabais_headshot.jpg"),
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
                        "https://www.fortisconstruction.com/images/uploads/people/_small-grid/arnel_cabais_headshot.jpg"),
                    radius: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Hi, Ahmad!",
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

  Widget _fixedTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          "Tugas Saya",
          style: TextStyle(
            color: blackCustom,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
