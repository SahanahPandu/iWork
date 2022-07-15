// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import 'package:eswm/screens/e_cuti/leave_form.dart';
import 'package:eswm/screens/e_cuti/leave_list.dart';
import '../../config/palette.dart';
import '../../config/string.dart';

class Tabs extends StatefulWidget {
  String screen;
  dynamic data;

  Tabs({Key? key, required this.screen, required this.data}) : super(key: key);

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
            eCuti,
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
            indicatorColor: Colors.green,
            indicatorWeight: 3,
            tabs: const [
              Tab(
                child: Text(
                  "Borang",
                  style: TextStyle(
                    //color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Rekod",
                  style: TextStyle(
                    //color: Colors.black54,
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
