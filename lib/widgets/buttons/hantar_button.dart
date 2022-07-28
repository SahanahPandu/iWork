import 'package:eswm/config/palette.dart';
import 'package:flutter/material.dart';

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
      onPressed: () {},
      child: const Text(
        "Hantar Laporan",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
