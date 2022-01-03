import '../controllers/controllers.dart';
import 'package:get/get.dart';

class QuestionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionsBinding());
    Get.lazyPut(() => UserDataController());
    Get.lazyPut(() => StorageController());
  }
}
