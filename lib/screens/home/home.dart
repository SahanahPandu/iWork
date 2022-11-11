import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/drawer/drawer.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes().screenHeight(context),
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
          leadingWidth: userRole == 100 ? 80 : 40,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark, //android
            statusBarBrightness: Brightness.light, //ios
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 45,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
                child: const Icon(
                  CustomIcon.notificationFill,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            SizedBox(
              width: userRole == 100 ? 20 : 10,
            )
          ],
        ),
        drawer: const DrawerBuild(),
        body: ScrollConfiguration(
            behavior:
                const MaterialScrollBehavior().copyWith(overscroll: false),
            child: const Screens()),
      ),
    );
  }
}
