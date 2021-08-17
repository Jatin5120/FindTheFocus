import 'package:find_the_focus/modals/modals.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'controllers.dart';

class UserDataController extends GetxController {
//   UserDataController() {
//     authenticationController = Get.find();
//   }
//   AuthenticationController authenticationController =
//       AuthenticationController();

//   Rx<GoogleSignInAccount?> user =
//       authenticationController.googleAccount.value.obs;

  Rx<List<Project>?> _projects = Rx<List<Project>?>(null);

  List<Project>? get projects => _projects.value;

  set projects(List<Project>? projects) => _projects.value = projects;
}
