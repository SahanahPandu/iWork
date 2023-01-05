import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/calendar/date.dart';
import '../../utils/device/sizes.dart';
import '../alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';

class ENotisButton extends StatefulWidget {
  const ENotisButton({Key? key}) : super(key: key);

  @override
  State<ENotisButton> createState() => _ENotisButtonState();
}

class _ENotisButtonState extends State<ENotisButton>
    with TickerProviderStateMixin {
  double _scaleText = 1;
  late AnimationController _controllerText;
  String todayDate = Date.getTheDate(DateTime.now(), '', "dd/MM/yyyy", 'ms');

  @override
  void initState() {
    _controllerText = AnimationController(
      vsync: this,
      lowerBound: 0.96,
      upperBound: 1,
      value: 1,
      duration: const Duration(milliseconds: 300),
    );
    _controllerText.addListener(() {
      setState(() {
        _scaleText = _controllerText.value;
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
      width: Sizes().screenWidth(context) * (buttonEcutiWidth(context)),
      height: Sizes().screenHeight(context) * (buttonHeight(context)),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (_controllerText.isCompleted) {
            _controllerText.reverse();
          } else {
            _controllerText.forward(from: 0.5);
          }
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showLottieAlertDialog(
                      context,
                      _textBuilder(),
                      "",
                      null,
                      null,
                    );
                  });
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         child: CustomDialog(text: _textBuilder()),
              //         type: PageTransitionType.fade));
            }
          });
        },
        onTapDown: (dp) {
          _controllerText.reverse();
        },
        onTapUp: (dp) {
          Timer(const Duration(milliseconds: 200), () {
            _controllerText.fling();
          });
        },
        onTapCancel: () {
          _controllerText.fling();
        },
        child: Transform.scale(
          scale: _scaleText,
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

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Peringatan e-Notis anda pada \n",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5),
            children: <TextSpan>[
              TextSpan(
                  text:
                      " ${DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now())}",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, color: green)),
              TextSpan(
                  text: " berjaya dihantar kepada BA",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom))
            ]));
  }
}
