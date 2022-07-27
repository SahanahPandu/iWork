import 'package:flutter/material.dart';

import 'package:eswm/root.dart';
import 'package:eswm/screens/compactor_panel/compactor_panel.dart';
import 'package:eswm/screens/home/home.dart';
import 'package:eswm/screens/login/login.dart';
import 'package:eswm/screens/pra/pra.dart';
import 'package:eswm/screens/supervisor/supervisor.dart';

class Routes {
  static const routeRoot = "/";
  static const routeLogin = "/login";
  static const routeHome = "/home";
  static const routeComp = "/comp";
  static const routePra = "/pra";
  static const routeSv = "/sv";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeRoot:
        const page = Root();
        return MaterialPageRoute(builder: (context) => page);
      case routeLogin:
        const page = LoginScreen();
        return MaterialPageRoute(builder: (context) => page);
      case routeHome:
        var page = const HomeScreen();
        return MaterialPageRoute(builder: (context) => page);
      case routeComp:
        const page = CompactorPanel();
        return MaterialPageRoute(builder: (context) => page);
      case routePra:
        const page = Pra();
        return MaterialPageRoute(builder: (context) => page);
      case routeSv:
        const page = Supervisor();
        return MaterialPageRoute(builder: (context) => page);
      default:
        return MaterialPageRoute(builder: (context) => const Root());
    }
  }
}