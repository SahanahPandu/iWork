import 'package:flutter/material.dart';

import '../../config/palette.dart';

Future showSnackBar(BuildContext context, String message, Duration time, [Color? barColor]) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: (time), backgroundColor: barColor ?? green)
  );
}
