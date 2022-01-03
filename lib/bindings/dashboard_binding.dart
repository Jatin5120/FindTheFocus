import '../controllers/controllers.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavBarController());
    Get.lazyPut(() => ProjectController());
  }
}
