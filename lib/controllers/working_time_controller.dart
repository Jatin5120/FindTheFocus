// ignore_for_file: avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/controllers.dart';
import '../constants/constants.dart';
import '../modals/modals.dart';
import '../services/services.dart';
import 'package:get/get.dart';

class WorkingTimeController extends GetxController {
  final Rx<Duration> _totalTime = const Duration(seconds: 0).obs;
  final Rx<Duration> _workingTime = const Duration(seconds: 0).obs;
  final RxBool _isCompleted = false.obs;
  final RxBool _activeTimer = true.obs;
  final RxBool _timerPaused = false.obs;
  late Timestamp startingTime;

  bool get timerPaused => _timerPaused.value;

  bool get activeTimer => _activeTimer.value;

  Duration get workingTime => _workingTime.value;

  Duration get totalTime => _totalTime.value;

  bool get isCompleted => _isCompleted.value;

  set timerPaused(bool value) => _timerPaused.value = value;

  set activeTimer(bool value) => _activeTimer.value = value;

  set workingTime(Duration time) => _workingTime.value = time;

  set totalTime(Duration time) => _totalTime.value = time;

  set isCompleted(bool value) => _isCompleted.value = value;

  updateTime() {
    if (workingTime < totalTime) {
      workingTime += const Duration(seconds: 1);
    } else {
      final ProjectController projectController = Get.find();
      final ProjectsClient projectsClient = Get.find();
      final WorkingModal workingModal = WorkingModal(
        startTime: startingTime,
        stopTime: Timestamp.now(),
        milestoneIndex:
            projectController.currentProject?.completedMilestones?.sum(),
      );
      print(workingModal);
      projectsClient
          .projects[projectController.currentProjectIndex].workingTime!
          .add(workingModal);
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
