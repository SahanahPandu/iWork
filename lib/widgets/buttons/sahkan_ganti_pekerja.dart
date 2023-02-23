import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';

class SahkanGantiPekerjaButton extends StatefulWidget {
  final dynamic data;

  const SahkanGantiPekerjaButton({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<SahkanGantiPekerjaButton> createState() =>
      _SahkanGantiPekerjaButtonState();
}

class _SahkanGantiPekerjaButtonState extends State<SahkanGantiPekerjaButton> {
  postFunction() async {
    Map<String, dynamic> theData = {
      "sc_main_id": widget.data['scMainId'],
      "worker": widget.data['reassignList'],
    };
    final encodeData = json.encode(theData);

    try {
      Response response = await Dio().post(
        '$theBase/task/worker-reassign',
        data: encodeData,
        options: Options(headers: {
          "authorization": "Bearer ${userInfo[1]}",
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('success');
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          overlayColor: MaterialStateColor.resolveWith((states) => green800),
          backgroundColor: MaterialStateProperty.all(greenCustom)),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return showAlertDialog(
                context,
                confirmation,
                "Pekerja yang tidak hadir akan digantikan dengan pekerja lain yang telah anda pilih. Pastikan keputusan ini adalah tepat?",
                cancel,
                yesConfirm,
              );
            }).then((actionText) {
          if (actionText == yesConfirm) {
            if (widget.data['reassignList'] != null) {
              //post data
              postFunction();
            }

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return showLottieAlertDialog(
                    context,
                    successText(),
                    "",
                    null,
                    null,
                  );
                }).then((value) => Navigator.pop(context));
          }
        });
      },
      child: const Text(
        "Sahkan",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  RichText successText() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Penggantian pekerja pada",
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
                  text: " telah berjaya dikemaskini.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom))
            ]));
  }
}
