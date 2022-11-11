import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class Devices {
  /// Device is tablet?
  bool isTablet() => Device.get().isTablet;

  /// Device is mobile phone?
  bool isPhone() => Device.get().isPhone;

  /// Below are the specific details on device sizes.
  /// However, we're not using this anymore to identify device type.
  double screenShortSize(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide;

  bool isMobileSize(BuildContext context) => screenShortSize(context) < 550;

  bool isTabletSize(BuildContext context) =>
      screenShortSize(context) < 1300 && screenShortSize(context) >= 550;

  bool isDesktopSize(BuildContext context) => screenShortSize(context) >= 1300;
}
