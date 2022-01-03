import '../controllers/controllers.dart';
import 'package:get/get.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavBarController());
    Get.lazyPut(() => AuthenticationController());
  }
}
