import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../widgets/drawer/drawer.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackgroundColor,
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 1,
          shadowColor: Colors.white,
          iconTheme: IconThemeData(color: black87),
          actions: [
            Icon(
              Icons.notifications,
              color: black87,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        drawer: DrawerBuild(),
        body: const Screens());
  }
}
