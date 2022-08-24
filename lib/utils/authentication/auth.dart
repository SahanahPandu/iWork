import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import files
import 'package:eswm/utils/authentication/role.dart';

class Auth {
  static Future<void> handleLogin(String userID, int? role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userID", userID);
    prefs.setInt("role", role ?? 0);
  }

  static void handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userID");
    prefs.remove("role");
  }

  static int? validateCredential(String id, String password) {
    if (Device.get().isTablet) {
      if (id == "comp" && password == "1234") {
        return Roles.setRole(id);
      }
      return 0;
    } else if (Device.get().isPhone) {
      if (id == "pra" ||
          id == "sv" ||
          id == "eo" ||
          id == "ba" ||
          id == "sam" ||
          id == "rom" ||
          id == "mech") {
        if (password == "1234") {
          return Roles.setRole(id);
        }
        return 0;
      } else {
        return 0;
      }
    }
    return 0;
  }

  static Future<String> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('userID') ?? "");
  }
}
