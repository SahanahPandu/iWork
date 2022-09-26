import 'package:flutter/material.dart';

class Sizes {
  /// Query device's screen width size
  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  /// Query device's screen height size
  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
