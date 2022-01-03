import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'services/services.dart';
import 'bindings/bindings.dart';
import 'constants/constants.dart';
import 'controllers/controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  initializeControllers();
  await NotificationService().initializeNotification();
  runApp(const MyApp());
}

void initializeControllers() {
  Get.put(StorageController());
  Get.put(UserDataController());
  Get.put(NavBarController());
  Get.put(AuthenticationController());
  Get.put(ProjectController());
  Get.put(WorkingTimeController());
  Get.put(ProjectsClient());
  Get.put(QuestionsController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find The Focus',
      theme: myTheme,
      initialRoute: AppPages.initialRoute,
      initialBinding: AuthBinding(),
      getPages: AppPages.pages,
    );
  }
}
