import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../providers/reports_api.dart';
import '../../../screens/reports/report_list_details.dart';
import '../../../screens/reports/reports.dart';

class CompactorReportList extends StatefulWidget {
  final dynamic topCardStatus;

  const CompactorReportList({Key? key, this.topCardStatus}) : super(key: key);

  @override
  State<CompactorReportList> createState() => _CompactorReportListState();
}

class _CompactorReportListState extends State<CompactorReportList> {
  ScrollController controller = ScrollController();
  late Future<List> _loadReportData;

  @override
  void initState() {
    super.initState();
    _loadReportData = ReportsApi.getReportsData(context);
    controller.addListener(() {
      widget.topCardStatus(controller.offset > 50);
    });
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
            return Expanded(
                child: Container(
              margin: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: axisSpacing(context),
                    mainAxisSpacing: axisSpacing(context),
                    childAspectRatio: gridRatio(context)),
                physics: const BouncingScrollPhysics(),
                itemCount: reportDataFuture!.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: ReportsPage(
                                  screen: "4",
                                  data: reportDataFuture[i],
                                  dataLaluan: null,
                                )));
                        //print("index clicked ${i - 1}");
                      },
                      child: buildTabletCard(ReportListDetails(
                          index: i, data: reportDataFuture[i])));
                },
              ),
            ));
        }
      },
    );
  }

  //------------------------------------------------------
  // Build card details for vc/tasks.
  //------------------------------------------------------
  SizedBox buildTabletCard(redirect) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          //Tugasan Card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: grey500,
          elevation: 5,
          child: Padding(padding: const EdgeInsets.all(10), child: redirect),
        ),
      ),
    );
  }
}
