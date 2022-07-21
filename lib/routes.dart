import 'package:flutter/material.dart';

import 'package:eswm/root.dart';
import 'package:eswm/screens/compactor_panel/compactor_panel.dart';
import 'package:eswm/screens/home/home.dart';
import 'package:eswm/screens/login/login.dart';
import 'package:eswm/screens/pra/pra.dart';
import 'package:eswm/screens/supervisor/supervisor.dart';
class Routes {
  static const ROUTE_ROOT = "/";
  static const ROUTE_LOGIN = "/login";
  static const ROUTE_HOME = "/home";
  static const ROUTE_COMP = "/comp";
  static const ROUTE_PRA = "/pra";
  static const ROUTE_SV = "/sv";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_ROOT:
        const page = Root();
        return MaterialPageRoute(builder: (context) => page);
      case ROUTE_LOGIN:
        const page = LoginScreen();
        return MaterialPageRoute(builder: (context) => page);
      case ROUTE_HOME:
        var page = const HomeScreen();
        return MaterialPageRoute(builder: (context) => page);
      case ROUTE_COMP:
        const page = CompactorPanel();
        return MaterialPageRoute(builder: (context) => page);
      case ROUTE_PRA:
        const page = Pra();
        return MaterialPageRoute(builder: (context) => page);
      case ROUTE_SV:
        const page = Supervisor();
        return MaterialPageRoute(builder: (context) => page);
      default:
        return MaterialPageRoute(builder: (context) => const Root());
    }
  }
}