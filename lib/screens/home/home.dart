import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../config/config.dart';
import '../../utils/custom_icon.dart';
import '../../widgets/drawer/drawer.dart';
import '../notifications/notifications.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3298F8),
            Color(0xff4A39BE),
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/notification');
              },
              child: const Icon(
                CustomIcon.notificationFill,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        drawer: const DrawerBuild(),
        body: userRole == 200
            ? const SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Screens(),
              )
            : const Screens(),
      ),
    );
  }
}
