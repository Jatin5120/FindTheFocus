import '../controllers/controllers.dart';
import 'package:get/get.dart';

class AnalyticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }
}
