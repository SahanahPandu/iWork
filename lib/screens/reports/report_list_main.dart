/// LIST OF REPORTS FOR TAB/MOBILE APP DISPLAY FROM APP DRAWER
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';
import '../../widgets/gridview/compactor_panel/compactor_report_list.dart';
import '../../widgets/listview/card_list_view.dart';

class ReportListMain extends StatefulWidget {
  const ReportListMain({Key? key}) : super(key: key);

  @override
  State<ReportListMain> createState() => _ReportListMainState();
}

class _ReportListMainState extends State<ReportListMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: barShadowColor,
                offset: const Offset(0, 3),
                blurRadius: 8,
              )
            ]),
            child: AppBar(
              backgroundColor: white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
              ),
              title: Center(
                child: Text(
                  "Laporan",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CustomIcon.filter,
                    color: blackCustom,
                    size: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                userRole != 100
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: Text(
                          "Senarai Laporan :",
                          style: TextStyle(
                              color: blackCustom,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(30, 30, 0, 15),
                        child: Text(
                          "Senarai Laporan :",
                          style: TextStyle(
                              color: blackCustom,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                userRole == 100
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: CompactorReportList(),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(12),
                        child: CardListView(
                          type: "Laporan",
                          topCardStatus: null,
                        ),
                      )
              ],
            ),
          ),
        ));
  }
}
