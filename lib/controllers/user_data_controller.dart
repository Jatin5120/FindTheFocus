import 'package:find_the_focus/modals/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  final Rx<List<Project>?> _projects = Rx<List<Project>?>(null);
  final RxBool _isNewUser = true.obs;
  late User user;
  final Rx<UserModal> _userModal = Rx<UserModal>(UserModal.empty());

  UserModal get userModal => _userModal.value;
  set userModal(UserModal userModal) => _userModal.value = userModal;

  bool get isNewUser => _isNewUser.value;
  set isNewUser(bool value) => _isNewUser.value = value;

  List<Project>? get projects => _projects.value;
  set projects(List<Project>? projects) => _projects.value = projects;
}
