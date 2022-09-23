import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../config/palette.dart';
import '../../models/laluan.dart';
import '../../utils/custom_icon.dart';
import '../../utils/device.dart';
import 'schedule_issue_detail.dart';

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
    return Container(
      height: Devices().screenHeight(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3298F8),
            Color(0xff4A39BE),
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Scaffold(
          backgroundColor: transparent,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: white,
                statusBarIconBrightness: Brightness.dark, //android
                statusBarBrightness: Brightness.light //ios
                ),
            backgroundColor: transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack, color: white, size: 22),
            ),
            title: Center(
              child: Text(
                issueTypeStr,
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: const [
              SizedBox(
                width: 50,
              )
            ],
          ),
          body: ScrollConfiguration(
              behavior:
                  const MaterialScrollBehavior().copyWith(overscroll: false),
              child: ScheduleIssueDetail(
                  getInfo: widget.laluanData!, getIssue: widget.issueType))

          /*Stack(children: [
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
                      const Padding(
                        padding: EdgeInsets.all(10),
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
        ]),*/
          ),
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
        issueTypeStr = "Belum";
        break;
    }
  }
}
