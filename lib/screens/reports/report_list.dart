import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../widgets/gridview/compactor_panel/compactor_report_list.dart';
import '../../widgets/listview/card_list_view.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 16, top: 9, right: 16, bottom: 24),
            child: const Text(
              "Senarai laporan: ",
              style: TextStyle(
                color: Color(0xff2B2B2B),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          userRole == 100
              ? const CompactorReportList()
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const CardListView(
                    type: "Laporan",
                    topCardStatus: null,
                  ),
                ),
        ],
      ),
    );
  }
}
