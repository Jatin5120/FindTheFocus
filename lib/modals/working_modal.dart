import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkingModal {
  ///Start Time denotes the time stamp when the working on the project is started
  Timestamp? startTime;

  ///Stop Time denotes the time stamp when the working on the project is stopped
  Timestamp? stopTime;

  ///Milestone index is the index of the milestone which is currently active
  int? milestoneIndex;

  WorkingModal({
    this.startTime,
    this.stopTime,
    this.milestoneIndex,
  });

  WorkingModal copyWith({
    Timestamp? startTime,
    Timestamp? stopTime,
    int? milestoneIndex,
  }) {
    return WorkingModal(
      startTime: startTime ?? this.startTime,
      stopTime: stopTime ?? this.stopTime,
      milestoneIndex: milestoneIndex ?? this.milestoneIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'stopTime': stopTime,
      'milestoneIndex': milestoneIndex,
    };
  }

  factory WorkingModal.fromMap(Map<String, dynamic> map) {
    return WorkingModal(
      startTime: map['startTime'],
      stopTime: map['stopTime'],
      milestoneIndex: map['milestoneIndex'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingModal.fromJson(String source) =>
      WorkingModal.fromMap(json.decode(source));

  @override
  String toString() =>
      'WorkingModal(startTime: $startTime, stopTime: $stopTime, milestoneIndex: $milestoneIndex)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkingModal &&
        other.startTime == startTime &&
        other.stopTime == stopTime &&
        other.milestoneIndex == milestoneIndex;
  }

  @override
  int get hashCode =>
      startTime.hashCode ^ stopTime.hashCode ^ milestoneIndex.hashCode;
}
