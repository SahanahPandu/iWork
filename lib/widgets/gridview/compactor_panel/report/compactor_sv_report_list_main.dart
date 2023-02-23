import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../models/report/report_list/report_paging.dart';
import '../../../../providers/report/reports_api.dart';
import '../../../../utils/icon/custom_icon.dart';
import 'report_list_tile.dart';

class CompactorSVReportListMain extends StatelessWidget {
  final Map<String, Object?>? passData;

  const CompactorSVReportListMain({Key? key, this.passData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    refreshReportList.value = !refreshReportList.value;
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? child) {
        if (value == refreshReportList.value) {
          return FutureBuilder<ReportPaging>(
              future: ReportsApi.fetchReportList(context, 1, passData),
              builder: (context, snapshots) {
                if (snapshots.hasError) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CustomIcon.exclamation,
                              color: Colors.redAccent, size: 14),
                          const SizedBox(width: 10),
                          Text(
                              "Terdapat masalah sambungan Internet. Sila cuba lagi.",
                              style: TextStyle(color: grey500)),
                        ],
                      ),
                    ),
                  );
                }
                switch (snapshots.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshots.data == null ||
                        snapshots.data!.data! == null) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(CustomIcon.exclamation,
                                  color: Colors.orange, size: 14),
                              const SizedBox(width: 10),
                              Text("Tiada rekod dijumpai",
                                  style: TextStyle(color: grey500)),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ReportListTile(
                          reports: snapshots.data!, passData: passData);
                    }

                  default:
                    return Container();
                }
              });
        }
        return Container();
      },
      valueListenable: refreshReportList,
    );
  }
}
