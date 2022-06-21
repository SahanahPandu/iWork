import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String tag = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackgroundColor,
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 4,
          shadowColor: Colors.white,
          leading: Icon(
            Icons.menu,
            color: darkGrey,
          ),
          actions: [
            Icon(
              Icons.notifications,
              color: lightBlack,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: const Screens());
  }
}