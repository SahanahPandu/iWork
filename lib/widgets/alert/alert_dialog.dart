import 'package:eswm/config/palette.dart';
import 'package:eswm/config/string.dart';
import 'package:flutter/material.dart';
import '../../config/dimen.dart';

showAlertDialog(BuildContext context, String title, String detail,
    String action_1, String action_2) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    title: Text(title,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: title == reminder ? redCustom : greenCustom)),
    content: Text(detail,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: greyCustom,
            height: 1.5)),
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
