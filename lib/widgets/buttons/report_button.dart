import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../models/laluan.dart';
import '../../screens/reports/reports.dart';
import '../../utils/custom_icon.dart';

class ReportButton extends StatefulWidget {
  final Laluan? dataLaluan;

  const ReportButton({Key? key, required this.dataLaluan}) : super(key: key);

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xffE04141),
      child: const Icon(
        CustomIcon.exclamation,
        size: 24,
      ),
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: ReportsPage(
                  screen: "3",
                  data: null,
                  dataLaluan: widget.dataLaluan!,
                )));
      },
    );
  }
}
