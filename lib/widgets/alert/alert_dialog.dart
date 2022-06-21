import 'package:flutter/material.dart';

Future showAlertDialog(BuildContext context, String title, String detail,
    String action_1, String action_2) async {
  AlertDialog(
    title: Text(title),
    content: Text(detail),
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
