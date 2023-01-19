import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';

void showSuccessToast(BuildContext context, String message,
    {bool shouldDismiss = true}) {
  Timer.run(() => _showToast(
      context,
      message,
      const Color.fromRGBO(91, 180, 107, 1),
      CupertinoIcons.check_mark_circled_solid,
      white,
      shouldDismiss));
}

void showInfoToast(BuildContext context, String message,
    {bool shouldDismiss = true}) {
  Timer.run(() => _showToast(
      context,
      message,
      const Color.fromRGBO(82, 186, 218, 0.9372549019607843),
      Icons.info_outline,
      white,
      shouldDismiss));
}

void showErrorToast(BuildContext context, String message,
    {bool shouldDismiss = true}) {
  Timer.run(() => _showToast(
      context,
      message,
      const Color.fromRGBO(204, 76, 76, 0.8745098039215686),
      Icons.error_outline,
      white,
      shouldDismiss));
}

void _showToast(BuildContext context, String message, Color color,
    IconData icon, Color iconColor, bool shouldDismiss) {
  showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        if (shouldDismiss) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context, rootNavigator: true).pop(true);
          });
        }
        return Material(
          type: MaterialType.transparency,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10)),
                        color: color),
                    width: userRole == 100
                        ? (Orientations().isLandscape(context)
                            ? Sizes().screenWidth(context) - 100
                            : Sizes().screenWidth(context) - 60)
                        : Sizes().screenWidth(context) - 50,
                    height: Orientations().isLandscape(context)
                        ? Sizes().screenHeight(context) / 12
                        : Sizes().screenHeight(context) / 18,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: userRole == 100
                              ? const EdgeInsets.symmetric(horizontal: 20)
                              : const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            icon,
                            size: userRole == 100 ? 30 : 20,
                            color: iconColor,
                          ),
                        ),
                        SizedBox(
                          width: userRole == 100 ? 20 : 8,
                        ),
                        Flexible(
                          child: Text(
                            message,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: white,
                                fontSize: Orientations().isLandscape(context)
                                    ? 16
                                    : 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
      });
}