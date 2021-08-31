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

  RxList<Project> _projects = <Project>[].obs;

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
      projects = projectList.reversed.toList();
    });
  }

  void post() {
    print('Project to add -> ${projects.last}');
    _allProjectsCollection
        .doc('${projects.length - 1}')
        .set(projects.last.toMap())
        .then((value) => print('${projects.last.projectName} Added'))
        .catchError((error) => print("Failed to add: $error"));
  }
}
