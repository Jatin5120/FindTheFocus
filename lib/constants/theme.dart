import 'package:find_the_focus/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

ThemeData myTheme = ThemeData(
  primaryColor: kPrimaryColor,
  backgroundColor: kBackgroundColor,
  scaffoldBackgroundColor: kBackgroundColor,
  cardTheme: CardTheme(
    shadowColor: kShadowColor,
    color: kBackgroundColor[100],
  ),
  iconTheme: const IconThemeData(color: kWhiteColor),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: kWhiteColor,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: kLargeRadius,
      borderSide: BorderSide(width: kLargeBorderWidth, color: kPrimaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: kLargeRadius,
      borderSide: BorderSide(width: kLargeBorderWidth, color: kErrorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: kLargeRadius,
      borderSide: BorderSide(width: kLargeBorderWidth, color: kWarningColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: kLargeRadius,
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kAccentColor,
    behavior: SnackBarBehavior.floating,
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 82,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 51,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 41,
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 29,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 17,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.firaSans(
      color: kTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.montserrat(
      color: kTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.montserrat(
      color: kTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.montserrat(
      color: kTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.montserrat(
      color: kTextColor,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.montserrat(
      color: kTextColor,
      fontSize: 9,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  ),
);
