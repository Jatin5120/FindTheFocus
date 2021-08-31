import 'dart:async';
import '../services/services.dart';
import 'package:get/get.dart';

class WorkingTimeController extends GetxController {
  Rx<Duration> _totalTime = Duration(seconds: 0).obs;
  Rx<Duration> _workingTime = Duration(seconds: 0).obs;
  RxBool _isCompleted = false.obs;
  RxBool _activeTimer = true.obs;
  RxBool _cancelTimer = false.obs;
  RxBool _timerPaused = false.obs;

  bool get timerPaused => _timerPaused.value;

  bool get cancelTimer => _cancelTimer.value;

  bool get activeTimer => _activeTimer.value;

  Duration get workingTime => _workingTime.value;

  Duration get totalTime => _totalTime.value;

  bool get isCompleted => _isCompleted.value;

  set timerPaused(bool value) => _timerPaused.value = value;

  set cancelTimer(bool value) => _cancelTimer.value = value;

  set activeTimer(bool value) => _activeTimer.value = value;

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
    activeTimer = true;
    workingTime = Duration.zero;
  }

  appMinimized() {
    if (!timerPaused) {
      const Duration maxDuration = Duration(seconds: 15);
      activeTimer = false;
      timerPaused = true;

      final NotificationService notificationService = NotificationService();
      notificationService.showNotification();

      /// This will run for [Duration] = [maxDuration]
      /// and checks if the screen has resumed
      Timer.periodic(maxDuration, (timer) {
        if (activeTimer) {
          timer.cancel();
        }
      });

      /// This will wait for [Duration] = [maxDuration]
      /// to complete and then check whether to cancel the workingTimer
      /// or not.
      Timer(maxDuration, () {
        if (!activeTimer) {
          isCompleted = true;
          Get.back();
          activeTimer = true;
          print("Timer cancelled");
        }
      });
    }
  }
}
