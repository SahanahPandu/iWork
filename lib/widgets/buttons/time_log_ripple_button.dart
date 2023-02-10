import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../screens/geo_location/user_locator.dart';
import '../alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';
import '../alert/toast.dart';

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
              await UserLocator().getCurrentPosition();

              /// Your Current location is office, correct!
              if (currentAddress == "1, Taman Tun Dr Ismail, , 60000") {
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
                            _textBuilder("Tahniah! Anda berjaya masuk kerja"),
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
                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return showLottieAlertDialog(
                            context,
                            _textBuilder(
                              "Anda berada di luar kawasan depoh. Pastikan anda berada di dalam kawasan sebelum masuk kerja",
                            ),
                            "",
                            null,
                            null,
                            false);
                      });
                }
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showLottieAlertDialog(
                          context,
                          _textBuilder(
                            "Lokasi kini: $currentAddress\nAnda berada di luar kawasan depoh. Pastikan anda berada di dalam kawasan sebelum masuk kerja",
                          ),
                          "",
                          null,
                          null,
                          false);
                    });
              }
            } else if (actionText == "Tamat Kerja") {
              await UserLocator().getCurrentPosition();

              /// Your Current location is office, correct!
              if (currentAddress == "1, Taman Tun Dr Ismail, , 60000") {
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
                            _textBuilder("Jumpa lagi! Anda telah tamat kerja"),
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
                  // ignore: use_build_context_synchronously
                  showErrorToast(
                      context, "Log keluar anda tidak berjaya. Sila cuba lagi.",
                      height: 16);
                }
              }
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showLottieAlertDialog(
                        context,
                        _textBuilder(
                          "Lokasi kini: $currentAddress\nAnda berada di luar kawasan depoh. Pastikan anda berada di dalam kawasan sebelum keluar kerja",
                        ),
                        "",
                        null,
                        null,
                        false);
                  });
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

  Widget _textBuilder(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      textWidthBasis: TextWidthBasis.parent,
      style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: greyCustom,
          height: 1.5),
    );
    // return RichText(
    //     textAlign: TextAlign.center,
    //     text: TextSpan(
    //         text: widget.btnText == "Masuk Kerja"
    //             ? "Tahniah! Anda berjaya masuk kerja \nuntuk"
    //             : "Jumpa lagi! Anda telah tamat kerja \nuntuk",
    //         style: TextStyle(
    //             fontSize: 15,
    //             fontWeight: FontWeight.w400,
    //             color: greyCustom,
    //             height: 1.5),
    //         children: <TextSpan>[
    //           TextSpan(
    //               text:
    //                   " ${DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now())}",
    //               style: TextStyle(
    //                   fontSize: 15, fontWeight: FontWeight.w400, color: green)),
    //           TextSpan(
    //               text: " pada jam",
    //               style: TextStyle(
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w400,
    //                   color: greyCustom)),
    //           TextSpan(
    //               text:
    //                   " ${DateFormat("hh:mm a", 'ms').format(DateTime.now())}",
    //               style: TextStyle(
    //                   fontSize: 15, fontWeight: FontWeight.w400, color: green))
    //         ]));
  }
}
