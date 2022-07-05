import 'package:eswm/screens/home/home.dart';
import 'package:eswm/screens/login/login.dart';
import 'package:flutter/animation.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor(
    options: const SailorOptions(handleNameNotFoundUI: true, isLoggingEnabled: true, defaultTransitions: [SailorTransition.fade_in,
    SailorTransition.slide_from_right], defaultTransitionDuration: Duration(milliseconds: 500), defaultTransitionCurve: Curves.decelerate),
  );

  static void createRoutes() async {
    sailor.addRoutes([
      SailorRoute(
        name: "loginScreenRoute",
        builder: (context, args, params) {
          return const LoginScreen();
        },
      ),
      SailorRoute(
        name: "homeUserRoute",
        builder: (context, args, params) {
          return const HomeScreen();
        },
      )
    ]);
  }
}