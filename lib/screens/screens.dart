import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/config.dart' as config;
import 'package:eswm/screens/pra/pra.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  @override
  Widget build(BuildContext context) {
    return config.userRole == 1
        ? const Pra()
        : const Text("This is not PRA section");
  }
}
