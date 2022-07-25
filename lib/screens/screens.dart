import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:eswm/config/config.dart';
import '../config/resource.dart';
import '../config/string.dart';
import 'compactor_panel/compactor_panel.dart';
import 'pra/pra.dart';
import 'supervisor/supervisor.dart';

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
    return _assignRoleMainScreen();
  }

  StatefulWidget _assignRoleMainScreen() {
    switch (userRole) {
      case 100:
        return const CompactorPanel();
      case 200:
        return const Pra();
      case 300:
        return const Supervisor();
      default:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(idleImg),
                Text(tryAgain),
              ],
            ),
          ),
        );
    }
  }
}
