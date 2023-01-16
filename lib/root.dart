// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

//import files
import 'config/config.dart';
import 'utils/authentication/role.dart';
import 'utils/storage/local_pref.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> {
  @override
  void initState() {
    _isUserLoggedIn();
    super.initState();
  }

  void _isUserLoggedIn() async {
    List getSavedUserData = await LocalPrefs.restoreUserInfo();
    if (getSavedUserData.isEmpty && userRole == 0) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/splash', ModalRoute.withName('/splash'));
    } else {
      if (getSavedUserData.isNotEmpty) {
        Roles.setRole(userInfo[3]);
        if (userRole != 0) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', ModalRoute.withName('/home'));
        } else {
          getSavedUserData = [];
          userRole == 0;
          Navigator.pushNamedAndRemoveUntil(
              context, '/splash', ModalRoute.withName('/splash'));
        }
      } else {
        getSavedUserData = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/splash', ModalRoute.withName('/splash'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
      backgroundColor: Colors.green,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    )));
  }
}
