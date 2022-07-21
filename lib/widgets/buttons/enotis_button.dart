import 'package:eswm/config/string.dart';
import 'package:flutter/material.dart';

import 'package:eswm/utils/device.dart';
import '../../config/dimen.dart';
import '../../utils/date.dart';
import '../alert/alert_dialog.dart';

class ENotisButton extends StatefulWidget {
  const ENotisButton({Key? key}) : super(key: key);

  @override
  State<ENotisButton> createState() => _ENotisButtonState();
}

class _ENotisButtonState extends State<ENotisButton> {
  final Devices _device = Devices();
  String todayDate = Date.getTodayDate();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _device.screenWidth(context) * (buttonEcutiWidth(context)),
      height: _device.screenHeight(context) * (buttonHeight(context)),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 5.0,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showAlertDialog(
                    context,
                    confirmation,
                    "Maklumkan kepada BA anda tidak hadir pada tarikh $todayDate?",
                    cancel,
                    yes);
              }).then((actionText) {
            if (actionText == yes) {
              // Navigator.pop(context);
            }
          });
        },
        icon: const Icon(
          Icons.add_box,
          color: Colors.orange,
          size: 20,
        ),
        label: const Text(
          "E-Notis",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
