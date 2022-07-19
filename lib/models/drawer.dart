import 'package:flutter/material.dart';

class Drawers {
  String title;
  IconData iconName;
  String context;
  Color titleColor;

  Drawers(this.title, this.iconName, this.context, [this.titleColor = Colors.black87]);
}