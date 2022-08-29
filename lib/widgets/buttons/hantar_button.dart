// import 'package:eswm/utils/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';

//import files
import '../../config/string.dart';
import '../../config/palette.dart';
// import '../../screens/dialog/custom_dialog.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';

class HantarButton extends StatefulWidget {
  const HantarButton({Key? key}) : super(key: key);

  @override
  State<HantarButton> createState() => _HantarButtonState();
}

class _HantarButtonState extends State<HantarButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.green,
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
                "Borang E-Cuti anda akan dihantar untuk pengesahan. Pastikan maklumat diisi adalah tepat.",
                cancel,
                submit,
              );
            }).then((actionText) {
          if (actionText == submit) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showLottieAlertDialog(context, _textBuilder());
                });
          }
        });
      },
      child: const Text(
        "Hantar Laporan",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        textWidthBasis: TextWidthBasis.parent,
        text: TextSpan(
            text: "Permohonan cuti anda pada \n",
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
                  text: " telah berjaya dihantar",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom))
            ]));
  }
}
