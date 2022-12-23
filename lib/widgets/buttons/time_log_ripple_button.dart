import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';

class TimeLogRippleButton extends StatefulWidget {
  final String btnText;
  final Color btnColor;

  const TimeLogRippleButton(
      {Key? key, required this.btnText, required this.btnColor})
      : super(key: key);

  @override
  State<TimeLogRippleButton> createState() => _TimeLogRippleButtonState();
}

class _TimeLogRippleButtonState extends State<TimeLogRippleButton> {
  @override
  Widget build(BuildContext context) {
    return RippleAnimation(
      delay: const Duration(milliseconds: 100),
      repeat: true,
      color: widget.btnColor,
      minRadius: 40,
      ripplesCount: 15,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showAlertDialog(
                    context,
                    "Pengesahan",
                    "Adakah anda pasti untuk ${widget.btnText} sekarang?",
                    "Batal",
                    widget.btnText);
              }).then((actionText) async {
            // Navigator.pop(context, actionText);
            if (actionText == "Masuk Kerja") {
              //get clock in time into db
              try {
                Response response = await Dio().post(
                  '$theBase/attendance/start-work',
                  options: Options(headers: {
                    "authorization": "Bearer ${userInfo[1]}",
                  }),
                );

                if (response.statusCode == 200) {
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
                      }).then((value) {
                    Navigator.pop(context, actionText);
                  });
                }
              } on DioError catch (e) {
                // ignore: avoid_print
                print(e);
              }
            } else if (actionText == "Tamat Kerja") {
              //get clock out time into db
              try {
                Response response = await Dio().post(
                  '$theBase/attendance/end-work',
                  options: Options(headers: {
                    "authorization": "Bearer ${userInfo[1]}",
                  }),
                );

                if (response.statusCode == 200) {
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
                      }).then((value) {
                    Navigator.pop(context, actionText);
                  });
                }
              } on DioError catch (e) {
                // ignore: avoid_print
                print(e);
              }
            }
          });
        },
        child: Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
            color: widget.btnColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              widget.btnText,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: widget.btnText == "Masuk Kerja"
                ? "Tahniah! Anda berjaya masuk kerja \nuntuk"
                : "Jumpa lagi! Anda telah tamat kerja \nuntuk",
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
                  text: " pada jam",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom)),
              TextSpan(
                  text:
                      " ${DateFormat("hh:mm a", 'ms').format(DateTime.now())}",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, color: green))
            ]));
  }
}
