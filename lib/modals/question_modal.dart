import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionModal {
  final String question;
  final List<String> answers;
  final List<int> weightages;

  QuestionModal({
    required this.question,
    required this.answers,
    required this.weightages,
  }) : assert(
          answers.length == weightages.length,
          'Number of Answers should match with Number of Weightage points',
        );

  QuestionModal copyWith({
    String? question,
    List<String>? answers,
    List<int>? weightages,
  }) {
    return QuestionModal(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      weightages: weightages ?? this.weightages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
      'weightages': weightages,
    };
  }

  factory QuestionModal.fromMap(Map<String, dynamic> map) {
    return QuestionModal(
      question: map['question'],
      answers: List<String>.from(map['answers']),
      weightages: List<int>.from(map['weightages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModal.fromJson(String source) =>
      QuestionModal.fromMap(json.decode(source));

  @override
  String toString() =>
      'QuestionModal(question: $question, answers: $answers, weightages: $weightages)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionModal &&
        other.question == question &&
        listEquals(other.answers, answers) &&
        listEquals(other.weightages, weightages);
  }

  @override
  int get hashCode =>
      question.hashCode ^ answers.hashCode ^ weightages.hashCode;
}
