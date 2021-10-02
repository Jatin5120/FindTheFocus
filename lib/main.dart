import '../services/services.dart';
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
  await NotificationService().initializeNotification();
  runApp(const MyApp());
}

void initializeControllers() async {
  Get.lazyPut(() => AuthenticationController());
  Get.lazyPut(() => NavBarController());
  Get.lazyPut(() => ProjectController());
  Get.lazyPut(() => WorkingTimeController());
  Get.lazyPut(() => ProjectsClient());
  Get.lazyPut(() => QuestionsController());
  Get.lazyPut(() => UserDataController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find The Focus',
      theme: myTheme,
      // home: const ObjectiveQuestions(),
      home: const AuthenticationWrapper(),
    );
  }
}
