import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/dimen.dart';
import '../../screens/e_cuti/e_cuti.dart';
import '../../utils/device/sizes.dart';

class EcutiButton extends StatefulWidget {
  const EcutiButton({Key? key}) : super(key: key);

  @override
  State<EcutiButton> createState() => _EcutiButtonState();
}

class _EcutiButtonState extends State<EcutiButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes().screenWidth(context) * (buttonEcutiWidth(context)),
      height: Sizes().screenHeight(context) * (buttonHeight(context)),
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
                  child: const ECuti(
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
