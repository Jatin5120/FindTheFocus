import 'package:find_the_focus/bindings/bindings.dart';

import '../controllers/controllers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  static final UserDataController _userDataController = Get.find();
  static final AuthenticationController _authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_authenticationController.isLoggedIn) {
        _authenticationController.signInWithGoogle();
        if (_userDataController.user != null) {
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
