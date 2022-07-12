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
    _device.isLandscape(context) ? 1.7 : 1.24;

double alertBoxPadding(BuildContext context) => _device.isTablet()
    ? (_device.isLandscape(context)
    ? 280 : 100)
    : 20.0;

double loginPadding(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 15.0 : 200.0)
    : (_device.isPortrait(context) ? 180.0 : 340.0);

double buttonWidth(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.40 : 0.30)
    : (_device.isPortrait(context) ? 0.25 : 0.16);

double buttonHeight(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.05 : 0.12)
    : (_device.isPortrait(context) ? 0.05 : 0.06);

double buttonEcutiWidth(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.30 : 0.24)
    : (_device.isPortrait(context) ? 0.25 : 0.16);