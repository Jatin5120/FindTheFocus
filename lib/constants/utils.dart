import 'package:flutter/material.dart';
import 'colors.dart';
import 'constants.dart';

class Utils {
  const Utils._();

  static const List<BoxShadow> smallShadow = [
    BoxShadow(
      color: MyColors.shadow,
      offset: Offset(1, 1),
      blurRadius: 5.0,
      spreadRadius: 3.0,
    ),
    BoxShadow(
      color: MyColors.shadow,
      offset: Offset(-1, -1),
      blurRadius: 5.0,
      spreadRadius: 3.0,
    ),
  ];
  static const List<BoxShadow> mediumShadow = [
    BoxShadow(
      color: MyColors.shadow,
      offset: Offset(2, 2),
      blurRadius: 10.0,
      spreadRadius: 5.0,
    ),
    BoxShadow(
      color: MyColors.shadow,
      offset: Offset(-2, -2),
      blurRadius: 10.0,
      spreadRadius: 5.0,
    ),
  ];
  static const List<BoxShadow> largeShadow = [
    BoxShadow(
      color: MyColors.shadow,
      offset: Offset(3, 3),
      blurRadius: 20.0,
      spreadRadius: 10.0,
    ),
    BoxShadow(
      color: MyColors.shadow,
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
  static const double elevation = 10;

  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius mediumRadius =
      BorderRadius.all(Radius.circular(12));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(24));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(28));

  static const OutlinedBorder smallButtonShape =
      RoundedRectangleBorder(borderRadius: smallRadius);
  static const OutlinedBorder mediumButtonShape =
      RoundedRectangleBorder(borderRadius: mediumRadius);
  static const OutlinedBorder largeButtonShape =
      RoundedRectangleBorder(borderRadius: largeRadius);

  static const double smallBorderWidth = 0.5;
  static const double mediumBorderWidth = 1;
  static const double largeBorderWidth = 2;
}
