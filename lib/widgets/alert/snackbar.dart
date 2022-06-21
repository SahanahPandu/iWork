import 'package:flutter/material.dart';

import '../../config/palette.dart';

Future showSnackBar(BuildContext context, String message, Duration time) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: (time), backgroundColor: green)
  );
}
