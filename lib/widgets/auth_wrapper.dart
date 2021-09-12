import '../controllers/controllers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationWrapper extends StatelessWidget {
  static QuestionsController questionsController = Get.find();

  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthenticationController>(builder: (controller) {
      questionsController.checkFirstLogin();
      if (controller.isLoggedIn) {
        controller.signInWithGoogle();
        if (controller.googleAccount != null) {
          Get.put(ProjectsClient());
          return const ScreenWrapper();
        } else {
          return const LoadingScreen('Setting up');
        }
      } else {
        return LoginScreen();
      }
    });
  }
}
