import 'dart:convert';

class Project {
  /// ID associated with Google account to identify projects of user
  final String userID;

  /// Unique ID associated with project
  final String projectID;

  ///The name of the project this will be displayed in the [CurrentProject] screen
  ///if it is the current project. Also it will used to display the statistics in
  ///the [Analytics] screen.
  final String projectName;

  /// number id associated with each project to sort them in app
  final int projectNumber;

  ///The starting date will be added automatically when the user adds the project
  /// startDateEpoch will be DateTime stored as milliseconds
  final int startDateEpoch;

  ///The target date is an of the project is an optional information to be provided
  ///but it can act as a alarm to tell the user about the due date.
  final int? targetDateEpoch;

  ///isCompleted is a boolean value with a default value as [false] used to flag
  ///whether the project is completed or not
  final bool isCompleted;

  /// boolean value which will denote wheather the project is having milestones or not
  final bool haveMilestones;

  Project({
    required this.userID,
    required this.projectID,
    required this.projectName,
    required this.projectNumber,
    required this.startDateEpoch,
    this.targetDateEpoch,
    required this.isCompleted,
    required this.haveMilestones,
  });

  Project copyWith({
    String? userID,
    String? projectID,
    String? projectName,
    int? projectNumber,
    int? startDateEpoch,
    int? targetDateEpoch,
    bool? isCompleted,
    bool? haveMilestones,
  }) {
    return Project(
      userID: userID ?? this.userID,
      projectID: projectID ?? this.projectID,
      projectName: projectName ?? this.projectName,
      projectNumber: projectNumber ?? this.projectNumber,
      startDateEpoch: startDateEpoch ?? this.startDateEpoch,
      targetDateEpoch: targetDateEpoch ?? this.targetDateEpoch,
      isCompleted: isCompleted ?? this.isCompleted,
      haveMilestones: haveMilestones ?? this.haveMilestones,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'projectID': projectID,
      'projectName': projectName,
      'projectNumber': projectNumber,
      'startDateEpoch': startDateEpoch,
      'targetDateEpoch': targetDateEpoch,
      'isCompleted': isCompleted,
      'haveMilestones': haveMilestones,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      userID: map['userID'],
      projectID: map['projectID'],
      projectName: map['projectName'],
      projectNumber: map['projectNumber'],
      startDateEpoch: map['startDateEpoch'],
      targetDateEpoch: map['targetDateEpoch'],
      isCompleted: map['isCompleted'],
      haveMilestones: map['haveMilestones'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(userID: $userID, projectID: $projectID, projectName: $projectName, projectNumber: $projectNumber, startDateEpoch: $startDateEpoch, targetDateEpoch: $targetDateEpoch, isCompleted: $isCompleted, haveMilestones: $haveMilestones)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.userID == userID &&
        other.projectID == projectID &&
        other.projectName == projectName &&
        other.projectNumber == projectNumber &&
        other.startDateEpoch == startDateEpoch &&
        other.targetDateEpoch == targetDateEpoch &&
        other.isCompleted == isCompleted &&
        other.haveMilestones == haveMilestones;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        projectID.hashCode ^
        projectName.hashCode ^
        projectNumber.hashCode ^
        startDateEpoch.hashCode ^
        targetDateEpoch.hashCode ^
        isCompleted.hashCode ^
        haveMilestones.hashCode;
  }
}
