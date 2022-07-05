import 'package:flutter/material.dart';
import '../../config/dimen.dart';

showAlertDialog(BuildContext context, String title, String detail,
    String action_1, String action_2) {
  return AlertDialog(
    title: Text(title),
    content: Text(detail),
    insetPadding: EdgeInsets.symmetric(horizontal: alertBoxPadding(context)),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, action_1),
        child: Text(action_1),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, action_2),
        child: Text(action_2),
      ),
    ],
  );
}
