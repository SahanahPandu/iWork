//import files
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../models/user/user_data.dart';
import '../../providers/authenticate/login_api.dart';
import '../../providers/authenticate/update_device_id_api.dart';
import '../device/devices.dart';
import '../device/uuid.dart';
import '../storage/local_pref.dart';

class Auth {
  static validateCredential(String id, String password) async {
    userDeviceId = (await Uuid().getDeviceIdentifier())!;
    // print('Current device id: $userDeviceId');
    if (Devices().isTablet() && _setUserType(id) == 3) {
      return await _getLoginResponse(id, password, 3, userDeviceId);
    } else if (Devices().isPhone()) {
      if (_setUserType(id) == 1) {
        return await _getLoginResponse(id, password, 1, userDeviceId);
      } else if (_setUserType(id) == 2) {
        return await _getLoginResponse(id, password, 2, userDeviceId);
      } else {
        /// Mobile user ID not SWxxxxxx or CSWMxxxxxx
        return loginStatus = 7;
      }
    }
    return 0;
  }

  static getDeviceIdResponse(String id) async {
    String result = await UpdateDeviceIdApi.updateDeviceId(
        id, userDeviceId, userType.toString());

    // print('ID: $id , DeviceIdL: $userDeviceId, userType: $userType');
    if (result == 'ok') {
      return 1;
    } else {
      return 0;
    }
  }

  static setUserInfo(UserData getUserData) {
    userInfo.clear();
    if (Devices().isPhone()) {
      userInfo = [
        getUserData.deviceInfo1 ?? "",
        getUserData.accessToken.toString(),
        getUserData.userDetail!.loginId ?? "",
        getUserData.roles![0],
        getUserData.userDetail!.name
      ];
    } else {
      userInfo = [
        getUserData.deviceInfo1 ?? "",
        getUserData.accessToken.toString(),
        getUserData.vehicleNo.toString(),
        'COMP',
      ];
    }
    print(userInfo);
    LocalPrefs.saveUserInfo(userInfo);
    //List getInfo = await LocalPrefs.restoreUserInfo();
    // print(getInfo);
  }

  static _getLoginResponse(
      String id, String password, int usertype, String device) async {
    String result = await LoginApi.authenticateUser(
        id, password, usertype.toString(), device);
    if (result == 'ok') {
      return loginStatus = 1;
    } else if (result == 'wrong') {
      return loginStatus = 2;
    } else if (result == 'ng') {
      return loginStatus = 3;
    } else if (result == 'error') {
      return loginStatus = 4;
    } else if (result == 'device_ng') {
      return loginStatus = 5;
    } else if (result == 'token_ng') {
      return loginStatus = 6;
    } else {
      return loginStatus = 0;
    }
  }

  static int? _setUserType(String id) {
    if (id.length >= 4) {
      if (Devices().isTablet()) {
        return userType = 3;
      } else if (Devices().isPhone()) {
        if (id.substring(0, 2).toLowerCase() == 'sw') {
          return userType = 1;
        } else if (id.substring(0, 4).toLowerCase() == 'cswm') {
          return userType = 2;
        } else {
          return userType = 0;
        }
      }
    } else {
      return 0;
    }
    return 0;
  }

  static void clearUserData(BuildContext context) {
    LocalPrefs.clearLoginCredential();
    _clearSavedFlags();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/splash', ModalRoute.withName('/splash'));
    });
  }

  static void _clearSavedFlags() {
    userRole = 0;
    otherDate = false;
    selectedNewDate = "";
    vcStatus = 0;
    onGoingTask = false;
  }
}
