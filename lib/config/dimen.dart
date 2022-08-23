import 'package:flutter/material.dart';

import '../utils/device.dart';

final Devices _device = Devices();
final double fontSize = _device.isPhone() ? 16 : 20;
final double taskCardPadding = _device.isPhone() ? 14 : 20;

EdgeInsets tabletTaskCardMargin(BuildContext context) =>
    _device.isLandscape(context)
        ? const EdgeInsets.only(bottom: 15.0)
        : const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0);

double gridRatio(BuildContext context) =>
    _device.isLandscape(context) ? 1.7 : 1.155;

double alertBoxPadding(BuildContext context) =>
    _device.isTablet() ? (_device.isLandscape(context) ? 280 : 170) : 20.0;

double loginPadding(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 15.0 : 200.0)
    : (_device.isPortrait(context) ? 140.0 : 340.0);

double sliderSize(BuildContext context) =>
    _device.isPhone() ? 200.0 : (_device.isPortrait(context) ? 250.0 : 200.0);

double logoHeight(BuildContext context) =>
    _device.isPhone() ? 90.0 : (_device.isPortrait(context) ? 140.0 : 100.0);

double logoWidth(BuildContext context) =>
    _device.isPhone() ? 100.0 : (_device.isPortrait(context) ? 140.0 : 100.0);

double buttonWidth(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.40 : 0.30)
    : (_device.isPortrait(context) ? 0.25 : 0.16);

double buttonHeight(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.05 : 0.12)
    : (_device.isPortrait(context) ? 0.05 : 0.06);

double buttonEcutiWidth(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.30 : 0.24)
    : (_device.isPortrait(context) ? 0.25 : 0.16);

double fontSizeVc(BuildContext context) =>
    _device.isLandscape(context) ? 16 : 14;

double containerVCHeight(BuildContext context) => _device.isLandscape(context)
    ? (_device.screenHeight(context) * 0.16)
    : (_device.screenHeight(context) * 0.14);

double containerVC2Height(BuildContext context) => _device.isLandscape(context)
    ? (_device.screenHeight(context) * 0.19)
    : (_device.screenHeight(context) * 0.13);

EdgeInsets paddingVcTable(BuildContext context) => _device.isLandscape(context)
    ? const EdgeInsets.symmetric(horizontal: 20.0)
    : const EdgeInsets.symmetric(horizontal: 10.0);

double tableSpace(BuildContext context) =>
    _device.isLandscape(context) ? 32 : 20;

double columnSpaceVc(BuildContext context) =>
    _device.isPortrait(context) ? 5 : 0;

double columnSpacing(BuildContext context) =>
    _device.isLandscape(context) ? 6 : 15;

double axisSpacing(BuildContext context) =>
    _device.isLandscape(context) ? 10.0 : 0;

Map<int, FlexColumnWidth> columnVC2Width(BuildContext context) =>
    _device.isLandscape(context)
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
