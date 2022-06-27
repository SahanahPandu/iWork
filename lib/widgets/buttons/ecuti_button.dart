import 'package:flutter/material.dart';

import 'package:eswm/screens/e_cuti/e_cuti.dart';
import 'package:eswm/utils/device.dart';
import '../../config/dimen.dart';

class EcutiButton extends StatefulWidget {
  const EcutiButton({Key? key}) : super(key: key);

  @override
  State<EcutiButton> createState() => _EcutiButtonState();
}

class _EcutiButtonState extends State<EcutiButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _device.screenWidth(context) * (buttonWidth(context)),
      height: _device.screenHeight(context) * (buttonHeight(context)),
      //color: Colors.white,
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ECuti(),
              ));
        },
        icon: const Icon(
          Icons.add_box,
          color: Colors.orange,
          size: 20,
        ),
        label: const Text(
          "E-Cuti",
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
