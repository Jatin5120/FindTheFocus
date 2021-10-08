// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/modals/modals.dart';
import 'package:find_the_focus/services/firebase_services.dart';
import 'controllers.dart';
import 'package:get/get.dart';

class ProjectsClient extends GetxController {
  Future<void> createProject() async {
    final ProjectController projectController = Get.find();
    final UserDataController userDataController = Get.find();
    Project project = Project(
      userID: userDataController.user.uid,
      projectID: '',
      projectName: projectController.projectName,
      haveMilestones: false,
      isCompleted: false,
      projectNumber: 1,
      startDateEpoch: Timestamp.now().millisecondsSinceEpoch,
      targetDateEpoch: projectController.targetDate == DateTime.now()
          ? null
          : Timestamp.fromDate(projectController.targetDate)
              .millisecondsSinceEpoch,
    );
    // projectController.projects.add(project);
    projectController.projects.obs.refresh();
    // projectController.currentProject = project;
    await FirebaseService.addProject(project);
  }
}
