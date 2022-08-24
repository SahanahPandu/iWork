import 'package:flutter/material.dart';

//import files
import '../../screens/e_cuti/leave_form.dart';
import '../../screens/e_cuti/leave_list.dart';
import '../../screens/reports/report_form.dart';
import '../../screens/reports/report_list.dart';
import '../../widgets/app_bar/app_bar_widget.dart';
import '../../config/palette.dart';

class Tabs extends StatefulWidget {
  final String screen;
  final dynamic data;
  final String title;
  final dynamic dataLaluan;

  const Tabs(
      {Key? key,
      required this.screen,
      required this.data,
      required this.title,
      required this.dataLaluan})
      : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  getTabView() {
    if (widget.screen == "1" || widget.screen == "2" || widget.screen == "5") {
      // e_cuti
      //screen = "1" - ecuti button , screen ="2" -  from leave list , screen ="5" -  E-cuti menu from drawer

      return TabBarView(
        controller: _tabController,
        children: [
          LeaveForm(screen: widget.screen, data: widget.data),
          const LeaveList(),
        ],
      );
    } else if (widget.screen == "3" ||
        widget.screen == "4" ||
        widget.screen == "6") {
      //reports
      //screen = "3" - report button (work schedule), screen = "4" - from record list , screen ="6" -  Laporan menu from drawer

      return TabBarView(
        controller: _tabController,
        children: [
          ReportForm(
            screen: widget.screen,
            data: widget.data,
            dataLaluan: widget.dataLaluan,
          ),
          const ReportList(),
        ],
      );
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.title,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 10,
          // ),
          Container(
            margin: const EdgeInsets.all(15),
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F6FF),
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              controller: _tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey400,
                      blurRadius: 2,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ]),
              labelColor: const Color(0xff2B2B2B),
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              unselectedLabelColor: const Color(0xff969696),
              tabs: const [
                Tab(
                  text: 'Borang',
                ),
                Tab(
                  text: 'Rekod',
                ),
              ],
            ),
          ),
          Expanded(
            child: getTabView(),
          ),
        ],
      ),
    );
  }
}
