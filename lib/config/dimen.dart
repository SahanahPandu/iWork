import 'package:flutter/material.dart';

import '../utils/device/devices.dart';
import '../utils/device/orientations.dart';
import '../utils/device/sizes.dart';

final double fontSize = Devices().isPhone() ? 16 : 20;
final double taskCardPadding = Devices().isPhone() ? 14 : 20;

//border setting
double borderSideWidth = 1;
double borderRadiusCircular = 4;

EdgeInsets tabletTaskCardMargin(BuildContext context) =>
    Orientations().isLandscape(context)
        ? const EdgeInsets.only(bottom: 15)
        : const EdgeInsets.only(bottom: 15, left: 15, right: 15);

double gridRatio(BuildContext context) =>
    Orientations().isLandscape(context) ? 1.75 : 1.155;

double gridRatioReport(BuildContext context) =>
    Orientations().isLandscape(context) ? 2 : 1.155;

double alertBoxPadding(BuildContext context) => Devices().isTablet()
    ? (Orientations().isLandscape(context) ? 280 : 170)
    : 20;

double loginPadding(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 15 : 200)
    : (Orientations().isPortrait(context) ? 140 : 340);

double sliderHeight(BuildContext context) => Devices().isPhone() ? 200 : 240;

double logoHeight(BuildContext context) => Devices().isPhone() ? 60 : 80;

double logoWidth(BuildContext context) => Devices().isPhone() ? 120 : 200;

double buttonWidth(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 0.4 : 0.3)
    : (Orientations().isPortrait(context) ? 0.25 : 0.16);

double buttonHeight(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 0.05 : 0.12)
    : (Orientations().isPortrait(context) ? 0.05 : 0.06);

double buttonEcutiWidth(BuildContext context) => Devices().isPhone()
    ? (Orientations().isPortrait(context) ? 0.3 : 0.24)
    : (Orientations().isPortrait(context) ? 0.25 : 0.16);

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
        ? const EdgeInsets.symmetric(horizontal: 20)
        : const EdgeInsets.symmetric(horizontal: 10);

double tableSpace(BuildContext context) =>
    Orientations().isLandscape(context) ? 25 : 20;

double columnSpaceVc(BuildContext context) =>
    Orientations().isPortrait(context) ? 5 : 0;

double columnSpacing(BuildContext context) =>
    Orientations().isLandscape(context) ? 15 : 18;

double axisSpacing(BuildContext context) =>
    Orientations().isLandscape(context) ? 10 : 0;

Map<int, FlexColumnWidth> columnVC2Width(BuildContext context) =>
    Orientations().isLandscape(context)
        ? const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2)
          }
        : const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1)
          };
