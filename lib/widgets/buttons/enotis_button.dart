import 'dart:async';
import 'package:eswm/config/string.dart';
import 'package:flutter/material.dart';

import 'package:eswm/utils/device.dart';
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../utils/date.dart';
import '../alert/alert_dialog.dart';

class ENotisButton extends StatefulWidget {
  const ENotisButton({Key? key}) : super(key: key);

  @override
  State<ENotisButton> createState() => _ENotisButtonState();
}

class _ENotisButtonState extends State<ENotisButton>
    with TickerProviderStateMixin {
  double squareScaleA = 1;
  late AnimationController _controllerText;
  final Devices _device = Devices();
  String todayDate = Date.getTodayDate();

  @override
  void initState() {
    _controllerText = AnimationController(
      vsync: this,
      lowerBound: 0.97,
      upperBound: 1,
      value: 1,
      duration: const Duration(milliseconds: 10),
    );
    _controllerText.addListener(() {
      setState(() {
        squareScaleA = _controllerText.value;
      });
    });
    super.initState();
  }
  
  @override
  void dispose() {
    _controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _device.screenWidth(context) * (buttonEcutiWidth(context)),
      height: _device.screenHeight(context) * (buttonHeight(context)),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _controllerText.reverse();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showAlertDialog(
                    context,
                    confirmation,
                    "Maklumkan kepada BA anda tidak hadir pada tarikh $todayDate?",
                    cancel,
                    yes);
              }).then((actionText) {
            if (actionText == yes) {
              // Navigator.pop(context);
            }
          });
        },
        onTapDown: (dp) {
          _controllerText.reverse();
        },
        onTapUp: (dp) {
          Timer(const Duration(milliseconds: 100), () {
            _controllerText.fling();
          });
        },
        onTapCancel: () {
          _controllerText.fling();
        },
        child: Transform.scale(
          scale: squareScaleA,
          child: Row(
            children: [
              Text(
                "E-Notis",
                style: TextStyle(
                  color: white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.navigate_next_rounded,
                size: 20,
                color: white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
