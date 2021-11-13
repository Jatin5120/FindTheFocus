import '../controllers/controllers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationWrapper extends StatelessWidget {
  static UserDataController userDataController = Get.find();
  static AuthenticationController authenticationController = Get.find();

  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authenticationController.isLoggedIn) {
        authenticationController.signInWithGoogle();
        if (userDataController.user != null) {
          Get.put(ProjectsClient());
          return const ScreenWrapper();
        } else {
          return const LoadingScreen();
        }
      } else {
        return const LoginScreen();
      }
    });
  }
}
