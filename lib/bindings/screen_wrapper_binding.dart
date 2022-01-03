import '../controllers/controllers.dart';
import 'package:get/get.dart';

class ScreenWrapperBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavBarController());
    Get.lazyPut(() => UserDataController());
    Get.lazyPut(() => ProjectController());
    Get.lazyPut(() => QuestionsController());
  }
}
