import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/palette.dart';
import '../../screens/time_log/time_log.dart';
import '../../utils/icon/custom_icon.dart';

class TimeLogButton extends StatefulWidget {
  final String? timeIn;
  final String? timeOut;
  final Function? refresh;

  const TimeLogButton({
    Key? key,
    this.timeIn,
    this.timeOut,
    this.refresh,
  }) : super(key: key);

  @override
  TimeLogButtonState createState() => TimeLogButtonState();
}

class TimeLogButtonState extends State<TimeLogButton> {
  Color buttonColor = const Color(0xff52A834);
  Color buttonTextColor = Colors.white;
  Color buttonOverlayColor = green800;
  Color iconColor = Colors.white;
  String buttonText = "Masuk Kerja";

  changeButtonColor() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: TimeLog(
              btnText: buttonText,
              btnColor: buttonColor,
            ))).then((actionText) {
      if (actionText == "Masuk Kerja") {
        if (widget.refresh != null) {
          widget.refresh!("Tamat Kerja", const Color(0xffE04141), Colors.white,
              Colors.white, red900);
        }

        setState(() {
          print('Set state button');
          buttonText = "Tamat Kerja";
          buttonColor = const Color(0xffE04141);
          buttonOverlayColor = red900;
        });
        print('Tekan Masuk Kerja');
      } else if (actionText == "Tamat Kerja") {
        // setState(() {
        //   //disabled button
        //   buttonText = "Masuk Kerja";
        //   buttonColor = const Color(0xffD9D9D9);
        //   buttonTextColor = const Color(0xff969696);
        //   iconColor = const Color(0xff969696);
        //   buttonOverlayColor = const Color(0xffD9D9D9);
        // });

        if (widget.refresh != null) {
          widget.refresh!(
              "Masuk Kerja",
              const Color(0xffD9D9D9),
              const Color(0xff969696),
              const Color(0xff969696),
              const Color(0xffD9D9D9));
        }
        print('Tekan Tamat Kerja');
      }
    });
  }

  loadButton() {
    if ((widget.timeIn != null && widget.timeIn != "") &&
        (widget.timeOut != null && widget.timeOut != "")) {
      //have time in and time out
      print('Both ada');

      buttonText = "Masuk Kerja";
      buttonColor = const Color(0xffD9D9D9);
      buttonTextColor = const Color(0xff969696);
      iconColor = const Color(0xff969696);
      buttonOverlayColor = const Color(0xffD9D9D9);
    } else if ((widget.timeIn != null && widget.timeIn != "") &&
        (widget.timeOut == null && widget.timeOut == "")) {
      //have time in but no time out
      print('Clock In ada');
      buttonText = "Tamat Kerja";
      buttonColor = const Color(0xffE04141);
      buttonOverlayColor = red900;
    } else if ((widget.timeIn == null && widget.timeIn == "") &&
        (widget.timeOut != null && widget.timeOut != "")) {
      //have time out but no time in
      print('Clock Out ada');
    }
  }

  @override
  void initState() {
    super.initState();
    loadButton();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 46,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          elevation: MaterialStateProperty.all(5),
          overlayColor:
              MaterialStateColor.resolveWith((states) => buttonOverlayColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
        ),
        onPressed: () {
          if (buttonColor != const Color(0xffD9D9D9)) {
            changeButtonColor();
          }
        },
        icon: Icon(
          CustomIcon.timerOutline,
          color: iconColor,
          size: 15,
        ),
        label: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
