import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';

Future showSnackBar(BuildContext context, String message, Duration time,
    [Color? barColor]) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: (time),
      backgroundColor: barColor?.withOpacity(0.9) ?? green.withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
    ),
  );
}
