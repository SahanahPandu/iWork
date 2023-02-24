/// LIST OF REPORTS FOR TABBARVIEW (MOBILE APP) DISPLAY
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/orientations.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';
import '../../widgets/listview/card_list_view.dart';
import '../../widgets/paging/report/compactor_sv_report_list_main.dart';

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
      child: userRole == 100
          ? Stack(
              children: [
                Padding(
                  padding: Orientations().isTabletPortrait(context)
                      ? const EdgeInsets.only(left: 5, right: 5, top: 60)
                      : const EdgeInsets.only(left: 45, right: 45, top: 60),
                  child: CompactorSVReportListMain(passData: {
                    "mainRoute": widget.passData.mainRoute,
                  }),
                ),
                Container(
                  padding: Orientations().isTabletPortrait(context)
                      ? const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10)
                      : const EdgeInsets.fromLTRB(60, 20, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Senarai Laporan: ",
                        style: TextStyle(
                          color: Color(0xff2B2B2B),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        tooltip: "Pilih untuk buat tapisan laporan",
                        splashColor: transparent,
                        highlightColor: transparent,
                        onPressed: () {},
                        icon: Icon(
                          CustomIcon.filter,
                          color: blackCustom,
                          size: 13,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
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
                      passData: widget.passData,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
