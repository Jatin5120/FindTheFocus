import 'dart:convert';

class Milestone {
  String? milestoneName;
  int? uniqueIndex;
  int? colorIndex;
  Milestone({
    this.milestoneName,
    this.uniqueIndex,
    this.colorIndex,
  });

  Milestone copyWith({
    String? milestoneName,
    int? uniqueIndex,
    int? colorIndex,
  }) {
    return Milestone(
      milestoneName: milestoneName ?? this.milestoneName,
      uniqueIndex: uniqueIndex ?? this.uniqueIndex,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'milestoneName': milestoneName,
      'uniqueIndex': uniqueIndex,
      'colorIndex': colorIndex,
    };
  }

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      milestoneName: map['milestoneName'],
      uniqueIndex: map['uniqueIndex'],
      colorIndex: map['colorIndex'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Milestone.fromJson(String source) =>
      Milestone.fromMap(json.decode(source));

  @override
  String toString() =>
      'Milestone(milestoneName: $milestoneName, uniqueIndex: $uniqueIndex, colorIndex: $colorIndex)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Milestone &&
        other.milestoneName == milestoneName &&
        other.uniqueIndex == uniqueIndex &&
        other.colorIndex == colorIndex;
  }

  @override
  int get hashCode =>
      milestoneName.hashCode ^ uniqueIndex.hashCode ^ colorIndex.hashCode;
}
