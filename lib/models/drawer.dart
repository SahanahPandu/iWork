import 'package:flutter/material.dart';

class Drawers {
  String title;
  IconData iconOutline;
  IconData iconFill;
  String context;
  Color titleColor;

  Drawers(this.title, this.iconOutline, this.iconFill, this.context, [this.titleColor = Colors.black87]);
}