import 'package:flutter/material.dart';

//import files
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../utils/device/sizes.dart';
import '../login/login.dart';

class SplashMain extends StatefulWidget {
  const SplashMain({Key? key}) : super(key: key);

  @override
  State<SplashMain> createState() => _SplashMainState();
}

class _SplashMainState extends State<SplashMain>
    with TickerProviderStateMixin {
  var expanded = false;
  final transitionDuration = const Duration(seconds: 1);

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => setState(() => expanded = true))
        .then((value) => const Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Material(
          child: ScrollConfiguration(
            behavior:
                const MaterialScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                width: Sizes().screenWidth(context),
                height: Sizes().screenHeight(context),
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: transitionDuration,
                      curve: Curves.fastOutSlowIn,
                      height: !expanded ? 240 : logoHeight(context),
                      width: !expanded ? 240 : logoWidth(context),
                      child: Image.asset(
                        splashImg,
                      ),
                    ),
                    AnimatedCrossFade(
                      firstCurve: Curves.fastOutSlowIn,
                      crossFadeState: !expanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: transitionDuration,
                      firstChild: Container(),
                      secondChild: _loadLoginScreen(),
                      secondCurve: Curves.easeInBack,
                      alignment: Alignment.center,
                      sizeCurve: Curves.easeInOut,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadLoginScreen() {
    return const LoginScreen();
  }
}
