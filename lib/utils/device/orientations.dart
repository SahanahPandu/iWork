import 'package:flutter/material.dart';

class Orientations {
  /// Query device's current screen orientation
  Orientation screenOrientation(BuildContext context) =>
      MediaQuery.of(context).orientation;

  /// Device is on portrait orientation?
  bool isPortrait(BuildContext context) =>
      screenOrientation(context) == Orientation.portrait;

  /// Device is on landscape orientation?
  bool isLandscape(BuildContext context) =>
      screenOrientation(context) == Orientation.landscape;

  /// Query device's shortest side size
  double screenShortSize(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide;

  /// Mobile device is on portrait orientation?
  bool isMobilePortrait(BuildContext context) =>
      screenShortSize(context) < 550 &&
      screenOrientation(context) == Orientation.portrait;

  /// Tablet device is on portrait orientation?
  bool isTabletPortrait(BuildContext context) =>
      screenShortSize(context) < 1300 &&
      screenShortSize(context) >= 550 &&
      screenOrientation(context) == Orientation.portrait;
}
