import 'package:eswm/config/dimen.dart';
import 'package:flutter/material.dart';

import '../../config/string.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../utils/device.dart';
import '../../widgets/alert/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Devices _device = Devices();

  bool _isObscure = true;
  late String _userIdInput;
  late String _passwordInput;

  //------------------------------------------------------
  // Validate user id & password.
  //------------------------------------------------------
  void credentialValidate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      showSnackBar(context, loginSuccess, const Duration(seconds: 2));
      Navigator.of(context).pushReplacementNamed('/home');
      _formKey.currentState?.reset();
    }
  }

  //------------------------------------------------------
  // Build widget.
  //------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: devicePadding(context),
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

  EdgeInsets devicePadding(BuildContext context) {
    return EdgeInsets.symmetric(
        horizontal: loginPadding(context));
  }

  Center imageBuild(BuildContext context, double top, double widthSz,
      double heightSz, String image) {
    return Center(
        child: Container(
            padding: EdgeInsets.only(
                left: 0,
                right: 0,
                top: (_device.screenHeight(context) * top),
                bottom: 0),
            width: _device.screenWidth(context) * widthSz,
            height: _device.screenHeight(context) * heightSz,
            child: Image.asset(image)));
  }

  Form formBuild(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            idBox(_device.isTablet() ? compactorID : staffID),
            spaceBuild(context, 0.02),
            passwordBox(),
          ],
        ));
  }

  SizedBox idBox(String label) {
    return SizedBox(
      height: 55.0,
      child: TextFormField(
        cursorColor: green,
        autofocus: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sila masukkan $label anda';
          } else {
            if (label == compactorID) {
              _userIdInput = value;
            } else {
              _userIdInput = value;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          hintMaxLines: 1,
          filled: true,
          fillColor: grey200,
          focusColor: green,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: TextStyle(color: black87, fontSize: 14),
          labelText: label,
          suffixIcon: label == password
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: grey900,
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

  SizedBox passwordBox() {
    return SizedBox(
      height: 55.0,
      child: TextFormField(
        cursorColor: green,
        autofocus: false,
        obscureText: _isObscure,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return emptyPassword;
          } else {
              _passwordInput = val;
          }
          return null;
        },
        decoration: InputDecoration(
          hintMaxLines: 1,
          filled: true,
          fillColor: grey200,
          focusColor: green,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: TextStyle(color: black87, fontSize: 14),
          labelText: password,
          suffixIcon:IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: grey900,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          )
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
        credentialValidate(context);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(green),
        elevation: MaterialStateProperty.all(3),
        shadowColor: MaterialStateProperty.all(grey900),
        minimumSize: MaterialStateProperty.all(Size(_device.screenWidth(context), 50)),
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
      height: _device.screenHeight(context) * size,
    );
  }
}
