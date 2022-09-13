import 'package:flutter/material.dart';

//import files
import '../../config/string.dart';
import '../../config/palette.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';
import '../alert/snackbar.dart';
// import '../alert/snackbar.dart';

class ReportSubmitButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final Function? clearForm;

  const ReportSubmitButton({
    Key? key,
    this.formKey,
    this.clearForm,
  }) : super(key: key);

  @override
  State<ReportSubmitButton> createState() => _ReportSubmitButtonState();
}

class _ReportSubmitButtonState extends State<ReportSubmitButton> {
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
        if (widget.formKey != null) {
          if (widget.formKey!.currentState!.validate()) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showAlertDialog(
                    context,
                    confirmation,
                    "Borang Laporan akan dihantar kepada penyelia. Pastikan maklumat diisi adalah tepat.",
                    cancel,
                    submit,
                  );
                }).then((actionText) {
              if (actionText == submit) {
                widget.clearForm!();

                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return showLottieAlertDialog(
                          context, _textBuilder(), widget.clearForm!);
                    });
              }
            });
          } else {
            showSnackBar(
              context,
              "Sila lengkapkan borang Laporan di atas",
              const Duration(seconds: 3),
              Colors.red,
            );
          }
        }
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

  Widget _textBuilder() {
    return Text(
      "Borang Laporan telah berjaya dihantar kepada Penyelia untuk pengesahan.",
      textAlign: TextAlign.center,
      textWidthBasis: TextWidthBasis.parent,
      style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: greyCustom,
          height: 1.5),
    );
  }
}
