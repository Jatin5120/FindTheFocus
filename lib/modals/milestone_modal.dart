import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:find_the_focus/modals/modals.dart';

class Milestone {
  /// User ID associated with Google Account which
  /// currently logged in
  final String userID;

  /// Project Id, It will come from [projects] collection in
  /// [firebase], as a reference as to which project it belongs
  final String projectID;

  /// Uniquely generated ID to identify the milestone
  final String milestoneID;

  /// Name to display to the user
  final String milestoneName;

  /// To determine if the milestone is completed
  final bool isCompleted;

  /// To determine if the milestone is currently in progress
  final bool isUserWorking;

  /// Number of times the user has started the timer and
  /// completed it while the milestone was active
  final int totalWorked;

  /// Starting timestamps stored as epoch, each time the timer was started
  ///
  /// This is for analytics (graph)
  final List<WorkingModal> workingTimes;

  /// color Index to get a unique color for the milestone
  /// (for graph)
  final int colorIndex;

  Milestone({
    required this.userID,
    required this.projectID,
    required this.milestoneID,
    required this.milestoneName,
    required this.isCompleted,
    required this.isUserWorking,
    required this.totalWorked,
    required this.workingTimes,
    required this.colorIndex,
  });

  Milestone copyWith({
    String? userID,
    String? projectID,
    String? milestoneID,
    String? milestoneName,
    bool? isCompleted,
    bool? isUserWorking,
    int? totalWorked,
    List<WorkingModal>? workingTimes,
    int? colorIndex,
  }) {
    return Milestone(
      userID: userID ?? this.userID,
      projectID: projectID ?? this.projectID,
      milestoneID: milestoneID ?? this.milestoneID,
      milestoneName: milestoneName ?? this.milestoneName,
      isCompleted: isCompleted ?? this.isCompleted,
      isUserWorking: isUserWorking ?? this.isUserWorking,
      totalWorked: totalWorked ?? this.totalWorked,
      workingTimes: workingTimes ?? this.workingTimes,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'projectID': projectID,
      'milestoneID': milestoneID,
      'milestoneName': milestoneName,
      'isCompleted': isCompleted,
      'isUserWorking': isUserWorking,
      'totalWorked': totalWorked,
      'workingTimes': workingTimes.map((x) => x.toMap()).toList(),
      'colorIndex': colorIndex,
    };
  }

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      userID: map['userID'],
      projectID: map['projectID'],
      milestoneID: map['milestoneID'],
      milestoneName: map['milestoneName'],
      isCompleted: map['isCompleted'],
      isUserWorking: map['isUserWorking'],
      totalWorked: map['totalWorked'],
      workingTimes: List<WorkingModal>.from(
          map['workingTimes']?.map((x) => WorkingModal.fromMap(x))),
      colorIndex: map['colorIndex'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Milestone.fromJson(String source) =>
      Milestone.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Milestone(userID: $userID, projectID: $projectID, milestoneID: $milestoneID, milestoneName: $milestoneName, isCompleted: $isCompleted, isUserWorking: $isUserWorking, totalWorked: $totalWorked, workingTimes: $workingTimes, colorIndex: $colorIndex)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Milestone &&
        other.userID == userID &&
        other.projectID == projectID &&
        other.milestoneID == milestoneID &&
        other.milestoneName == milestoneName &&
        other.isCompleted == isCompleted &&
        other.isUserWorking == isUserWorking &&
        other.totalWorked == totalWorked &&
        listEquals(other.workingTimes, workingTimes) &&
        other.colorIndex == colorIndex;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        projectID.hashCode ^
        milestoneID.hashCode ^
        milestoneName.hashCode ^
        isCompleted.hashCode ^
        isUserWorking.hashCode ^
        totalWorked.hashCode ^
        workingTimes.hashCode ^
        colorIndex.hashCode;
  }
}
