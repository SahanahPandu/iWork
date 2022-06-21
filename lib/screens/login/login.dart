import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../config/string.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../utils/responsive.dart';
import '../../widgets/alert/snackbar.dart';
import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String tag = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  String compactorIDText = "0000";
  String staffIDText = "0000";
  String passwordText = "0";

  int deviceType = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: getDevicePadding(context),
          child: Column(
            children: <Widget>[
              spaceBuild(context, 0.1),
              imageBuild(context, 0, 0.2, 0.2, logoImg),
              imageBuild(context, 0, 0.9, 0.25, operationImg),
              spaceBuild(context, 0.03),
              formBuild(context),
              forgotPasswordButton(),
              spaceBuild(context, 0.03),
              loginButton(context),
              spaceBuild(context, 0.1),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets getDevicePadding(BuildContext context) {
    return EdgeInsets.symmetric(
        horizontal: (isMobile(context)
            ? (isPortrait(context) ? 15.0 : 200.0)
            : (isPortrait(context) ? 180.0 : 340.0)));
  }

  Center imageBuild(BuildContext context, double top, double widthSz,
      double heightSz, String image) {
    return Center(
        child: Container(
            padding: EdgeInsets.only(
                left: 0,
                right: 0,
                top: (screenHeight(context) * top),
                bottom: 0),
            width: screenWidth(context) * widthSz,
            height: screenHeight(context) * heightSz,
            child: Image.asset(image)));
  }

  Form formBuild(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            loginFieldBuild(context, isTablet(context) ? kompaktorID : staffID),
            spaceBuild(context, 0.02),
            loginFieldBuild(context, password),
          ],
        ));
  }

  SizedBox loginFieldBuild(BuildContext context, String label) {
    return SizedBox(
      height: 55.0,
      child: TextFormField(
        autofocus: false,
        obscureText: label == password ? _isObscure : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sila masukkan $label anda';
          } else {
            if (label == kompaktorID) {
              compactorIDText = value;
              deviceType = compactorPanel;
            } else if (label == staffID) {
              staffIDText = value;
              deviceType = mobileApp;
            } else {
              passwordText = value;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          hintMaxLines: 1,
          filled: true,
          fillColor: appBackgroundColor,
          focusColor: green,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: TextStyle(color: grey, fontSize: 14),
          labelText: label,
          suffixIcon: label == password
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Padding forgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            print(forgotPassword);
          },
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 12),
          ),
          child: Text(forgotPassword),
        ),
      ),
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          showSnackBar(context, loginSuccess, const Duration(seconds: 2));
          Navigator.of(context).pushNamed(HomeScreen.tag);
          //isMobile(context)? print("ID: $staffIDText, password: $passwordText"):
          //print("ID: $compactorIDText, password: $passwordText");
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(green),
        minimumSize: MaterialStateProperty.all(Size(screenWidth(context), 50)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Text(login, style: TextStyle(fontSize: 16, color: white)),
    );
  }

  SizedBox spaceBuild(BuildContext context, double size) {
    return SizedBox(
      height: screenHeight(context) * size,
    );
  }
}
