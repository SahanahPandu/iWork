import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/palette.dart';

class CustomDialog extends StatefulWidget {
  final Widget? text;

  const CustomDialog({Key? key, this.text}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with TickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(
      vsync: this,
    );

    _lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 200), () {
          Navigator.pop(context);
          _lottieController.reset();
        });
      }
    });
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: LottieBuilder.asset('assets/lottie/lottie_success.json',
                repeat: false,
                height: 160,
                width: 160,
                controller: _lottieController, onLoaded: (composition) {
              _lottieController.duration = composition.duration;
              _lottieController.forward();
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: _textBuilder(),
          )
        ],
      )),
    );
  }

  Widget? _textBuilder() {
    return widget.text;
  }
}
