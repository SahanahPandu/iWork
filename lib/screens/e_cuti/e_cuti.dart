import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';

class ECuti extends StatefulWidget {
  const ECuti({Key? key}) : super(key: key);

  @override
  State<ECuti> createState() => _ECutiState();
}

class _ECutiState extends State<ECuti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        title: Text(
          eCuti,
          style: TextStyle(
            color: darkGrey,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "This is E- Cuti Page",
          style: TextStyle(
            color: darkGrey,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
