import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/calendar/date.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';
import '../alert/snackbar.dart';

class EcutiSubmitButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final dynamic data;
  final Function? postData;
  final Function? clearForm;

  const EcutiSubmitButton({
    Key? key,
    this.formKey,
    this.data,
    this.postData,
    this.clearForm,
  }) : super(key: key);

  @override
  EcutiSubmitButtonState createState() => EcutiSubmitButtonState();
}

class EcutiSubmitButtonState extends State<EcutiSubmitButton> {
  String theLeaveDate = "";

  getTheLeaveDate(passingDate) {
    String thefilterDate = "";
    if (passingDate != null) {
      var theDate = passingDate;

      if (theDate['tarikhMula'] == theDate['tarikhTamat']) {
        String convDate = "";

        if (theDate['tarikhMula'] != null && theDate['tarikhMula'] != "") {
          convDate =
              Date.getTheDate(theDate['tarikhMula'], 'dd MMMM yyyy', 'ms');
        }

        thefilterDate = convDate;
      } else {
        String convDate1 = "";

        String convDate2 = "";

        if (theDate['tarikhMula'] != null && theDate['tarikhMula'] != "") {
          convDate1 =
              Date.getTheDate(theDate['tarikhMula'], 'dd MMMM yyyy', 'ms');
        }

        if (theDate['tarikhTamat'] != null && theDate['tarikhTamat'] != "") {
          convDate2 =
              Date.getTheDate(theDate['tarikhTamat'], 'dd MMMM yyyy', 'ms');
        }

        thefilterDate = "$convDate1 - $convDate2";
      }
    }

    setState(() {
      theLeaveDate = thefilterDate;
    });
  }

  @override
  void initState() {
    getTheLeaveDate(widget.data);
    super.initState();
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
        if (widget.formKey != null) {
          if (widget.formKey!.currentState!.validate()) {
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
                //post data to the database
                widget.postData != null ? widget.postData!() : null;
                // widget.clearForm!();

                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return showLottieAlertDialog(
                        context,
                        _textBuilder(),
                        "8",
                        widget.clearForm!,
                        null,
                      );
                    });
              }
            });
          } else {
            showSnackBar(
              context,
              "Sila lengkapkan borang E-Cuti di atas",
              const Duration(seconds: 3),
              Colors.red,
            );
          }
        }
      },
      child: const Text(
        "Hantar Borang",
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
                      //" ${DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now())}",
                      theLeaveDate,
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
