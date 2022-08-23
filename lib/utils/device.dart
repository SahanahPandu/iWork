import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class Devices {
  bool isTablet() => Device.get().isTablet;

  bool isPhone() => Device.get().isPhone;

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double screenShortSize(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide;

  Orientation screenOrientation(BuildContext context) =>
      MediaQuery.of(context).orientation;

  bool isMobileSize(BuildContext context) => screenShortSize(context) < 550;

  bool isTabletSize(BuildContext context) =>
      screenShortSize(context) < 1300 && screenShortSize(context) >= 550;

  bool isDesktopSize(BuildContext context) => screenShortSize(context) >= 1300;

  bool isPortrait(BuildContext context) =>
      screenOrientation(context) == Orientation.portrait;

  bool isLandscape(BuildContext context) =>
      screenOrientation(context) == Orientation.landscape;

  bool isMobilePortrait(BuildContext context) =>
      screenShortSize(context) < 550 &&
      screenOrientation(context) == Orientation.portrait;

  bool isTabletPortrait(BuildContext context) =>
      screenShortSize(context) < 1300 &&
      screenShortSize(context) >= 550 &&
      screenOrientation(context) == Orientation.portrait;
}
