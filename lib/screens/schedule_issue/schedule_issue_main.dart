import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../models/laluan.dart';
import '../../utils/custom_icon.dart';
import '../../widgets/buttons/sahkan_ganti_pekerja.dart';
import '../../widgets/cards/issued_task/schedule_issue_card.dart';
import '../../widgets/listview/card_list_view.dart';

class ScheduleIssueMainScreen extends StatefulWidget {
  final Laluan? laluanData;
  final bool fromHome;
  final String issueType;

  const ScheduleIssueMainScreen(
      {Key? key,
      this.laluanData,
      required this.fromHome,
      required this.issueType})
      : super(key: key);

  @override
  State<ScheduleIssueMainScreen> createState() => _ScheduleIssueMainScreen();
}

class _ScheduleIssueMainScreen extends State<ScheduleIssueMainScreen> {
  String issueTypeStr = "";

  @override
  void initState() {
    super.initState();
    _filterIssueType();
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
              icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
            ),
            title: Center(
              child: Text(
                issueTypeStr,
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
      body: Stack(children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: widget.fromHome == true
              ? ScheduleIssuedCard(
                  getInfo: widget.laluanData!, getIssue: widget.issueType)
              : //Change here for listing types, from app drawer
              Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: Text(
                        "Senarai Laporan Hari Ini:",
                        style: TextStyle(
                            color: blackCustom,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CardListView(type: "Laporan"),
                    ),
                  ],
                ),
        ),
        if (widget.fromHome == true && widget.issueType == "kehadiran")
          Positioned(
            bottom: 0,
            child: Material(
              elevation: 50,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const SahkanGantiPekerjaButton(),
                  ),
                ),
              ),
            ),
          ),
      ]),
    );
  }

  void _filterIssueType() {
    switch (widget.issueType) {
      case "kehadiran":
        issueTypeStr = "Kehadiran";
        break;
      case "laporan":
        issueTypeStr = "Laporan";
        break;
      case "belum":
        issueTypeStr = "Isu";
        break;
    }
  }
}
