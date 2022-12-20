/// LIST OF REPORTS FOR TABBARVIEW (MOBILE APP) DISPLAY
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';
import '../../widgets/gridview/compactor_panel/compactor_report_list.dart';
import '../../widgets/listview/card_list_view.dart';

class ReportList extends StatefulWidget {
  final String? screen;
  final dynamic passData;

  const ReportList({Key? key, this.screen, this.passData}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: userRole == 100
            ? Padding(
                padding: Orientations().isTabletPortrait(context)
                    ? const EdgeInsets.symmetric(horizontal: 5)
                    : const EdgeInsets.symmetric(horizontal: 50),
                child: CompactorReportList(passData: widget.passData),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 16,
                        top: widget.screen != null ? 24 : 9,
                        right: 16,
                        bottom: 24),
                    child: const Text(
                      "Senarai Laporan: ",
                      style: TextStyle(
                        color: Color(0xff2B2B2B),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: CardListView(
                      type: "Laporan",
                      topCardStatus: null,
                      passData: widget.passData,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
