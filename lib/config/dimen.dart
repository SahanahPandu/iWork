import 'package:flutter/material.dart';

import '../utils/device.dart';

final Devices _device = Devices();
final double fontSize = _device.isPhone() ? 16 : 20;
final double taskCardPadding = _device.isPhone() ? 14 : 20;
final double movieCardMargin = _device.isTablet() ? 10 : 8;

double loginPadding(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 15.0 : 200.0)
    : (_device.isPortrait(context) ? 180.0 : 340.0);

double buttonWidth(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.25 : 0.30)
    : (_device.isPortrait(context) ? 0.25 : 0.16);

double buttonHeight(BuildContext context) => _device.isPhone()
    ? (_device.isPortrait(context) ? 0.05 : 0.1)
    : (_device.isPortrait(context) ? 0.05 : 0.06);
