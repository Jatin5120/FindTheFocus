import 'package:flutter/material.dart';

class MyColors {
  static const MaterialColor primary = MaterialColor(0xFF1EA5FC, {
    300: Color(0xFF68C3FD),
    500: Color(0xFF1EA5FC),
    700: Color(0xFF037AC9),
  });

  static const MaterialColor secondary = MaterialColor(0xFFD8E9FF, {
    300: Color(0xFFECF4FF),
    500: Color(0xFFD8E9FF),
  });

  static const Color accent = Color(0xFF8D13EC);

  static const MaterialColor background = MaterialColor(0xFF101323, {
    100: Color(0xFF1B1E32),
    300: Color(0xFF16192B),
    500: Color(0xFF101323),
    700: Color(0xFF0C0E1C),
    900: Color(0xFF060813),
  });

  static const MaterialColor text = MaterialColor(0xFFFFFFFF, {
    300: Color(0xFFFFFFFF),
    500: Color(0xFFBBBBBB),
    700: Color(0xFF888888),
    900: Color(0xFF444444),
  });

  static const Color subtitle = Color(0x88FFFFFF);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color shadow = Color(0x330C0E1c);

  static const Color success = Color(0xFF00CD71);
  static const Color warning = Color(0xFFFEC539);
  static const Color error = Color(0xFFFF4033);

  static const Color disabled = Color(0x55FFFFFF);

  static const List<Color> _gradient1 = [
    Color(0xFF330867),
    Color(0xFF30CFD0),
  ];
  static const List<Color> _gradient2 = [
    Color(0xFFFF145F),
    Color(0xFFFFC42D),
  ];
  static const List<Color> _gradient3 = [
    Color(0xFFBB0FE0),
    Color(0xFF00F5C0),
  ];
  static const List<Color> _gradient4 = [
    Color(0xFF635EE2),
    Color(0xFFD3F5CF),
  ];
  static const List<Color> _gradient5 = [
    Color(0xFF12E7DD),
    Color(0xFF43F461),
  ];
  static const List<Color> _gradient6 = [
    Color(0xFF80F8AE),
    Color(0xFFDFF494),
  ];
  static const List<Color> _gradient7 = [
    Color(0xFF623AA2),
    Color(0xFFF97794),
  ];
  static const List<Color> _gradient8 = [
    Color(0xFF635EE2),
    Color(0xFFA8DBFA),
  ];

  static const List<List<Color>> gradients = [
    _gradient1,
    _gradient2,
    _gradient3,
    _gradient4,
    _gradient5,
    _gradient6,
    _gradient7,
    _gradient8,
  ];

  static const List<Color> graphColors = [
    Color(0xFF4382BB),
    Color(0xFFDB93A5),
    Color(0xFF5B6D5B),
    Color(0xFFF27348),
    Color(0xFFBEAEE2),
    Color(0xFF2DB4AF),
    Color(0xFFEF4349),
    Color(0xFFF7CE76),
    Color(0xFF98D4BB),
    Color(0xFFD29F8C),
  ];
}
