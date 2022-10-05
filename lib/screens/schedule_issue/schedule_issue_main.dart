import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../config/palette.dart';
import '../../models/laluan.dart';
import '../../utils/custom_icon.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/buttons/contact_button.dart';
import '../../widgets/buttons/sahkan_ganti_pekerja.dart';
import 'schedule_issue_detail.dart';

class ScheduleIssueMainScreen extends StatefulWidget {
  final Laluan? laluanData;
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
    return
        // StateInheritedWidget(
        //   buttonVisibility: buttonVisibility,
        //   stateWidget: this,
        //   child:
        Container(
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
        floatingActionButton: widget.issueType == "belum"
            ? ContactButton(data: widget.laluanData)
            : Container(),
        bottomNavigationBar: widget.issueType == "kehadiran"
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: const BottomAppBar(
                  elevation: 40,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 17),
                    child: SahkanGantiPekerjaButton(),
                  ),
                ),
              )
            : null,
      ),
      // ),
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

//trying using inherited widget

// class StateInheritedWidget extends InheritedWidget {
//   final bool buttonVisibility;
//   final _ScheduleIssueMainScreen stateWidget;

//   const StateInheritedWidget({
//     Key? key,
//     required Widget child,
//     required this.buttonVisibility,
//     required this.stateWidget,
//   }) : super(key: key, child: child);

//   static _ScheduleIssueMainScreen? of(BuildContext context) => context
//       .dependOnInheritedWidgetOfExactType<StateInheritedWidget>()
//       ?.stateWidget;

//   @override
//   bool updateShouldNotify(StateInheritedWidget oldWidget) =>
//       oldWidget.buttonVisibility != buttonVisibility;
// }
