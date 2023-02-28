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

  static void clearLoginCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userInfo');
    userInfo.clear();
  }

  Future<void> saveOfflinePosition(String encodedData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('offline_loc_key', encodedData);
  }

  Future<String?> restoreOfflinePositions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? locsString = prefs.getString('offline_loc_key');
    return locsString;
  }

  Future<void> clearOfflinePositions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('offline_loc_key');
  }
}
