import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../controllers/controllers.dart';
import '../constants/constants.dart';
import '../modals/modals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkingProjectScreen extends StatefulWidget {
  WorkingProjectScreen({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  _WorkingProjectScreenState createState() => _WorkingProjectScreenState();
}

class _WorkingProjectScreenState extends State<WorkingProjectScreen>
    with WidgetsBindingObserver {
  final WorkingTimeController workingTimeController = Get.find();
  late Timer timer;

  void startTimer() {
    workingTimeController.startingTime = Timestamp.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (workingTimeController.isCompleted) {
        timer.cancel();
      } else {
        if (workingTimeController.activeTimer) {
          workingTimeController.updateTime();
          print(workingTimeController.workingTime.toString());
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        print("Resumed");
        workingTimeController.activeTimer = true;
        break;
      case AppLifecycleState.inactive:
        print("Inactive");
        workingTimeController.appMinimized();
        break;
      case AppLifecycleState.detached:
        print("Detached");
        break;
      case AppLifecycleState.paused:
        print("Paused");
        workingTimeController.appMinimized();

        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    SystemChrome.setEnabledSystemUIOverlays([]);
    workingTimeController.isCompleted = true;
    workingTimeController.totalTime = Duration(minutes: 1);
    workingTimeController.resetTime();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _showExitDialog({required String message, required Widget action}) {
    showDialog(
        context: context,
        builder: (_) =>
            _BuildExitAlertDialog(message: message, action: action));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return WillPopScope(
      onWillPop: () async {
        _showExitDialog(
          message:
              "By closing this screen will you'll loose your current progress.",
          action: _BuildPopButton(
            label: 'Exit',
            onPressed: () {
              Navigator.pop(context);
              workingTimeController.isCompleted = true;
              Get.back();
            },
            color: kErrorColor,
          ),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: Utils.scaffoldPadding(size).copyWith(
              bottom: size.height.tenPercent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.project.projectName ?? 'Project',
                    style: Get.textTheme.headline4,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    height: size.width.seventyFivePercent,
                    width: size.width.seventyFivePercent,
                    child: Obx(
                      () => CircularPercentIndicator(
                        radius: size.width.seventyFivePercent,
                        lineWidth: size.width.fivePercent,
                        backgroundWidth: size.width.onePercent,
                        progressColor: kWarningColor,
                        backgroundColor: kBackgroundColor[700]!,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        animateFromLastPercent: true,
                        curve: Curves.easeInOut,
                        percent: (workingTimeController.workingTime.inSeconds /
                                workingTimeController.totalTime.inSeconds)
                            .clamp(0.0, 1.0),
                        center: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kAccentColor,
                          ),
                          padding: EdgeInsets.all(size.width.fivePercent),
                          child: InkWell(
                            onTap: () => _showExitDialog(
                              message:
                                  "You've not worked for the target time of the day. There's more you can achieve than this",
                              action: _BuildPopButton(
                                label: "I'm Done",
                                onPressed: () {
                                  Navigator.pop(context);
                                  workingTimeController.isCompleted = true;
                                  Get.back();
                                },
                                color: kErrorColor,
                              ),
                            ),
                            child: Icon(
                              MyIcons.check,
                              size: size.width.tenPercent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Keep Working, You’ll place your Hand on the Target you have Eyes On.',
                      style: Get.textTheme.bodyText2!
                          .copyWith(color: kTextColor[500]),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildExitAlertDialog extends StatelessWidget {
  _BuildExitAlertDialog({
    Key? key,
    required this.message,
    required this.action,
    this.title,
  }) : super(key: key);

  final String? title;
  final String? message;
  final Widget action;

  final WorkingTimeController workingTimeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return AlertDialog(
      elevation: kElevation,
      backgroundColor: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(borderRadius: kSmallRadius),
      title: Text(title ?? 'Are you Sure?'),
      content: Text(
        message!,
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: size.width.twoPercent),
      actions: [
        action,
        _BuildPopButton(
          label: 'Keep Working',
          onPressed: () {
            Navigator.pop(context);
          },
          color: kSuccessColor,
        ),
      ],
    );
  }
}

class _BuildPopButton extends StatelessWidget {
  const _BuildPopButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(onPrimary: color),
      onPressed: onPressed,
      child: Text(
        label,
        style: Get.textTheme.button!.copyWith(color: color),
      ),
    );
  }
}
