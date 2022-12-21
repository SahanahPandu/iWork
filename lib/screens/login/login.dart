import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../config/string.dart';
import '../../utils/authentication/auth.dart';
import '../../utils/authentication/role.dart';
import '../../utils/device/devices.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/lottie_alert_dialog.dart';
import '../../widgets/alert/snackbar.dart';
import '../../widgets/alert/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late PageController _pageController;
  final List<String> _images = [sliderImg_1, sliderImg_2, sliderImg_3];
  bool _isObscure = true;
  late String _userIdInput, _passwordInput = "";
  int _activePage = 1;
  Color borderColorId = borderTextColor;
  Color borderColorPswd = borderTextColor;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  //------------------------------------------------------
  // Build widget.
  //------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _devicePadding(context),
      child: Column(
        children: <Widget>[
          _buildSliderColumn(context),
          Devices().isPhone()
              ? _buildSpace(context, 0.06)
              : _buildSpace(context, 0.025),
          _buildForm(context),
          //_forgotPasswordButton(),
          Devices().isPhone() || Orientations().isTabletPortrait(context)
              ? _buildSpace(context, 0.06)
              : _buildSpace(context, 0.005),
          _loginButton(context),
        ],
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _idBox(Devices().isTablet() ? compactorID : staffID),
            _buildSpace(context, 0.03),
            _passwordBox(),
          ],
        ));
  }

  Column _buildSliderColumn(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Sizes().screenWidth(context),
          height: sliderHeight(context),
          child: ScrollConfiguration(
            behavior:
                const MaterialScrollBehavior().copyWith(overscroll: false),
            child: PageView.builder(
                itemCount: _images.length,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _activePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  bool active = pagePosition == _activePage;
                  return _slider(_images, pagePosition, active);
                }),
          ),
        ),
        SizedBox(
            height:
                Devices().isPhone() || !Orientations().isTabletPortrait(context)
                    ? 0
                    : 10),
        _indicators(_images.length, _activePage),
      ],
    );
  }

  SizedBox _buildSpace(BuildContext context, double size) {
    return SizedBox(
      height: Sizes().screenHeight(context) * size,
    );
  }

  EdgeInsets _devicePadding(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: loginPadding(context));
  }

  /// Temporarily disable forgot password function
  /* Align _forgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          primary: blackCustom,
          textStyle: const TextStyle(fontSize: 13),
        ),
        child: Text(forgotPassword),
      ),
    );
  }*/

  //------------------------------------------------------
  // Validate user id & password.
  //------------------------------------------------------
  void _handleSubmittedCredential(context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      int validateResult =
          await Auth.validateCredential(_userIdInput, _passwordInput);
      if (validateResult == 1) {
        if (userInfo[3] != '') {
          Roles.setRole(userInfo[3]);
        }
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
        showSnackBar(context, loginSuccess, const Duration(seconds: 2));
      } else if (validateResult == 2) {
        showErrorToast(context, loginFail);
      } else if (validateResult == 5) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return showAlertDialog(
                  context,
                  confirmation,
                  "ID peranti yang didaftar anda tidak sama. Adakah anda pasti ini peranti baru anda?",
                  cancel,
                  yes);
            }).then((actionText) async {
          if (actionText == yes) {
            var result =
                await Auth.getDeviceIdResponse(_userIdInput.toUpperCase());
            if (result == 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showLottieAlertDialog(
                      context,
                      _textBuilder(),
                      "",
                      null,
                      null,
                    );
                  });
            } else {
              showErrorToast(context,
                  "Pertukaran ID peranti anda gagal. Sila semak id anda atau cuba semula");
            }
          }
        });
        //showErrorToast(context, "ID peranti anda tidak sama!");
      } else if (validateResult == 7) {
        showErrorToast(context, "ID anda tidak sah. Sila cuba semula!");
      } else if (validateResult != 1 ||
          validateResult != 2 ||
          validateResult != 5) {
        showErrorToast(
            context, "Masalah sambungan internet. Sila cuba semula!");
      }
    } else {}
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Peranti baru anda berjaya didaftar. Sila log masuk semula",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5)));
  }

  SizedBox _idBox(String label) {
    return SizedBox(
      width: Devices().isPhone() ? Sizes().screenWidth(context) * 0.88 : null,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        cursorColor: greenCustom,
        cursorWidth: 1.2,
        onSaved: (value) {
          _userIdInput = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sila masukkan $label anda';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            borderColorId = greenCustom;
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintMaxLines: 1,
            filled: true,
            fillColor: white,
            focusColor: greenCustom,
            isDense: true,
            border: const OutlineInputBorder(),
            errorStyle: const TextStyle(fontSize: 10, height: 0.3),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: red, width: 0.5)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: greenCustom, width: 0.8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColorId, width: 0.8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greenCustom, width: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            labelStyle: TextStyle(
                color: labelColor, fontSize: 15, fontWeight: FontWeight.w400),
            labelText: label),
      ),
    );
  }

  SmoothPageIndicator _indicators(imagesLength, currentIndex) {
    return SmoothPageIndicator(
        controller: _pageController,
        count: imagesLength,
        effect: WormEffect(
            dotHeight: Devices().isPhone() ? 8 : 9,
            dotWidth: Devices().isPhone() ? 8 : 9,
            dotColor: grey200,
            activeDotColor: greenCustom),
        onDotClicked: (currentIndex) {});
  }

  ElevatedButton _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _handleSubmittedCredential(context);
        //  print("user id = $userIdInput");
        //  print("user password = $passwordInput");
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(greenCustom),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateColor.resolveWith((states) => green800),
        shadowColor: MaterialStateProperty.all(grey900),
        minimumSize:
            MaterialStateProperty.all(Size(Sizes().screenWidth(context), 46)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(login,
          style: TextStyle(
              fontSize: 15, color: white, fontWeight: FontWeight.w600)),
    );
  }

  SizedBox _passwordBox() {
    return SizedBox(
      width: Devices().isPhone() ? Sizes().screenWidth(context) * 0.88 : null,
      child: TextFormField(
        textInputAction: TextInputAction.done,
        cursorColor: greenCustom,
        cursorWidth: 1.2,
        obscureText: _isObscure,
        onSaved: (val) {
          _passwordInput = val!;
        },
        onChanged: (val) {
          setState(() {
            borderColorPswd = greenCustom;
          });
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
            isDense: true,
            focusColor: greenCustom,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColorPswd, width: 0.8),
            ),
            errorStyle: const TextStyle(fontSize: 10, height: 0.3),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: red, width: 0.5)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: greenCustom, width: 0.8)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greenCustom, width: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            labelStyle: TextStyle(
                color: labelColor, fontSize: 15, fontWeight: FontWeight.w400),
            labelText: password,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? CustomIcon.visibilityOn : CustomIcon.visibilityOff,
                color: blackCustom,
                size: 16,
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

  AnimatedContainer _slider(images, pagePosition, active) {
    double margin = active ? 5 : 10;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        margin: EdgeInsets.all(margin),
        /*  decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(images[pagePosition]), fit: BoxFit.fitHeight)),*/
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 160,
                  child:
                      Image.asset(images[pagePosition], fit: BoxFit.fitHeight)),
              const SizedBox(height: 10),
              Column(children: [
                Center(
                  child: Text(
                    Devices().isPhone()
                        ? "Lakukan tugasan dengan mudah \n melalui aplikasi"
                        : "Lakukan tugasan dengan mudah melalui aplikasi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: blackCustom),
                  ),
                ),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 0),
                        child: Text(
                          "Mula guna iWork",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: greyCustom),
                        )))
              ])
            ]));
  }
}
