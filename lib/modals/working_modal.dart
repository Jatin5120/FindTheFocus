import 'dart:convert';

class WorkingModal {
  ///Start Time denotes the time stamp in epochs when the working on the project is started
  final int startTimeEpoch;

  ///Stop Time denotes the time stamp in epochs when the working on the project is stopped
  final int endTimeEpoch;

  WorkingModal({
    required this.startTimeEpoch,
    required this.endTimeEpoch,
  });

  WorkingModal copyWith({
    int? startTimeEpoch,
    int? endTimeEpoch,
  }) {
    return WorkingModal(
      startTimeEpoch: startTimeEpoch ?? this.startTimeEpoch,
      endTimeEpoch: endTimeEpoch ?? this.endTimeEpoch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTimeEpoch': startTimeEpoch,
      'endTimeEpoch': endTimeEpoch,
    };
  }

  factory WorkingModal.fromMap(Map<String, dynamic> map) {
    return WorkingModal(
      startTimeEpoch: map['startTimeEpoch'],
      endTimeEpoch: map['endTimeEpoch'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingModal.fromJson(String source) =>
      WorkingModal.fromMap(json.decode(source));

  @override
  String toString() =>
      'WorkingModal(startTimeEpoch: $startTimeEpoch, endTimeEpoch: $endTimeEpoch)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkingModal &&
        other.startTimeEpoch == startTimeEpoch &&
        other.endTimeEpoch == endTimeEpoch;
  }

  @override
  int get hashCode => startTimeEpoch.hashCode ^ endTimeEpoch.hashCode;
}
