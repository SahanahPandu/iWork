import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class TimeLogRippleButton extends StatefulWidget {
  final String btnText;
  final Color btnColor;

  const TimeLogRippleButton(
      {Key? key, required this.btnText, required this.btnColor})
      : super(key: key);

  @override
  State<TimeLogRippleButton> createState() => _TimeLogRippleButtonState();
}

class _TimeLogRippleButtonState extends State<TimeLogRippleButton> {
  @override
  Widget build(BuildContext context) {
    return RippleAnimation(
      delay: const Duration(milliseconds: 100),
      //duration: const Duration(milliseconds: 2000),
      repeat: true,
      color: widget.btnColor,
      minRadius: 40,
      ripplesCount: 15,
      child: Container(
        width: 250,
        height: 150,
        decoration: BoxDecoration(
          color: widget.btnColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            widget.btnText,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
