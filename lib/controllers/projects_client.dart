// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/modals/modals.dart';
import 'package:find_the_focus/services/firebase_services.dart';
import '../constants/constants.dart';
import 'controllers.dart';
import 'package:get/get.dart';

class ProjectsClient extends GetxController {
  final AuthenticationController _authenticationController = Get.find();
  final CollectionReference _projectCollection =
      FirebaseFirestore.instance.collection(kProjectsCollection);
  late CollectionReference _allProjectsCollection;

  final RxList<Project> _projects = <Project>[].obs;

  ProjectsClient() {
    _allProjectsCollection = _projectCollection
        .doc(_authenticationController.googleAccount!.id)
        .collection(kAllProjectsCollection);
  }

  List<Project> get projects => _projects;

  set projects(List<Project> value) => _projects.value = value;

  void get() {
    final ProjectController projectController = Get.find();
    List<Project> projectList = <Project>[];

    _allProjectsCollection.get().then((value) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          value.docs as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
      for (var element in docs) {
        final Project project = Project.fromMap(element.data());
        print(project);
        projectList.add(project);
      }
      projects = projectList.reversed.toList();
    });
    if (projects.isNotEmpty) projectController.currentProject = projects.first;
  }

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
    projects.add(project);
    projects.obs.refresh();
    projectController.currentProject = project;
    await FirebaseService.addProject(project);
    // post();
  }
}
