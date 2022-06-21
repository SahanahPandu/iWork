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
          // title: Padding(
          //   padding: const EdgeInsets.only(left: 8.0),
          //   child: Text(
          //     "Hi, Suhaimi",
          //     style: TextStyle(
          //       color: Colors.grey.shade900,
          //       fontSize: 24,
          //       fontWeight: FontWeight.w800,
          //     ),
          //   ),
          // ),
          backgroundColor: config.appBarBgColor,
          elevation: 4,
          shadowColor: Colors.white,
          leading: Icon(
            Icons.menu,
            color: Colors.grey.shade800,
          ),
          actions: [
            Icon(
              Icons.notifications,
              color: Colors.grey.shade800,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: const Screens(),
      ),
    );
  }
}
