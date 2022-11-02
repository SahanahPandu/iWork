import 'package:flutter/material.dart';

//import files
import '../../config/dimen.dart';

class SahkanGantiPekerjaButton extends StatefulWidget {
  const SahkanGantiPekerjaButton({Key? key}) : super(key: key);

  @override
  State<SahkanGantiPekerjaButton> createState() =>
      _SahkanGantiPekerjaButtonState();
}

class _SahkanGantiPekerjaButtonState extends State<SahkanGantiPekerjaButton> {
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
        "Sahkan Ganti Pekerja",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
