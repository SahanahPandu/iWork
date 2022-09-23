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
                  getInfo: widget.laluanData!, getIssue: widget.issueType))),
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
        issueTypeStr = "Perincian Laluan";
        break;
    }
  }
}
