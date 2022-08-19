import 'package:flutter/material.dart';

import '../../config/dimen.dart';
import '../../config/string.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../utils/authentication/auth.dart';
import '../../utils/custom_icon.dart';
import '../../utils/device.dart';
import '../../widgets/alert/toast.dart';
import '../../widgets/alert/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Devices _device = Devices();

  bool _isObscure = true;
  String _userIdInput = "";
  String _passwordInput = "";

  //------------------------------------------------------
  // Validate user id & password.
  //------------------------------------------------------
  void _handleSubmittedCredential(context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      if (Auth.validateCredential(_userIdInput, _passwordInput) != 0) {
        await Auth.handleLogin(_userIdInput,
            Auth.validateCredential(_userIdInput, _passwordInput));
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
        showSnackBar(context, loginSuccess, const Duration(seconds: 2));
      } else {
        showErrorToast(context, loginFail);
      }
    } else {}
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
              spaceBuild(context, 0.02),
              loginButton(context),
              spaceBuild(context, 0.1),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets devicePadding(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: loginPadding(context));
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
      child: TextFormField(
        textInputAction: TextInputAction.next,
        cursorColor: green,
        onSaved: (value) {
          _userIdInput = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sila masukkan $label anda';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintMaxLines: 1,
          filled: true,
          fillColor: white,
          focusColor: green,
          border: const OutlineInputBorder(),
          errorStyle: const TextStyle(fontSize: 10, height: 0.3),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: green)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green),
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: TextStyle(color: black87, fontSize: 14),
          labelText: label,
        ),
      ),
    );
  }

  SizedBox passwordBox() {
    return SizedBox(
      child: TextFormField(
        textInputAction: TextInputAction.done,
        cursorColor: green,
        obscureText: _isObscure,
        onSaved: (val) {
          _passwordInput = val!;
        },
        validator: (val) {
          if (val == null || val.isEmpty) {
            return emptyPassword;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintMaxLines: 1,
            filled: true,
            fillColor: white,
            focusColor: green,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderTextColor),
            ),
            errorStyle: const TextStyle(fontSize: 10, height: 0.3),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: green)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: green),
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: TextStyle(color: black87, fontSize: 14),
            labelText: password,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? CustomIcon.visibilityOn : CustomIcon.visibilityOff,
                color: grey900,
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            )),
      ),
    );
  }

  Padding forgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
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
        _handleSubmittedCredential(context);
        //  print("user id = $userIdInput");
        //  print("user password = $passwordInput");
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(green),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateColor.resolveWith((states) => green800),
        shadowColor: MaterialStateProperty.all(grey900),
        minimumSize:
            MaterialStateProperty.all(Size(_device.screenWidth(context), 50)),
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
