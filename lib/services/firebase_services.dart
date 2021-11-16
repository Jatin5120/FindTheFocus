// ignore_for_file: avoid_print
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/services/dialog_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constants/collections.dart';
import '../controllers/controllers.dart';
import '../modals/modals.dart';
import '../widgets/widgets.dart';

class FirebaseService {
  const FirebaseService._();

  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static final UserDataController _userDataController = Get.find();
  static final ProjectController _projectController = Get.find();

  /// -------------------- [References] --------------------------

  static final CollectionReference _userCollection =
      _firebaseFirestore.collection(kUserCollection);
  static final CollectionReference _milestonesCollection =
      _firebaseFirestore.collection(kMilestoneCollection);
  static final CollectionReference _projectCollection =
      _firebaseFirestore.collection(kProjectsCollection);
  static final CollectionReference _currentProjectCollection =
      _firebaseFirestore.collection(kCurrentProjectCollection);

  static final DocumentReference _currentProjectDocument =
      _currentProjectCollection.doc(_userDataController.user!.uid);

  /// -------------------- [Streams] --------------------------

  static Stream<DocumentSnapshot<Object?>> get kUserStream =>
      _userCollection.doc(_userDataController.user!.uid).snapshots();

  static Stream<QuerySnapshot<Object?>> get kProjectsStream =>
      _projectCollection
          .where('userID', isEqualTo: _userDataController.user!.uid)
          .snapshots();

  static Stream<QuerySnapshot<Object?>> kMilestonesStream(String projectID) =>
      _milestonesCollection
          .where('projectID', isEqualTo: projectID)
          .snapshots();

  static Future<DocumentSnapshot<Object?>> get kCurrentProjectDOcument =>
      _currentProjectDocument.get();

  static Stream<DocumentSnapshot<Object?>> kCurrentProjectStream(
          String projectID) =>
      _projectCollection.doc(projectID).snapshots();

  /// -------------------- [Methods] --------------------------

  static Future<void> setCurrentProject(String projectID) =>
      _currentProjectDocument.set({'projectID': projectID});

  static Future addNewUser() async {
    final User user = _userDataController.user!;

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
          .doc(_userDataController.user!.uid)
          .set(userModal.toMap());
    } on SocketException {
      print('Internet Connection Problem');
    } catch (e) {
      print("Error --> $e");
    }
  }

  static Future addProject(Project project) async {
    try {
      DialogService.showLoadingDialog('Creating Project');

      DocumentReference _reference =
          await _projectCollection.add(project.toMap());

      _projectController.projectID = _reference.id;
      await _reference.update({'projectID': _reference.id});

      DocumentReference _userReference =
          _userCollection.doc(_userDataController.user!.uid);

      _userReference.update({
        'totalProjects': _userDataController.userModal.totalProjects + 1,
      });
    } on SocketException {
      print('Internet Connection Problem');
      DialogService.showErrorDialog(
        title: 'Error uploading',
        message: 'Please Check your internet connectivity',
      );
    } catch (e) {
      print("Error --> $e");
    } finally {
      DialogService.closeDialog();
    }
  }

  static Future addMilestones(String projectID) async {
    try {
      DialogService.showLoadingDialog('Adding Milestones');

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
      DialogService.showErrorDialog(
        title: 'Error uploading Milestones',
        message: 'Please Check your internet connectivity',
      );
    } catch (e) {
      print("Error --> $e");
    } finally {
      DialogService.closeDialog();
    }
  }
}
