// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import '../../models/reports.dart';
import 'package:eswm/config/string.dart';
import 'package:eswm/widgets/tabs/tabs.dart';

class ReportsPage extends StatefulWidget {
  String screen;
  Reports data;
  dynamic dataLaluan;

  ReportsPage(
      {Key? key,
      required this.screen,
      required this.data,
      required this.dataLaluan})
      : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Tabs(
      screen: widget.screen,
      data: widget.data,
      tabTitle: reports,
      dataLaluan: widget.dataLaluan,
    );
  }
}
