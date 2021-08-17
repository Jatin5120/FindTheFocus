import 'package:cloud_firestore/cloud_firestore.dart';

import '../modals/modals.dart';

List<Project> projects = [
  Project(
    projectName: 'FindTheFocus',
    milestones: [
      'Logo designing',
      'Design System',
      'UI Design',
      'Prototyping',
      'Front-end',
      'Back-end',
      'Testing',
    ],
    startingDate: Timestamp.fromDate(DateTime(2021, DateTime.july, 1)),
    targetDate: Timestamp.fromDate(DateTime(2021, DateTime.august, 28)),
  ),
  Project(
    projectName: 'College App',
    milestones: [
      'Design System',
      'UI Design',
      'Prototyping',
      'Front-end',
      'Back-end',
      'Testing',
    ],
    startingDate: Timestamp.fromDate(DateTime(2021, DateTime.march, 1)),
    targetDate: Timestamp.fromDate(DateTime(2021, DateTime.june, 18)),
  ),
];
