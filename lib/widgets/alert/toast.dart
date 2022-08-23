import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device.dart';

final Devices _device = Devices();

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
      const Color.fromRGBO(54, 105, 214, 1),
      Icons.info_outline,
      white,
      shouldDismiss));
}

void showErrorToast(BuildContext context, String message,
    {bool shouldDismiss = true}) {
  Timer.run(() => _showToast(
      context, message, red, Icons.error_outline, white, shouldDismiss));
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
                        ? (_device.isLandscape(context)
                            ? _device.screenWidth(context) - 100
                            : _device.screenWidth(context) - 60)
                        : _device.screenWidth(context) - 50,
                    height: _device.isLandscape(context)
                        ? _device.screenHeight(context) / 10
                        : _device.screenHeight(context) / 17,
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
                                fontSize:
                                    _device.isLandscape(context) ? 16 : 14,
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