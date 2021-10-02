import 'dart:convert';

class UserModal {
  /// Username accessed from Google account
  String username;

  /// UserID associated with Google account
  String userID;

  /// EmailID taken from Google account
  String email;

  /// totalAchievements represents the number of times the user has started
  /// the timer and completed it
  ///
  /// at start it will be 0
  int totalAchievements;

  /// workingDuration represents the total working duration in minutes
  ///
  /// at start it will be 0
  int timerTime;

  /// Total number of [Projects] that user has
  int totalProjects;

  /// This is the total duration (in seconds Epoch) for which the user has worked
  int totalWorkDuration;

  /// The focus level of user based on the user's progress
  int level;

  UserModal({
    required this.username,
    required this.userID,
    required this.email,
    required this.totalAchievements,
    required this.timerTime,
    required this.totalProjects,
    required this.totalWorkDuration,
    required this.level,
  });

  UserModal copyWith({
    String? username,
    String? userID,
    String? email,
    int? totalAchievements,
    int? timerTime,
    int? totalProjects,
    int? totalWorkDuration,
    int? level,
  }) {
    return UserModal(
      username: username ?? this.username,
      userID: userID ?? this.userID,
      email: email ?? this.email,
      totalAchievements: totalAchievements ?? this.totalAchievements,
      timerTime: timerTime ?? this.timerTime,
      totalProjects: totalProjects ?? this.totalProjects,
      totalWorkDuration: totalWorkDuration ?? this.totalWorkDuration,
      level: level ?? this.level,
    );
  }

  factory UserModal.empty() {
    return UserModal(
      username: '',
      userID: '',
      email: '',
      totalAchievements: 0,
      timerTime: 0,
      totalProjects: 0,
      totalWorkDuration: 0,
      level: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userID': userID,
      'email': email,
      'totalAchievements': totalAchievements,
      'timerTime': timerTime,
      'totalProjects': totalProjects,
      'totalWorkDuration': totalWorkDuration,
      'level': level,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      username: map['username'],
      userID: map['userID'],
      email: map['email'],
      totalAchievements: map['totalAchievements'],
      timerTime: map['timerTime'],
      totalProjects: map['totalProjects'],
      totalWorkDuration: map['totalWorkDuration'],
      level: map['level'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModal.fromJson(String source) =>
      UserModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModal(username: $username, userID: $userID, email: $email, totalAchievements: $totalAchievements, timerTime: $timerTime, totalProjects: $totalProjects, totalWorkDuration: $totalWorkDuration, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModal &&
        other.username == username &&
        other.userID == userID &&
        other.email == email &&
        other.totalAchievements == totalAchievements &&
        other.timerTime == timerTime &&
        other.totalProjects == totalProjects &&
        other.totalWorkDuration == totalWorkDuration &&
        other.level == level;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        userID.hashCode ^
        email.hashCode ^
        totalAchievements.hashCode ^
        timerTime.hashCode ^
        totalProjects.hashCode ^
        totalWorkDuration.hashCode ^
        level.hashCode;
  }
}
