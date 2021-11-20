// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/services/firebase_services.dart';
import 'package:fl_chart/fl_chart.dart';

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
          horizontal: size.width.fivePercent,
          vertical: size.height.threePercent,
        ),
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseService.kCurrentProjectDocument,
          builder: (context, future) {
            if (!future.hasData) return const SizedBox();

            Map<String, dynamic> project =
                future.data!.data() as Map<String, dynamic>;

            return StreamBuilder<DocumentSnapshot>(
              stream:
                  FirebaseService.kCurrentProjectStream(project['projectID']),
              builder: (context, projectSnapshot) {
                if (!projectSnapshot.hasData) return const SizedBox();
                final Project currentProject = Project.fromMap(
                  projectSnapshot.data!.data() as Map<String, dynamic>,
                );
                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseService.kMilestonesStream(
                        currentProject.projectID),
                    builder: (context, milestoneSnapshot) {
                      if (!milestoneSnapshot.hasData) {
                        return const SizedBox();
                      }
                      List<QueryDocumentSnapshot> milestoneDocs =
                          milestoneSnapshot.data!.docs;

                      List<Milestone> milestones = milestoneDocs
                          .map(
                            (doc) => Milestone.fromMap(
                                doc.data() as Map<String, dynamic>),
                          )
                          .toList();

                      LocalProjectModal? localProject = LocalProjectModal(
                        userID: currentProject.userID,
                        projectID: currentProject.projectID,
                        projectName: currentProject.projectName,
                        projectNumber: currentProject.projectNumber,
                        startDateEpoch: currentProject.startDateEpoch,
                        isCompleted: currentProject.isCompleted,
                        haveMilestones: currentProject.haveMilestones,
                        milestones: milestones,
                      );
                      return ProjectDetailView(localProject);
                      // return Obx(
                      //   () {
                      //     return projectController.currentProject == null
                      //         ? projectController.projects.isEmpty
                      //             ? const NoProjects()
                      //             : ProjectDetailView(
                      //                 projectController.projects.first)
                      //         : ProjectDetailView(
                      //             projectController.currentProject!);
                      //   },
                      // );
                    });
              },
            );
          },
        ),
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
        BarStats(localProject),
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
          child: Button.outlined(
            label: 'Start',
            onTap: () =>
                Get.to(() => WorkingProjectScreen(localProject: localProject)),
            //TODO: Add icon to button
            // icon: MyIcons.play,
            buttonColor: kSuccessColor,
            buttonSize: ButtonSize.large,
          ),
        )
      ],
    );
  }
}

class BarStats extends StatelessWidget {
  const BarStats(
    this.localProject, {
    Key? key,
  }) : super(key: key);

  final LocalProjectModal localProject;

  List<BarChartGroupData> getBarData() {
    List<BarChartGroupData> _barGroups = <BarChartGroupData>[];

    for (Milestone milestone in localProject.milestones) {
      int value = localProject.milestones.indexOf(milestone) + 1;
      BarChartGroupData barChartGroupData = BarChartGroupData(
        x: value,
        barRods: [
          BarChartRodData(
            y: value.toDouble(),
            width: 12,
            colors: [kGraphColors[milestone.colorIndex]],
          ),
        ],
      );
      _barGroups.add(barChartGroupData);
    }

    return _barGroups;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor[300],
          borderRadius: kLargeRadius,
          boxShadow: Utils.largeShadow,
        ),
        margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
        padding: EdgeInsets.symmetric(
          vertical: size.height.twoDotFivePercent,
          horizontal: size.width.sevenPointFivePercent,
        ),
        alignment: Alignment.center,
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            barGroups: getBarData(),
            titlesData: FlTitlesData(show: false),
          ),
        ),
      ),
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
