import 'package:get/get.dart';

class WorkingTimeController extends GetxController {
  Rx<Duration> _totalTime = Duration(seconds: 0).obs;
  Rx<Duration> _workingTime = Duration(seconds: 0).obs;
  RxBool _isCompleted = false.obs;

  Duration get workingTime => _workingTime.value;

  Duration get totalTime => _totalTime.value;

  bool get isCompleted => _isCompleted.value;

  set workingTime(Duration time) => _workingTime.value = time;

  set totalTime(Duration time) => _totalTime.value = time;

  set isCompleted(bool value) => _isCompleted.value = value;

  updateTime() {
    if (workingTime < totalTime) {
      workingTime += Duration(seconds: 1);
    } else {
      isCompleted = true;
    }
  }

  resetTime() {
    isCompleted = false;
    workingTime = Duration.zero;
  }
}
