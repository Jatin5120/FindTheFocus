import 'package:find_the_focus/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

ThemeData myTheme = ThemeData(
  primaryColor: MyColors.primary,
  accentColor: MyColors.accent,
  backgroundColor: MyColors.background,
  scaffoldBackgroundColor: MyColors.background,
  cardTheme: CardTheme(
    shadowColor: MyColors.shadow,
    color: MyColors.background[100],
  ),
  iconTheme: IconThemeData(color: MyColors.white),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: MyColors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: Utils.largeRadius,
      borderSide:
          BorderSide(width: Utils.largeBorderWidth, color: MyColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: Utils.largeRadius,
      borderSide:
          BorderSide(width: Utils.largeBorderWidth, color: MyColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: Utils.largeRadius,
      borderSide:
          BorderSide(width: Utils.largeBorderWidth, color: MyColors.warning),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: Utils.largeRadius,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: MyColors.accent,
    behavior: SnackBarBehavior.floating,
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 82,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 51,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 41,
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 29,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 17,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.firaSans(
      color: MyColors.text,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.montserrat(
      color: MyColors.text,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.montserrat(
      color: MyColors.text,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.montserrat(
      color: MyColors.text,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.montserrat(
      color: MyColors.text,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.montserrat(
      color: MyColors.text,
      fontSize: 9,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  ),
);
