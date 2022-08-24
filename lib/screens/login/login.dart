import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//import files
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
  late PageController _pageController;
  final List<String> _images = [sliderImg_1, sliderImg_2, sliderImg_3];

  bool _isObscure = true;
  String _userIdInput = "";
  String _passwordInput = "";
  int _activePage = 1;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

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
    return Padding(
      padding: _devicePadding(context),
      child: Column(
        children: <Widget>[
          _buildSliderColumn(context),
          _buildSpace(context, 0.03),
          _buildForm(context),
          _forgotPasswordButton(),
          _buildSpace(context, 0.01),
          _loginButton(context),
        ],
      ),
    );
  }

  Column _buildSliderColumn(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: _device.screenWidth(context),
          height: sliderSize(context),
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
        Center(
          child: Text(
            "Lakukan tugasan dengan mudah \n melalui aplikasi",
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
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "Mula guna iWork",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w400, color: greyCustom),
            ),
          ),
        ),
        _indicators(_images.length, _activePage),
      ],
    );
  }

  AnimatedContainer _slider(images, pagePosition, active) {
    double margin = active ? 10 : 20;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(images[pagePosition]), fit: BoxFit.fitHeight)),
    );
  }

/*_imageAnimation(PageController animation, images, pagePosition) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        return SizedBox(
          width: 200,
          height: 200,
          child: widget,
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Image.asset(images[pagePosition]),
          ),
        ],
      ),
    );
  }*/

  SmoothPageIndicator _indicators(imagesLength, currentIndex) {
    return SmoothPageIndicator(
        controller: _pageController,
        count: imagesLength,
        effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            dotColor: grey200,
            activeDotColor: green),
        onDotClicked: (currentIndex) {});
  }

  EdgeInsets _devicePadding(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: loginPadding(context));
  }

  Form _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _idBox(_device.isTablet() ? compactorID : staffID),
            _buildSpace(context, 0.03),
            _passwordBox(),
          ],
        ));
  }

  SizedBox _idBox(String label) {
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
            isDense: true,
            border: const OutlineInputBorder(),
            errorStyle: const TextStyle(fontSize: 10, height: 0.3),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: green)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderTextColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: green),
              borderRadius: BorderRadius.circular(8),
            ),
            labelStyle: TextStyle(
                color: labelColor, fontSize: 15, fontWeight: FontWeight.w400),
            labelText: label),
      ),
    );
  }

  SizedBox _passwordBox() {
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
            isDense: true,
            focusColor: green,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderTextColor),
            ),
            errorStyle: const TextStyle(fontSize: 10, height: 0.3),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: green)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: green),
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

  Align _forgotPasswordButton() {
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
  }

  ElevatedButton _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _handleSubmittedCredential(context);
        //  print("user id = $userIdInput");
        //  print("user password = $passwordInput");
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateColor.resolveWith((states) => green800),
        shadowColor: MaterialStateProperty.all(grey900),
        minimumSize:
            MaterialStateProperty.all(Size(_device.screenWidth(context), 46)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      child: Text(login,
          style: TextStyle(
              fontSize: 15, color: white, fontWeight: FontWeight.w600)),
    );
  }

  SizedBox _buildSpace(BuildContext context, double size) {
    return SizedBox(
      height: _device.screenHeight(context) * size,
    );
  }
}
