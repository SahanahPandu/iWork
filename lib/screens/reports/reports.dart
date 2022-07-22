// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import '../../models/reports.dart';
import 'package:eswm/config/string.dart';
import 'package:eswm/widgets/tabs/tabs.dart';

class ReportsPage extends StatefulWidget {
  String screen;
  Reports data;

  ReportsPage({Key? key, required this.screen, required this.data})
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
    );
  }
}
