import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
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
      //color: Colors.white,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: userRole == 200 ? 5 : 1,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ECuti(
                  screen: "1",
                  data: null,
                ),
              ));
        },
        icon: const Icon(
          Icons.add_box,
          color: Colors.orange,
          size: 20,
        ),
        label: Text(
          "E-Cuti",
          style: TextStyle(
            color: Colors.orange,
            fontSize: userRole == 200 ? 17 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
