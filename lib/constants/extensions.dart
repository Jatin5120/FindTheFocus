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

extension Percentage on double {
  double get onePercent => (this * 0.01).roundToDouble();

  double get twoPercent => (this * 0.02).roundToDouble();

  double get twoDotFivePercent => (this * 0.025).roundToDouble();

  double get threePercent => (this * 0.03).roundToDouble();

  double get fivePercent => (this * 0.05).roundToDouble();

  double get sixPointFivePercent => (this * 0.065).roundToDouble();

  double get sevenPointFivePercent => (this * 0.075).roundToDouble();

  double get tenPercent => (this * 0.1).roundToDouble();

  double get twelvePercent => (this * 0.12).roundToDouble();

  double get fifteenPercent => (this * 0.15).roundToDouble();

  double get twentyPercent => (this * 0.2).roundToDouble();

  double get twentyFivePercent => (this * 0.25).roundToDouble();

  double get thirtyPercent => (this * 0.3).roundToDouble();

  double get thirtyThreePercent => (this * 0.33).roundToDouble();

  double get thirtyFivePercent => (this * 0.35).roundToDouble();

  double get fortyPercent => (this * 0.4).roundToDouble();

  double get fiftyPercent => (this * 0.5).roundToDouble();

  double get seventyPercent => (this * 0.7).roundToDouble();

  double get seventyFivePercent => (this * 0.75).roundToDouble();

  double get eightyPercent => (this * 0.8).roundToDouble();

  double get eightyFivePercent => (this * 0.85).roundToDouble();

  double get ninetyPercent => (this * 0.9).roundToDouble();

  double get ninetyFivePercent => (this * 0.95).roundToDouble();
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
