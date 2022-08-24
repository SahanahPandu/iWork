import 'package:shared_preferences/shared_preferences.dart';

//import files
import '../../config/config.dart';

class Roles {
  static const roleComp = "comp";
  static const rolePra = "pra";
  static const roleSv = "sv";
  static const roleEo = "eo";
  static const roleBa = "ba";
  static const roleSam = "sam";
  static const roleRom = "rom";
  static const roleMech = "mech";

  static int? setRole(String roleID) {
    switch (roleID) {
      case roleComp:
        return userRole = 100;
      case rolePra:
        return userRole = 200;
      case roleSv:
        return userRole = 300;
      case roleEo:
        return userRole = 400;
      case roleBa:
        return userRole = 500;
      case roleSam:
        return userRole = 600;
      case roleRom:
        return userRole = 700;
      case roleMech:
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
