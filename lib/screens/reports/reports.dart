import 'package:flutter/material.dart';

//import files
import '../../config/string.dart';
import '../../widgets/tabs/tabs.dart';

class ReportsPage extends StatefulWidget {
  final String screen;
  final dynamic data;
  final dynamic dataLaluan;

  const ReportsPage(
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
      title: reports,
      dataLaluan: widget.dataLaluan,
    );
  }
}
