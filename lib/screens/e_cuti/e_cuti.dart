import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/config.dart' as config;

class ECuti extends StatefulWidget {
  const ECuti({Key? key}) : super(key: key);

  @override
  State<ECuti> createState() => _ECutiState();
}

class _ECutiState extends State<ECuti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: config.appBarBgColor,
        elevation: 0,
        title: Text(
          "E-Cuti",
          style: TextStyle(
            color: Colors.grey.shade900,
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
            color: Colors.grey.shade900,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "This is E- Cuti Page",
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
