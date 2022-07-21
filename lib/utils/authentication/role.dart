import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';

class Roles {
  static const ROLE_COMP = "comp";
  static const ROLE_PRA = "pra";
  static const ROLE_SV = "sv";
  static const ROLE_EO = "eo";
  static const ROLE_BA = "ba";
  static const ROLE_SAM = "sam";
  static const ROLE_ROM = "rom";
  static const ROLE_MECH = "mech";

  static int? setRole(String roleID) {
    switch (roleID) {
      case ROLE_COMP:
        return userRole = 100;
      case ROLE_PRA:
        return userRole = 200;
      case ROLE_SV:
        return userRole = 300;
      case ROLE_EO:
        return userRole = 400;
      case ROLE_BA:
        return userRole = 500;
      case ROLE_SAM:
        return userRole = 600;
      case ROLE_ROM:
        return userRole = 700;
      case ROLE_MECH:
        return userRole = 800;
      default:
        return userRole = 0;
    }
  }

  static Future<int> loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userRole = prefs.getInt('role') ?? 0;
    return userRole;
  }
}
