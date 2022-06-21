import 'package:flutter/material.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenShortSize(BuildContext context) =>
    MediaQuery.of(context).size.shortestSide;

Orientation screenOrientation(BuildContext context) =>
    MediaQuery.of(context).orientation;

bool isMobile(BuildContext context) => screenShortSize(context) < 550;

bool isTablet(BuildContext context) =>
    screenShortSize(context) < 1300 && screenShortSize(context) >= 550;

bool isDesktop(BuildContext context) => screenShortSize(context) >= 1300;

bool isPortrait(BuildContext context) =>
    screenOrientation(context) == Orientation.portrait;

bool isLandscape(BuildContext context) =>
    screenOrientation(context) == Orientation.landscape;

bool isMobilePortrait(BuildContext context) =>
    screenShortSize(context) < 550 &&
    screenOrientation(context) == Orientation.portrait;

bool isTabletPortrait(BuildContext context) =>
    screenShortSize(context) < 1300 &&
    screenShortSize(context) >= 550 &&
    screenOrientation(context) == Orientation.portrait;
