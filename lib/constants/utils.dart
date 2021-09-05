import 'package:flutter/material.dart';
import 'colors.dart';
import 'constants.dart';

class Utils {
  const Utils._();

  static const List<BoxShadow> smallShadow = [
    BoxShadow(
      color: kShadowColor,
      offset: Offset(1, 1),
      blurRadius: 5.0,
      spreadRadius: 3.0,
    ),
    BoxShadow(
      color: kShadowColor,
      offset: Offset(-1, -1),
      blurRadius: 5.0,
      spreadRadius: 3.0,
    ),
  ];
  static const List<BoxShadow> mediumShadow = [
    BoxShadow(
      color: kShadowColor,
      offset: Offset(2, 2),
      blurRadius: 10.0,
      spreadRadius: 5.0,
    ),
    BoxShadow(
      color: kShadowColor,
      offset: Offset(-2, -2),
      blurRadius: 10.0,
      spreadRadius: 5.0,
    ),
  ];
  static const List<BoxShadow> largeShadow = [
    BoxShadow(
      color: kShadowColor,
      offset: Offset(3, 3),
      blurRadius: 20.0,
      spreadRadius: 10.0,
    ),
    BoxShadow(
      color: kShadowColor,
      offset: Offset(-3, -3),
      blurRadius: 20.0,
      spreadRadius: 10.0,
    ),
  ];

  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static EdgeInsets scaffoldPadding(Size size) => EdgeInsets.symmetric(
        horizontal: size.width.tenPercent,
        vertical: size.height.fivePercent,
      );
}
