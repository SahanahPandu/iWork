import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../config/palette.dart';
import '../../models/task/supervisor/supervisor_task.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import 'schedule_issue_detail.dart';

class ScheduleIssueMainScreen extends StatefulWidget {
  final Isu? laluanData;
  final String issueType;

  const ScheduleIssueMainScreen(
      {Key? key, this.laluanData, required this.issueType})
      : super(key: key);

  @override
  State<ScheduleIssueMainScreen> createState() => _ScheduleIssueMainScreen();
}

class _ScheduleIssueMainScreen extends State<ScheduleIssueMainScreen> {
  bool buttonVisibility = false;
  String issueTypeStr = "";

  @override
  void initState() {
    _filterIssueType();
    super.initState();
  }

  void updateVisibility() {
    setState(() {
      buttonVisibility = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes().screenHeight(context),
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
              getInfo: widget.laluanData!,
              getIssue: widget.issueType,
            )),
        bottomNavigationBar: widget.issueType == "IHD"

            /// kehadiran
            // ? SizedBox(
            //     height: Sizes().screenHeight(context) * 0.1,
            //     child: const BottomAppBar(
            //       elevation: 40,
            //       color: Colors.white,
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            //         child: SahkanGantiPekerjaButton(),
            //       ),
            //     ),
            //   )
            ? null
            : null,
      ),
      // ),
    );
  }

  void _filterIssueType() {
    switch (widget.issueType) {
      case "IHD":
        issueTypeStr = "Kehadiran";
        break;
      case "ILHK":
        issueTypeStr = "Laporan";
        break;
      case "IBMT":
        issueTypeStr = "Perincian Laluan";
        break;
    }
  }
}
