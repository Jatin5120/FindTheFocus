import '../controllers/controllers.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageController());
    Get.lazyPut(() => UserDataController());
    Get.lazyPut(() => AuthenticationController());
  }
}
