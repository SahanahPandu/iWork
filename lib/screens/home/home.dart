import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../config/palette.dart';
import '../../utils/custom_icon.dart';
import '../../widgets/drawer/drawer.dart';
import '../notifications/notifications.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 2,
          shadowColor: const Color(0xffF5F5F5),
          iconTheme: IconThemeData(color: black87),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    '/notification');
              },
              child: Icon(
                CustomIcon.notificationFill,
                color: black87,
                size: 18,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        drawer: const DrawerBuild(),
        body: const Screens());
  }
}
