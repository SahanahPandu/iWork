import 'package:flutter/material.dart';

import '../utils/device/devices.dart';
import '../utils/device/orientations.dart';
import '../utils/device/sizes.dart';

final double fontSize = Devices().isPhone() ? 16 : 20;
final double taskCardPadding = Devices().isPhone() ? 14 : 20;

EdgeInsets tabletTaskCardMargin(BuildContext context) =>
    Orientations().isLandscape(context)
        ? const EdgeInsets.only(bottom: 15.0)
        : const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0);

double gridRatio(BuildContext context) =>
    Orientations().isLandscape(context) ? 1.7 : 1.155;

double alertBoxPadding(BuildContext context) => Devices().isTablet()
    ? (Orientations().isLandscape(context) ? 280 : 170)
    : 20.0;

double loginPadding(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 15.0 : 200.0)
    : (Orientations().isPortrait(context) ? 140.0 : 340.0);

double sliderSize(BuildContext context) => Devices().isPhone()
    ? 200.0
    : (Orientations().isPortrait(context) ? 250.0 : 200.0);

double logoHeight(BuildContext context) => Devices().isPhone()
    ? 90.0
    : (Orientations().isPortrait(context) ? 140.0 : 100.0);

double logoWidth(BuildContext context) => Devices().isPhone()
    ? 100.0
    : (Orientations().isPortrait(context) ? 140.0 : 100.0);

double buttonWidth(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 0.40 : 0.30)
    : (Orientations().isPortrait(context) ? 0.25 : 0.16);

double buttonHeight(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 0.05 : 0.12)
    : (Orientations().isPortrait(context) ? 0.05 : 0.06);

double buttonEcutiWidth(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 0.30 : 0.24)
    : (Orientations().isPortrait(context) ? 0.25 : 0.16);

double fontSizeVc(BuildContext context) =>
    Orientations().isLandscape(context) ? 16 : 14;

double containerVCHeight(BuildContext context) =>
    Orientations().isLandscape(context)
        ? (Sizes().screenHeight(context) * 0.16)
        : (Sizes().screenHeight(context) * 0.14);

double containerVC2Height(BuildContext context) =>
    Orientations().isLandscape(context)
        ? (Sizes().screenHeight(context) * 0.19)
        : (Sizes().screenHeight(context) * 0.13);

EdgeInsets paddingVcTable(BuildContext context) =>
    Orientations().isLandscape(context)
        ? const EdgeInsets.symmetric(horizontal: 20.0)
        : const EdgeInsets.symmetric(horizontal: 10.0);

double tableSpace(BuildContext context) =>
    Orientations().isLandscape(context) ? 32 : 20;

double columnSpaceVc(BuildContext context) =>
    Orientations().isPortrait(context) ? 5 : 0;

double columnSpacing(BuildContext context) =>
    Orientations().isLandscape(context) ? 6 : 15;

double axisSpacing(BuildContext context) =>
    Orientations().isLandscape(context) ? 10.0 : 0;

Map<int, FlexColumnWidth> columnVC2Width(BuildContext context) =>
    Orientations().isLandscape(context)
        ? const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2.2),
            2: FlexColumnWidth(0.6),
            3: FlexColumnWidth(2.8),
            4: FlexColumnWidth(2.2)
          }
        : const {
            0: FlexColumnWidth(2.6),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(0.35),
            3: FlexColumnWidth(2.1),
            4: FlexColumnWidth(2.3)
          };
