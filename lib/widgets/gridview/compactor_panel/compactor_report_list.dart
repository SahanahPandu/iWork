import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../providers/reports_api.dart';
import '../../../screens/reports/report_form.dart';
import '../../../screens/reports/report_list_details.dart';
import '../../app_bar/app_bar_widget.dart';

class CompactorReportList extends StatefulWidget {
  const CompactorReportList({Key? key}) : super(key: key);

  @override
  State<CompactorReportList> createState() => _CompactorReportListState();
}

class _CompactorReportListState extends State<CompactorReportList> {
  late Future<List> _loadReportData;

  @override
  void initState() {
    super.initState();
    _loadReportData = ReportsApi.getReportsData(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _loadReportData,
      builder: (context, snapshot) {
        final reportDataFuture = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: axisSpacing(context),
                  mainAxisSpacing: axisSpacing(context),
                  childAspectRatio: gridRatioReport(context)),
              itemCount: reportDataFuture!.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Scaffold(
                                backgroundColor: white,
                                appBar: AppBarWidget(
                                    title: "L${reportDataFuture[i].id}"),
                                body: ReportForm(
                                    screen: "4",
                                    data: reportDataFuture[i],
                                    dataLaluan: null),
                              )));
                      //print("index clicked ${i - 1}");
                    },
                    child: buildTabletCard(ReportListDetails(
                        index: i, data: reportDataFuture[i])));
              },
            );
        }
      },
    );
  }

  //------------------------------------------------------
  // Build card details for report lists.
  //------------------------------------------------------
  SizedBox buildTabletCard(redirect) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(15),
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: redirect),
        ),
      ),
    );
  }
}
