import 'package:flutter/material.dart';

//import files
import '../../config/string.dart';
import '../../widgets/tabs/tabs.dart';

class ReportsPage extends StatefulWidget {
  final String screen;
  final dynamic passData;

  const ReportsPage({
    Key? key,
    required this.screen,
    required this.passData,
  }) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Tabs(
      screen: widget.screen,
      passData: widget.passData,
      title: reports,
    );
  }
}
