import '../controllers/controllers.dart';
import 'package:get/get.dart';

class ProjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectController());
    Get.lazyPut(() => ProjectsClient());
    Get.lazyPut(() => AuthenticationController());
  }
}
