// ignore_for_file: avoid_print

import '../../modals/modals.dart';
import '../../screens/screens.dart';
import '../../widgets/widgets.dart';
import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentProject extends StatelessWidget {
  const CurrentProject({Key? key}) : super(key: key);

  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(projectController.currentProject);
    final Size size = Utils.size(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < -12) projectController.selectedIndex = 1;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.03,
        ),
        color: kBackgroundColor[500],
        alignment: Alignment.center,
        child: Obx(() {
          return projectController.currentProject == null
              ? projectController.projects.isEmpty
                  ? const NoProjects()
                  : ProjectDetailView(projectController.projects.first)
              : ProjectDetailView(projectController.currentProject!);
        }),
      ),
    );
  }
}

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView(this.localProject, {Key? key}) : super(key: key);

  final LocalProjectModal localProject;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Column(
      children: [
        Text(
          localProject.projectName,
          style: Get.textTheme.headline5,
        ),
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              color: kBackgroundColor[300],
              borderRadius: kLargeRadius,
              boxShadow: Utils.largeShadow,
            ),
            margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
            alignment: Alignment.center,
            child: Text('${localProject.projectName} Statistics'),
          ),
        ),
        _MileStoneSection(
          milestone: 'Milestones',
          time: 'Time',
          style: Get.textTheme.headline6,
          padding: EdgeInsets.only(bottom: size.height * 0.025),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: localProject.milestones.length,
            itemBuilder: (_, index) {
              final Milestone milestone = localProject.milestones[index];
              int time = 0;

              for (WorkingModal workingModal in milestone.workingTimes) {
                final DateTime startTime = DateTime.fromMicrosecondsSinceEpoch(
                    workingModal.startTimeEpoch);
                final DateTime endTime = DateTime.fromMicrosecondsSinceEpoch(
                    workingModal.endTimeEpoch);
                final Duration duration = endTime.difference(startTime);
                time += duration.inMinutes;
              }

              return _MileStoneSection(
                milestone: milestone.milestoneName,
                time: '$time min',
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyButton.outlined(
            label: 'Start',
            onPressed: () =>
                Get.to(() => WorkingProjectScreen(localProject: localProject)),
            icon: MyIcons.play,
            backgroundColor: kSuccessColor,
            buttonSize: ButtonSize.large,
          ),
        )
      ],
    );
  }
}

class _MileStoneSection extends StatelessWidget {
  const _MileStoneSection({
    Key? key,
    required this.milestone,
    required this.time,
    this.style,
    this.padding,
  }) : super(key: key);

  final String milestone;
  final String time;
  final TextStyle? style;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              milestone,
              style: style ?? Get.textTheme.subtitle1,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: size.width * 0.1),
          Expanded(
            child: Text(
              time,
              style: style ?? Get.textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
