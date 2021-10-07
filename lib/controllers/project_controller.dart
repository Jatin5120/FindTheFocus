import '../modals/modals.dart';
import '../constants/constants.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  final Rx<Project?> _currentProject = Rx<Project?>(null);
  final RxInt _currentProjectIndex = 0.obs;
  final RxString _projectName = ''.obs;
  final RxString _projectID = ''.obs;
  final Rx<List<Milestone>> _milestones = Rx<List<Milestone>>([]);
  final Rx<DateTime> _targetDate = DateTime.now().obs;
  final RxList<Project> _projects = <Project>[].obs;

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

  set selectedIndex(int index) => _selectedIndex.value = index;

  Project? get currentProject => _currentProject.value;
  set currentProject(Project? project) => _currentProject.value = project;

  int get currentProjectIndex => _currentProjectIndex.value;
  set currentProjectIndex(int value) => _currentProjectIndex.value = value;

  // --------------------- Add Project Methods ---------------------

  List<Project> get projects => _projects;
  set projects(List<Project> value) => _projects.value = value;

  String get projectName => _projectName.value;
  set projectName(String name) => _projectName.value = name;

  String get projectID => _projectID.value;
  set projectID(String name) => _projectID.value = name;

  List<Milestone> get milestones => _milestones.value;
  set milestones(List<Milestone> milestoneList) =>
      _milestones.value = milestoneList;

  DateTime get targetDate => _targetDate.value;

  set targetDate(DateTime date) => _targetDate.value = date;

  // --------------------- Display Methods ---------------------

  String get displayeTargetDate => _targetDate.value.displayDate();

  String get displayeTargetDateMonth => _targetDate.value.displayDateMonth();

  // --------------------- Compare Methods ---------------------

  bool milestonesContains(String value) {
    final List<bool> matchValues = [];
    for (Milestone milestone in milestones) {
      matchValues
          .add(milestone.milestoneName.toLowerCase() == value.toLowerCase());
    }
    return matchValues.contains(true);
  }

  // --------------------- Discard Project Methods ---------------------

  void discardProject() {
    projectName = '';
    milestones = [];
    targetDate = DateTime.now();
  }
}
