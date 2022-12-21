import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';
import '../alert/snackbar.dart';

class ReportSubmitButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final Function? postData;
  final Function? clearForm;
  final dynamic passData;

  const ReportSubmitButton({
    Key? key,
    this.formKey,
    this.postData,
    this.clearForm,
    this.passData,
  }) : super(key: key);

  @override
  State<ReportSubmitButton> createState() => _ReportSubmitButtonState();
}

class _ReportSubmitButtonState extends State<ReportSubmitButton> {
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
                //post data to the database
                widget.postData != null ? widget.postData!() : null;

                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return showLottieAlertDialog(context, _textBuilder(), "7",
                          widget.clearForm!, widget.passData);
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
