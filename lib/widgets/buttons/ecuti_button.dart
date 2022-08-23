import 'package:flutter/material.dart';

import 'package:eswm/screens/e_cuti/e_cuti.dart';
import 'package:eswm/utils/device.dart';
import 'package:page_transition/page_transition.dart';
import '../../config/dimen.dart';

class EcutiButton extends StatefulWidget {
  const EcutiButton({Key? key}) : super(key: key);

  @override
  State<EcutiButton> createState() => _EcutiButtonState();
}

class _EcutiButtonState extends State<EcutiButton> {
  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _device.screenWidth(context) * (buttonEcutiWidth(context)),
      height: _device.screenHeight(context) * (buttonHeight(context)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
        ),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ECuti(
                    screen: "1",
                    data: null,
                  )));
        },
        child: Row(
          children: const [
            Text(
              "E-Cuti",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.navigate_next,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
