import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../modals/modals.dart';
import 'controllers.dart';

class UserDataController extends GetxController {
  static final StorageController _storageController = Get.find();

  final Rx<List<Project>?> _projects = Rx<List<Project>?>(null);
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<UserModal> _userModal = Rx<UserModal>(UserModal.empty());
  final RxInt _workTime = kInitialWorkMinutes.obs;

  @override
  onReady() {
    super.onReady();
    workTime = _storageController.workTime;
  }

  int get workTime => _workTime.value;
  set workTime(int workTime) => _workTime.value = workTime;

  User? get user => _user.value;
  set user(User? user) => _user.value = user;

  UserModal get userModal => _userModal.value;
  set userModal(UserModal userModal) => _userModal.value = userModal;

  List<Project>? get projects => _projects.value;
  set projects(List<Project>? projects) => _projects.value = projects;
}
