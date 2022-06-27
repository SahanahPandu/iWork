import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return _device.isPhone()
        ? const Pra()
        : const CompactorPanel();
  }
}
