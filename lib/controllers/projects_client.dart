import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/modals/modals.dart';
import '../constants/constants.dart';
import 'controllers.dart';
import 'package:get/get.dart';

class ProjectsClient extends GetxController {
  final AuthenticationController _authenticationController = Get.find();
  final CollectionReference _projectCollection =
      FirebaseFirestore.instance.collection(MyCollections.projects);
  late CollectionReference _allProjectsCollection;

  RxList<Project> _projects = [
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
  ].obs;

  ProjectsClient() {
    _allProjectsCollection = _projectCollection
        .doc(_authenticationController.googleAccount!.id)
        .collection(MyCollections.all_projects);
  }

  List<Project> get projects => _projects.value;

  set projects(List<Project> value) => _projects.value = value;

  void get() {
    List<Project> projectList = <Project>[];

    _allProjectsCollection.get().then((value) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          value.docs as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
      docs.forEach((element) {
        final Project project = Project.fromMap(element.data());
        print(project);
        projectList.add(project);
      });
      projects = projectList;
    });
    // Stream<QuerySnapshot<Map<String, dynamic>>> snapShot = _projectCollection
    //     .doc(_authenticationController.googleAccount!.id)
    //     .collection(MyCollections.all_projects)
    //     .snapshots();
    // print(snapShot);
  }

  void post() {
    for (int i = 0; i < projects.length; i++)
      _allProjectsCollection
          .doc('$i')
          .set(projects[i].toMap())
          .then((value) => print("Project Added"))
          .catchError((error) => print("Failed to add: $error"));
  }
}