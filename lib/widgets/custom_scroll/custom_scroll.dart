import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }

  static const ScrollPhysics _clampingPhysics =
      ClampingScrollPhysics(parent: RangeMaintainingScrollPhysics());

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _clampingPhysics;
  }
}
