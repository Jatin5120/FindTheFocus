import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'modals.dart';

class Project {
  ///The name of the project this will be displayed in the [CurrentProject] screen
  ///if it is the current project. Also it will used to display the statistics in
  ///the [Analytics] screen.
  String? projectName;

  ///This is [List] of Milestones which one can add, this will make the work statistics
  ///more organised and clear to understand the time spent while working.
  List<Milestone?>? milestones;

  ///The starting date will be added automatically when the user adds the project
  Timestamp? startingDate;
  // DateTime? startingDate;

  ///The target date is an of the project is an optional information to be provided
  ///but it can act as a alarm to tell the user about the due date.
  Timestamp? targetDate;

  ///The total working time will be recorded as the user starts the timer when the
  ///work is started. This will be used in [Analytics panel].
  List<WorkingModal>? workingTime;

  ///isCompleted is a boolean value with a default value as [false] used to flag
  ///whether the project is completed or not
  bool? isCompleted;

  List<int?>? completedMilestones;

  Project({
    required this.projectName,
    this.milestones,
    this.startingDate,
    this.targetDate,
    this.workingTime,
    this.isCompleted = false,
    this.completedMilestones,
  }) {
    if (milestones != null) {
      completedMilestones = List.generate(milestones!.length, (index) => 0);
    } else {
      completedMilestones = null;
    }
    workingTime = [];
  }

  Project copyWith({
    String? projectName,
    List<Milestone?>? milestones,
    Timestamp? startingDate,
    Timestamp? targetDate,
    List<WorkingModal>? workingTime,
    bool? isCompleted,
    List<int?>? completedMilestones,
  }) {
    return Project(
      projectName: projectName ?? this.projectName,
      milestones: milestones ?? this.milestones,
      startingDate: startingDate ?? this.startingDate,
      targetDate: targetDate ?? this.targetDate,
      workingTime: workingTime ?? this.workingTime,
      isCompleted: isCompleted ?? this.isCompleted,
      completedMilestones: completedMilestones ?? this.completedMilestones,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectName': projectName,
      'milestones': milestones?.map((milestone) => milestone!.toMap()).toList(),
      'startingDate': startingDate,
      'targetDate': targetDate,
      'workingTime': workingTime?.map((element) => element.toMap()).toList(),
      'isCompleted': isCompleted,
      'completedMilestones': completedMilestones?.toList(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      projectName: map['projectName'],
      milestones: List<Milestone?>.from(
          map['milestones'].map((milestone) => Milestone.fromMap(milestone))),
      startingDate: map['startingDate'],
      targetDate: map['targetDate'],
      workingTime: List<WorkingModal>.from(map['workingTime']),
      isCompleted: map['isCompleted'],
      completedMilestones: List<int?>.from(map['completedMilestones']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(projectName: $projectName, milestones: $milestones, startingDate: $startingDate, targetDate: $targetDate, workingTime: $workingTime, isCompleted: $isCompleted, completedMilestones: $completedMilestones)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.projectName == projectName &&
        listEquals(other.milestones, milestones) &&
        other.startingDate == startingDate &&
        other.targetDate == targetDate &&
        listEquals(other.workingTime, workingTime) &&
        other.isCompleted == isCompleted &&
        listEquals(other.completedMilestones, completedMilestones);
  }

  @override
  int get hashCode {
    return projectName.hashCode ^
        milestones.hashCode ^
        startingDate.hashCode ^
        targetDate.hashCode ^
        workingTime.hashCode ^
        isCompleted.hashCode ^
        completedMilestones.hashCode;
  }
}
