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
    print("$this --> $match");
    return match;
  }
}

extension DateTimeParser on DateTime {
  String displayDateMonth() {
    return DateFormat('dd MMM').format(this);
  }

  String displayDate() {
    return DateFormat('dd').format(this);
  }
}

extension ListSum on List<int?> {
  int sum() {
    return this.reduce((i, j) => (i ?? 0) + (j ?? 0))!;
  }
}

extension Percent on double {
  double get onePercent => this * 0.01;

  double get twoPercent => this * 0.02;

  double get fivePercent => this * 0.05;

  double get sevenPercent => this * 0.07;

  double get tenPercent => this * 0.1;

  double get fifteenPercent => this * 0.15;

  double get twentyPercent => this * 0.2;

  double get thirtyThreePercent => this * 0.33;

  double get fortyPercent => this * 0.4;

  double get fiftyPercent => this * 0.5;

  double get seventyFivePercent => this * 0.75;
}

extension TimestampParser on Timestamp {
  String displayDate() => this.toDate().displayDate();

  String displayDateMonth() => this.toDate().displayDateMonth();
}
