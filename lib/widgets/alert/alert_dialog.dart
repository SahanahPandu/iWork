import 'package:eswm/config/palette.dart';
import 'package:flutter/material.dart';
import '../../config/dimen.dart';

showAlertDialog(BuildContext context, String title, String detail,
    String action_1, String action_2) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    title: Text(title,
        style: TextStyle(fontWeight: FontWeight.w800, color: black87)),
    content: Text(detail,
        style: TextStyle(fontWeight: FontWeight.w400, color: grey500)),
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
