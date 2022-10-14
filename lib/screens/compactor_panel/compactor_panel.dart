import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/calendar/date.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/gridview/compactor_panel/compactor_task_list.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';

class CompactorPanel extends StatefulWidget {
  const CompactorPanel({Key? key}) : super(key: key);

  @override
  State<CompactorPanel> createState() => _CompactorPanelState();
}

class _CompactorPanelState extends State<CompactorPanel> {
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
        headerExpandedHeight:
            Orientations().isTabletPortrait(context) ? 0.35 : 0.45,
        fixedTitle: _fixedTitle(context),
        fixedTitleHeight: 70,
        collapseHeight: 148,
        collapseFade: Orientations().isTabletPortrait(context) ? 130 : 90,
        backgroundColor: transparent,
        appBarColor: Orientations().isTabletPortrait(context)
            ? const Color(0xff358af5)
            : const Color(0xff2d80e8));
  }

  SafeArea _scrollBody() {
    return SafeArea(
        child: Container(
      constraints: Orientations().isTabletPortrait(context)
          ? const BoxConstraints(minHeight: 630)
          : const BoxConstraints(minHeight: 285),
      color: white,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: const CompactorTaskList(main: true),
    ));
  }

  Row _collapseTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        const SizedBox(width: 10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
                height: 55,
                width: 100,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "BLW 7096",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.w600, fontSize: 18),
                )))),
        const SizedBox(
          height: 20,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Tugasan Hari Ini (7:00 pagi - 12:30 petang)",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            Date.getTodayDate(),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: white,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ])
      ]),
      //Senarai Staf
      Align(
          alignment: Alignment.centerRight,
          child: Container(
              alignment: Alignment.centerLeft,
              width: 200,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 30, 20),
                  child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
                      children: [
                        Positioned(
                            left: 96,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Orientations().isTabletPortrait(context)
                                            ? const Color(0xff358af5)
                                            : const Color(0xff2d80e8),
                                    radius: 28,
                                    child: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://www.fortisconstruction.com/images/uploads/people/_small-grid/arnel_cabais_headshot.jpg"),
                                      radius: 26,
                                    )))),
                        Positioned(
                            left: 48,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Orientations().isTabletPortrait(context)
                                            ? const Color(0xff358af5)
                                            : const Color(0xff2d80e8),
                                    radius: 28,
                                    child: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://www.jurispro.com/files/photos/user_4473.jpg?m=1605811497"),
                                        radius: 26)))),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CircleAvatar(
                              backgroundColor:
                                  Orientations().isTabletPortrait(context)
                                      ? const Color(0xff358af5)
                                      : const Color(0xff2d80e8),
                              radius: 28,
                              child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://miro.medium.com/max/800/1*7hkI-ZKsglnbjxCRV1bMZA.png"),
                                  radius: 26),
                            ))
                      ]))))
    ]);
  }

  Widget _header(BuildContext context) {
    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
          Padding(
            padding: EdgeInsets.only(left: 48, top: 10, bottom: 5),
            child: Text(
              "BLW 7096",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44),
            child: TodayTaskCard(),
          )
        ]));
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Text("Tugasan",
                style: TextStyle(
                  color: blackCustom,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ))));
  }
}
