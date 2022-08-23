import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:eswm/root.dart';
import 'package:eswm/screens/compactor_panel/compactor_panel.dart';
import 'package:eswm/screens/home/home.dart';
import 'package:eswm/screens/login/login.dart';
import 'package:eswm/screens/pra/pra.dart';
import 'package:eswm/screens/supervisor/supervisor.dart';
import 'package:eswm/screens/notifications/notifications.dart';
import 'package:eswm/screens/splash/splash_main.dart';

class Routes {
  static const routeRoot = "/";
  static const routeLogin = "/login";
  static const routeHome = "/home";
  static const routeComp = "/comp";
  static const routePra = "/pra";
  static const routeSv = "/sv";
  static const routeSplash = "/splash";
  static const routeNotification = "/notification";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeRoot:
        const page = Root();
        return PageTransition(child: page, type: PageTransitionType.fade);
      case routeLogin:
        const page = LoginScreen();
        return PageTransition(child: page, type: PageTransitionType.fade);
      case routeHome:
        var page = const HomeScreen();
        return PageTransition(child: page, type: PageTransitionType.fade);
      case routeComp:
        const page = CompactorPanel();
        return PageTransition(child: page, type: PageTransitionType.fade);
      case routePra:
        const page = Pra();
        return PageTransition(child: page, type: PageTransitionType.fade);
      case routeSv:
        const page = Supervisor();
        return PageTransition(child: page, type: PageTransitionType.fade);
      case routeSplash:
        const page = SplashMain();
        return PageTransition(child: page, type: PageTransitionType.fade);
      case routeNotification:
        const page = Notifications();
        return PageTransition(child: page, type: PageTransitionType.fade);
      default:
        return PageTransition(
            child: const Root(),
            type: PageTransitionType.fade,
            settings: settings);
    }
  }
}