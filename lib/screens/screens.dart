import 'package:eswm/screens/compactor_panel/compactor_panel.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

//import files
import 'package:eswm/screens/pra/pra.dart';

import '../utils/device.dart';
import 'package:eswm/screens/compactor_panel/compactor_panel.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {

  final Devices _device = Devices();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ms', null); //very important
  }

  @override
  Widget build(BuildContext context) {
    return _device.isPhone()
        ? const Pra()
        : const CompactorPanel();
  }
}
