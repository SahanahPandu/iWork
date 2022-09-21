import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';
import '../../utils/device.dart';
import '../../widgets/drawer/drawer.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Devices().screenHeight(context),
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
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark, //android
            statusBarBrightness: Brightness.light, //ios
          ),
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
            : ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(overscroll: false),
                child: const Screens()),
      ),
    );
  }
}
