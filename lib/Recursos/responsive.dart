import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;
  final double textScaleFactor;

  Responsive(this.context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height,
        textScaleFactor =
            // ignore: deprecated_member_use
            MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.8);

  double width(double percentage) {
    return screenWidth * percentage / 100;
  }

  double height(double percentage) {
    return screenHeight * percentage / 100;
  }

  double fontSize(double percentage) {
    return screenHeight * percentage / 100;
  }

  double iconSize(double percentage) {
    return screenHeight * percentage / 100;
  }
}
