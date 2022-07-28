// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/tabs/tabs.dart';
import 'package:eswm/config/string.dart';
import '../../models/cuti.dart';

class ECuti extends StatefulWidget {
  String screen;
  Cuti data;

  ECuti({Key? key, required this.screen, required this.data}) : super(key: key);

  @override
  State<ECuti> createState() => _ECutiState();
}

class _ECutiState extends State<ECuti> {
  @override
  Widget build(BuildContext context) {
    return Tabs(
      screen: widget.screen,
      data: widget.data,
      tabTitle: eCuti,
      dataLaluan: null,
    );
  }
}
