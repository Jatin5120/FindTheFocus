import '../constants/constants.dart';
import '../controllers/controllers.dart';
import '../widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeControllers();
  runApp(MyApp());
}

void initializeControllers() async {
  Get.put(AuthenticationController());
  Get.put(NavBarController());
  Get.put(ProjectController());
  Get.put(WorkingTimeController());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find The Focus',
      theme: myTheme,
      home: AuthenticationWrapper(),
    );
  }
}
