import 'dart:async';

import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../providers/attendance/enotice_api.dart';
import '../../utils/calendar/date.dart';
import '../../utils/device/sizes.dart';
import '../alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';
import '../alert/toast.dart';

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
    Color buttonColor = isTaskDataFetched ? white : grey500;
    return SizedBox(
      width: Sizes().screenWidth(context) * (buttonEcutiWidth(context)),
      height: Sizes().screenHeight(context) * (buttonHeight(context)),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (isTaskDataFetched) {
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
                      "Maklumkan kepada BA anda tidak hadir pada tarikh ${selectedNewDate != "" ? Date.getTheDate(DateTime.parse(selectedNewDate), '', 'dd/MM/yyyy', 'ms') : todayDate}?",
                      cancel,
                      yes);
                }).then((actionText) async {
              if (actionText == yes) {
                var result = await ENoticeApi.updateENotice(context);
                if (result == 'ok') {
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
                } else {
                  // ignore: use_build_context_synchronously
                  showErrorToast(context,
                      "Permohonan E-Notis anda tidak berjaya bagi hari ${selectedNewDate != "" ? Date.getTheDate(DateTime.parse(selectedNewDate), '', 'dd/MM/yyyy', 'ms') : "ini"}",
                      height: 16);
                }

                // Navigator.push(
                //     context,
                //     PageTransition(
                //         child: CustomDialog(text: _textBuilder()),
                //         type: PageTransitionType.fade));
              }
            });
          }
        },
        onTapDown: (dp) {
          if (isTaskDataFetched) {
            _controllerText.reverse();
          }
        },
        onTapUp: (dp) {
          if (isTaskDataFetched) {
            Timer(const Duration(milliseconds: 200), () {
              _controllerText.fling();
            });
          }
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
                  color: buttonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.navigate_next_rounded,
                size: 20,
                color: buttonColor,
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
                  text: selectedNewDate != ""
                      ? Date.getTheDate(DateTime.parse(selectedNewDate), '',
                          'dd MMMM yyyy', 'ms')
                      : "ini",
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
