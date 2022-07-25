// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import 'package:eswm/screens/e_cuti/leave_form.dart';
import 'package:eswm/screens/e_cuti/leave_list.dart';
import 'package:eswm/screens/reports/report_form.dart';
import 'package:eswm/screens/reports/report_list.dart';

class Tabs extends StatefulWidget {
  String screen;
  dynamic data;
  String tabTitle;

  Tabs(
      {Key? key,
      required this.screen,
      required this.data,
      required this.tabTitle})
      : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  getTabView() {
    if (widget.screen == "1" || widget.screen == "2") {
      // e_cuti
      //screen = "1" - ecuti button , screen ="2" -  from leave list

      return TabBarView(children: [
        LeaveForm(screen: widget.screen, data: widget.data),
        const LeaveList(),
      ]);
    } else if (widget.screen == "3" || widget.screen == "4") {
      //reports
      //screen = "3" - report button (work schedule), screen = "4" - from record list

      return const TabBarView(children: [
        ReportForm(),
        ReportList(),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBackgroundColor,
          elevation: 4,
          shadowColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.tabTitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: grey900,
            ),
          ),
          bottom: TabBar(
            labelColor: grey900,
            unselectedLabelColor: Colors.black54,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: Colors.green,
              ),
              insets: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            tabs: const [
              Tab(
                child: Text(
                  "Borang",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Rekod",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: getTabView(),
      ),
    );
  }
}
