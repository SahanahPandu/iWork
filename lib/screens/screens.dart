import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

//import files
import '../config/config.dart';
import '../config/resource.dart';
import '../config/string.dart';
import 'ba/ba.dart';
import 'compactor_panel/compactor_panel.dart';
import 'eo/eo.dart';
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
    userRole != 100
        ? SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ])
        : null;
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
      case 400:
        return const EO();
      case 500:
        return const BA();
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
