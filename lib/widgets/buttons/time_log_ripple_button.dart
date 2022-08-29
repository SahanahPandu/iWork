import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

//import files
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
      //duration: const Duration(milliseconds: 2000),
      repeat: true,
      color: widget.btnColor,
      minRadius: 40,
      ripplesCount: 15,
      child: InkWell(
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
              }).then((actionText) {
            if (actionText == "Masuk Kerja") {
              Navigator.pop(context, actionText);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showLottieAlertDialog(context, _textBuilder());
                  });
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         child: CustomDialog(text: _textBuilder()),
              //         type: PageTransitionType.fade));
            } else if (actionText == "Tamat Kerja") {
              Navigator.pop(context, actionText);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showLottieAlertDialog(context, _textBuilder());
                  });
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         child: CustomDialog(text: _textBuilder()),
              //         type: PageTransitionType.fade));
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
