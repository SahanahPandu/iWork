// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

//import files
import 'utils/authentication/auth.dart';
import 'utils/authentication/role.dart';

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
    String getInfo = await Auth.loadUserInfo();
    int getRole = await Roles.loadUserRole();
    // print("_info = $info, _role = $role, userRole config: $userRole");
    if (getInfo == "" && getRole == 0) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/splash', ModalRoute.withName('/splash'));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', ModalRoute.withName('/home'));
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
