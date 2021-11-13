import 'package:find_the_focus/modals/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class UserDataController extends GetxController {
  static final StorageController _storageController = Get.find();

  final Rx<List<Project>?> _projects = Rx<List<Project>?>(null);
  final RxBool _isNewUser = true.obs;
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<UserModal> _userModal = Rx<UserModal>(UserModal.empty());

  @override
  onInit() {
    super.onInit();
    isNewUser = _storageController.isNewUser;
  }

  User? get user => _user.value;
  set user(User? user) => _user.value = user;

  UserModal get userModal => _userModal.value;
  set userModal(UserModal userModal) => _userModal.value = userModal;

  bool get isNewUser => _isNewUser.value;
  set isNewUser(bool value) => _isNewUser.value = value;

  List<Project>? get projects => _projects.value;
  set projects(List<Project>? projects) => _projects.value = projects;
}
