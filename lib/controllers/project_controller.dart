import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/controllers/controllers.dart';

import '../modals/modals.dart';
import '../constants/constants.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController {
  RxInt _selectedIndex = 0.obs;
  Rx<Project?> _currentProject = Rx<Project?>(null);
  RxString _projectName = ''.obs;
  Rx<List<String>> _milestones = Rx<List<String>>([]);
  Rx<DateTime> _targetDate = DateTime.now().obs;

  // --------------------- Project Navigations Methods ---------------------

  ///It can have value either 0 or 1
  ///
  ///Use [ProjectController] to use the selectedIndex.
  ///
  ///Get [Selected Index], Selected index will controll whether
  ///[Current Project] or [All Projects] screen is visible.
  int get selectedIndex => _selectedIndex.value;

  ///It can have value either 0 or 1
  ///
  ///Use [ProjectController] to use the selectedIndex.
  ///
  ///Set [Selected Index] to one of the mentioned above values, Selected index will
  ///controll whether [Current Project] or [All Projects] screen is visible.
  ///
  ///selectedIndex = 0 means [Current Project] screen is visible and
  ///selectedIndex = 1 means [All Projects] screen is visible

  // --------------------- State Management Methods ---------------------

  set selectedIndex(int index) => this._selectedIndex.value = index;

  Project? get currentProject => _currentProject.value;

  set currentProject(Project? project) => _currentProject.value = project;

  // --------------------- Add Project Methods ---------------------

  String get projectName => _projectName.value;

  set projectName(String name) => _projectName.value = name;

  List<String> get milestones => _milestones.value;

  set milestones(List<String> milestoneList) =>
      _milestones.value = milestoneList;

  DateTime get targetDate => _targetDate.value;

  set targetDate(DateTime date) => _targetDate.value = date;

  void createProject() {
    final ProjectsClient projectsClient = Get.find();
    Project project = Project(
      projectName: projectName,
      milestones: milestones,
      startingDate: Timestamp.now(),
      targetDate:
          targetDate == DateTime.now() ? null : Timestamp.fromDate(targetDate),
    );
    projectsClient.projects.add(project);
    projectsClient.projects.obs.refresh();
    currentProject = project;
  }

  // --------------------- Display Methods ---------------------

  String get displayeTargetDate => _targetDate.value.displayDate();

  // --------------------- Discard Project Methods ---------------------

  void discardProject() {
    projectName = '';
    milestones = [];
    targetDate = DateTime.now();
  }
}
