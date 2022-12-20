import 'package:shared_preferences/shared_preferences.dart';

//import files
import '../../config/config.dart';

class LocalPrefs {
  static Future<List<String>> restoreUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = prefs.getStringList('userInfo') ?? [];
    return userInfo;
  }

  static Future<void> saveUserInfo(List<String> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('userInfo', userInfo);
  }

  static void removeLoginCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userInfo');
    userInfo.clear();
  }
}
