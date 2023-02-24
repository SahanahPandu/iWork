import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../models/report/report_details/report_details_info.dart';
import '../../../../screens/reports/report_form.dart';
import '../../../../screens/reports/report_list_details.dart';
import '../../../../screens/schedule_issue/report/report_approval/report_approval.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../app_bar/app_bar_widget.dart';

class ReportListTileDetail extends StatelessWidget {
  const ReportListTileDetail({Key? key, required this.report})
      : super(key: key);
  final ReportDetailsInfo report;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        userRole == 100
            ? Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: Scaffold(
                      backgroundColor: white,
                      appBar: AppBarWidget(
                          title: "L${report.id}",
                          leadingIcon: CustomIcon.arrowBack),
                      body: ReportForm(
                        screen: "4",
                        // passData: widget.passData,
                        data: report,
                      ),
                    )))
            : Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ReportApproval(reportId: report.id)));
        //print("index clicked ${i - 1}");
      },
      child: buildTabletCard(ReportListDetails(data: report)),
    ); // Card
  }

  Padding buildTabletCard(redirect) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: cardListShadowColor.withOpacity(0.06),
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                      spreadRadius: 0.5)
                ]),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: redirect)));
  }
}
