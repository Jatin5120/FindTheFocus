// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import '../../modals/modals.dart';
import '../../services/firebase_services.dart';
import '../../widgets/widgets.dart';

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
        padding: EdgeInsets.symmetric(
          horizontal: size.width.fivePercent,
          vertical: size.height.threePercent,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseService.kProjectsStream,
            builder: (context, projectSnapshot) {
              if (!projectSnapshot.hasData) {
                return const SizedBox();
              }
              List<QueryDocumentSnapshot> projectDocs =
                  projectSnapshot.data!.docs;

              if (projectDocs.isEmpty) {
                return const NoProjects();
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: projectDocs.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == projectDocs.length) {
                    return SizedBox(height: size.height.tenPercent);
                  }
                  final Project project = Project.fromMap(
                    projectDocs[index].data() as Map<String, dynamic>,
                  );
                  return StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseService.kMilestonesStream(project.projectID),
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
                          userID: project.userID,
                          projectID: project.projectID,
                          projectName: project.projectName,
                          projectNumber: project.projectNumber,
                          startDateEpoch: project.startDateEpoch,
                          isCompleted: project.isCompleted,
                          haveMilestones: project.haveMilestones,
                          milestones: milestones,
                        );

                        return ProjectCard(localProject);
                      });
                },
              );
            }),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard(this.localProject, {Key? key}) : super(key: key);

  final LocalProjectModal localProject;
  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return GestureDetector(
      onTap: () {
        projectController.currentProject = localProject;
        projectController.selectedIndex = 0;
        projectController.currentProjectIndex =
            projectController.projects.indexOf(localProject);
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
          margin: EdgeInsets.only(top: size.height.fivePercent),
          padding: EdgeInsets.all(size.width.sevenPercent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ProjectDetails(localProject),
              _ProjectStats(localProject),
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
    final double side = size.width.twentyPercent;
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
