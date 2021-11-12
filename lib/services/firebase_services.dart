// ignore_for_file: avoid_print
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/constants/collections.dart';
import 'package:find_the_focus/controllers/controllers.dart';
import 'package:find_the_focus/modals/modals.dart';
import 'package:find_the_focus/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseService {
  const FirebaseService._();

  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static final UserDataController _userDataController = Get.find();
  static final ProjectController _projectController = Get.find();

  static final CollectionReference _userCollection =
      _firebaseFirestore.collection(kUserCollection);
  static final CollectionReference _milestonesCollection =
      _firebaseFirestore.collection(kMilestoneCollection);
  static final CollectionReference _projectCollection =
      _firebaseFirestore.collection(kProjectsCollection);
  static final CollectionReference _currentProjectCollection =
      _firebaseFirestore.collection(kCurrentProjectCollection);

  static Future getData() async {
    _userDataController.userModal = await getUserData();
    getProjects();
  }

  static Stream<DocumentSnapshot<Object?>> kStreamUser() =>
      _userCollection.doc(_userDataController.user.uid).snapshots();

  static Future<UserModal> getUserData() async {
    final DocumentReference reference =
        _userCollection.doc(_userDataController.user.uid);
    DocumentSnapshot snapshot = await reference.get();
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print("UserData --> $data");
    return UserModal.fromMap(data);
  }

  static Future getProjects() async {
    QuerySnapshot snapShot = await _projectCollection
        .where('userID', isEqualTo: _userDataController.user.uid)
        .get();
    final List<QueryDocumentSnapshot> docs = snapShot.docs;
    for (QueryDocumentSnapshot doc in docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final Project project = Project.fromMap(data);

      final List<Milestone> _milestones =
          await getMilestones(project.projectID);

      final LocalProjectModal localProjectModal = LocalProjectModal(
        userID: project.userID,
        projectID: project.projectID,
        projectName: project.projectName,
        projectNumber: project.projectNumber,
        startDateEpoch: project.startDateEpoch,
        isCompleted: project.isCompleted,
        haveMilestones: project.haveMilestones,
        milestones: _milestones,
      );
      _projectController.projects.add(localProjectModal);
    }
    _projectController.projects.sort(
        (first, second) => second.projectNumber.compareTo(first.projectNumber));
  }

  static Future<List<Milestone>> getMilestones(String projectID) async {
    QuerySnapshot snapShot = await _milestonesCollection
        .where('projectID', isEqualTo: projectID)
        .get();
    final List<QueryDocumentSnapshot> docs = snapShot.docs;
    final List<Milestone> _milestones = <Milestone>[];

    for (QueryDocumentSnapshot doc in docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final Milestone milestone = Milestone.fromMap(data);

      _milestones.add(milestone);
    }
    return _milestones;
  }

  static Future addNewUser() async {
    final User user = _userDataController.user;

    final UserModal userModal = UserModal(
      username: user.displayName!,
      userID: user.uid,
      email: user.email!,
      totalAchievements: 0,
      totalProjects: 0,
      level: 1,
      timerTime: 0,
      totalWorkDuration: 0,
    );

    try {
      await _userCollection
          .doc(_userDataController.user.uid)
          .set(userModal.toMap());

      _userDataController.userModal = await getUserData();
    } on SocketException {
      print('Internet Connection Problem');
    } catch (e) {
      print("Error --> $e");
    }
  }

  static Future addProject(Project project) async {
    try {
      Get.dialog(const LoadingDialog(message: 'Creating Project'));

      DocumentReference _reference =
          await _projectCollection.add(project.toMap());

      _projectController.projectID = _reference.id;
      await _reference.update({'projectID': _reference.id});

      DocumentReference _userReference =
          _userCollection.doc(_userDataController.user.uid);

      final UserModal userModal = await getUserData();

      _userReference.update({'totalProjects': userModal.totalProjects + 1});
    } on SocketException {
      print('Internet Connection Problem');
    } catch (e) {
      print("Error --> $e");
    } finally {
      Get.back();
    }
  }

  static Future addMilestones(String projectID) async {
    try {
      Get.dialog(const LoadingDialog(message: 'Adding Milestones'));

      if (_projectController.milestones.isNotEmpty) {
        _projectCollection.doc(projectID).update({'haveMilestones': true});

        for (Milestone milestone in _projectController.milestones) {
          DocumentReference _reference =
              await _milestonesCollection.add(milestone.toMap());

          await _reference.update({'milestoneID': _reference.id});
        }
      }
    } on SocketException {
      print('Internet Connection Problem');
    } catch (e) {
      print("Error --> $e");
    } finally {
      Get.back();
    }
  }

  static Future makeCurrentProject(String projectID) async {
    _currentProjectCollection
        .doc(_userDataController.user.uid)
        .set({'projectID': projectID});
  }
}
