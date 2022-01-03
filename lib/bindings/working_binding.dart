import '../controllers/controllers.dart';
import 'package:get/get.dart';

class WorkingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkingTimeController());
  }
}
