import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/config.dart' as config;
import 'package:eswm/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: config.appBackgroundColor,
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: config.appBarBgColor,
          elevation: 0,
          leading: Icon(
            Icons.menu,
            color: Colors.grey.shade900,
          ),
          actions: const [
            Icon(
              Icons.notifications,
              color: Colors.black87,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: const Screens(),
      ),
    );
  }
}
