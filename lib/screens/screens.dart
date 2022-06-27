import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

//import files
import 'package:eswm/config/config.dart' as config;
import 'package:eswm/screens/pra/pra.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ms', null); //very important
  }

  @override
  Widget build(BuildContext context) {
    return config.userRole == 1
        ? const Pra()
        : const Text("This is not PRA section");
  }
}
