import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';
import '../alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';
import '../../config/dimen.dart';

class SahkanGantiPekerjaButton extends StatefulWidget {
  const SahkanGantiPekerjaButton({Key? key}) : super(key: key);

  @override
  State<SahkanGantiPekerjaButton> createState() =>
      _SahkanGantiPekerjaButtonState();
}

class _SahkanGantiPekerjaButtonState extends State<SahkanGantiPekerjaButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xff34A853),
          shadowColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          )),
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
            }).then((value) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return showLottieAlertDialog(context, successText(), null);
              });
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
