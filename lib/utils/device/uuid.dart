import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class Uuid {
  /// Query device's (Android & ios) UUID for user login auth.
  /// UUID will be reset if device performed factory reset
  /// iOS -> identifierForVendor: An alphanumeric string that uniquely identifies a device to the app’s vendor.
  /// Android -> androidId: The Android hardware device ID that is unique between the device + user and app signing.
  Future<String?> getDeviceIdentifier() async {
    String? deviceIdentifier = "unknown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor;
    }
    return deviceIdentifier;
  }
}
