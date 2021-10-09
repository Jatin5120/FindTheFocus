// ignore_for_file: avoid_print

import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

import '../../controllers/controllers.dart';
import '../../constants/constants.dart';
import '../../modals/modals.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProjects extends StatelessWidget {
  const AllProjects({Key? key}) : super(key: key);

  static AuthenticationController authenticationController = Get.find();
  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 12) projectController.selectedIndex = 0;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width.fivePercent),
        child: Obx(
          () => projectController.projects.isEmpty
              ? const NoProjects()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: projectController.projects.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    LocalProjectModal? localProject;
                    if (index == projectController.projects.length) {
                      localProject = null;
                    } else {
                      localProject = projectController.projects[index];
                    }
                    return ProjectCard(localProject);
                  },
                ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard(this.localProject, {Key? key}) : super(key: key);

  final LocalProjectModal? localProject;
  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return localProject == null
        ? SizedBox(height: size.height.tenPercent)
        : GestureDetector(
            onTap: () {
              projectController.currentProject = localProject;
              projectController.selectedIndex = 0;
              projectController.currentProjectIndex =
                  projectController.projects.indexOf(localProject!);
            },
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBackgroundColor[100],
                  borderRadius: kLargeRadius,
                  boxShadow: Utils.mediumShadow,
                ),
                margin: EdgeInsets.only(top: size.height * 0.06),
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                  horizontal: size.width * 0.075,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ProjectDetails(localProject!),
                    _ProjectStats(localProject!),
                  ],
                ),
              ),
            ),
          );
  }
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails(
    this.localProject, {
    Key? key,
  }) : super(key: key);

  final LocalProjectModal localProject;

  @override
  Widget build(BuildContext context) {
    final String startDate =
        DateTime.fromMillisecondsSinceEpoch(localProject.startDateEpoch)
            .displayDateMonth();
    final String endDate =
        DateTime.fromMillisecondsSinceEpoch(localProject.targetDateEpoch ?? 0)
            .displayDateMonth();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localProject.projectName,
          style: Get.textTheme.headline6,
        ),
        Text(
          'Starting date:  $startDate',
          style: Get.textTheme.caption!.copyWith(color: kTextColor[700]),
        ),
        if (localProject.targetDateEpoch != null)
          Text(
            'Target date:  $endDate',
            style: Get.textTheme.subtitle2!.copyWith(color: kTextColor[500]),
          ),
        MyButton.outlined(
          label: 'Start',
          onPressed: () {},
          icon: MyIcons.play,
          backgroundColor: kSuccessColor,
          buttonSize: ButtonSize.small,
        )
      ],
    );
  }
}

class _ProjectStats extends StatefulWidget {
  const _ProjectStats(
    this.localProject, {
    Key? key,
  }) : super(key: key);

  final LocalProjectModal localProject;

  @override
  __ProjectStatsState createState() => __ProjectStatsState();
}

class __ProjectStatsState extends State<_ProjectStats> {
  late int _completedMilestones;
  late int _totalMilestones;
  late String mileStoneValue;
  late List<PieChartSectionData> _sections;

  double getTime(List<WorkingModal> workingTimes) {
    double total = 0;
    for (WorkingModal workingModal in workingTimes) {
      final startTime =
          DateTime.fromMillisecondsSinceEpoch(workingModal.startTimeEpoch);
      final endTime =
          DateTime.fromMillisecondsSinceEpoch(workingModal.endTimeEpoch);

      total += endTime.difference(startTime).inMinutes;
    }
    return total;
  }

  setSection(double radius) {
    _sections = widget.localProject.milestones
        .asMap()
        .map<int, PieChartSectionData>((key, milestone) {
          final value = PieChartSectionData(
            color: kGraphColors[milestone.colorIndex],
            // value: getTime(milestone.workingTimes),
            value: 12,
            title: milestone.milestoneName,
            showTitle: false,
            radius: radius,
          );
          return MapEntry(key, value);
        })
        .values
        .toList();
  }

  @override
  void initState() {
    super.initState();
    if (widget.localProject.haveMilestones) {
      _totalMilestones = widget.localProject.milestones.length;
      _completedMilestones = widget.localProject.milestones
          .where((milestone) => milestone.isCompleted == true)
          .length;
      mileStoneValue = '$_completedMilestones / $_totalMilestones';
    } else {
      mileStoneValue = 'No Milestones Added';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    final double side = size.width.twentyFivePercent;
    setSection(side / 4);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: side,
          width: side,
          child: PieChart(
            PieChartData(
              sections: _sections,
              startDegreeOffset: 90,
            ),
          ),
        ),
        Text(
          mileStoneValue,
        ),
      ],
    );
  }
}
