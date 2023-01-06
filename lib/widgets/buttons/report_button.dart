import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
// import '../../models/laluan.dart';
import '../../screens/reports/reports.dart';
import '../../utils/icon/custom_icon.dart';
// import '../../models/report/report_list/report_details.dart';

class ReportButton extends StatefulWidget {
  final dynamic passData;

  const ReportButton({Key? key, required this.passData}) : super(key: key);

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xffE04141),
      highlightElevation: 0,
      splashColor: const Color(0xffc90000),
      elevation: 0,
      tooltip: "Tekan untuk lapor isu bagi laluan ini",
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: ReportsPage(
                  screen: "3",
                  passData: widget.passData,
                )));
      },
      child: const Icon(
        CustomIcon.exclamation,
        size: 24,
      ),
    );
  }
}
