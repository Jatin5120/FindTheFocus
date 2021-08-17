import 'package:find_the_focus/services/services.dart';

import '../controllers/controllers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationWrapper extends StatelessWidget {
  final ProjectsClient projectsClient = ProjectsClient();
  @override
  Widget build(BuildContext context) {
    return GetX<AuthenticationController>(builder: (controller) {
      if (controller.isLoggedIn) {
        controller.signInWithGoogle();
        if (controller.googleAccount != null) {
          projectsClient.get();
          return ScreenWrapper();
        } else
          return LoadingScreen('Setting up');
      } else
        return LoginScreen();
    });
  }
}
