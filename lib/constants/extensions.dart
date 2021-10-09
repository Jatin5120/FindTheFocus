import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this);
  }

  bool isValidName() {
    bool match = RegExp(r"^[A-Za-z]\\w{5, 29}$").hasMatch(this);
    return match;
  }
}

extension DateTimeParser on DateTime {
  String displayDateMonth() {
    return DateFormat('MMM dd').format(this);
  }

  String displayDate() {
    return DateFormat('dd').format(this);
  }
}

extension Percent on double {
  double get onePercent => this * 0.01;

  double get twoPercent => this * 0.02;

  double get twoDotFivePercent => this * 0.025;

  double get threePercent => this * 0.03;

  double get fivePercent => this * 0.05;

  double get sevenPercent => this * 0.07;

  double get tenPercent => this * 0.1;

  double get fifteenPercent => this * 0.15;

  double get twentyPercent => this * 0.2;

  double get twentyFivePercent => this * 0.25;

  double get thirtyThreePercent => this * 0.33;

  double get fortyPercent => this * 0.4;

  double get fiftyPercent => this * 0.5;

  double get seventyFivePercent => this * 0.75;
}

extension TimestampParser on Timestamp {
  String displayDate() => toDate().displayDate();

  String displayDateMonth() => toDate().displayDateMonth();
}

extension ListItemSum on List<int> {
  int get sum {
    int total = 0;
    map((value) => total += value);
    return total;
  }
}

extension Value on List {
  int get uniqueValueIndex => Random().nextInt(length);
}
