// ignore_for_file: avoid_print

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screens/screens.dart';
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
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(kProjectsCollection)
                .doc(authenticationController.googleAccount!.id)
                .collection(kAllProjectsCollection)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return const Text('Something went wrong');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen('Fetching');
              }
              return projectController.projects.isEmpty
                  ? const NoProjects()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: projectController.projects.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        Project? project;
                        if (index == projectController.projects.length) {
                          project = null;
                        } else {
                          project = projectController.projects[index];
                        }
                        return ProjectCard(project);
                      },
                    );
            }),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard(this.project, {Key? key}) : super(key: key);

  final Project? project;
  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return project == null
        ? SizedBox(height: size.height.tenPercent)
        : GestureDetector(
            onTap: () {
              projectController.currentProject = project;
              projectController.selectedIndex = 0;
              projectController.currentProjectIndex =
                  projectController.projects.indexOf(project!);
              print(projectController.currentProject?.projectName);
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
                    _ProjectDetails(project!),
                    _ProjectStats(project!),
                  ],
                ),
              ),
            ),
          );
  }
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails(
    this.project, {
    Key? key,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final String startDate =
        DateTime.fromMillisecondsSinceEpoch(project.startDateEpoch)
            .displayDateMonth();
    final String endDate =
        DateTime.fromMillisecondsSinceEpoch(project.targetDateEpoch ?? 0)
            .displayDateMonth();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.projectName,
          style: Get.textTheme.headline6,
        ),
        Text(
          'Starting date:  $startDate',
          style: Get.textTheme.caption!.copyWith(color: kTextColor[700]),
        ),
        if (project.targetDateEpoch != null)
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
    this.project, {
    Key? key,
  }) : super(key: key);

  final Project project;

  @override
  __ProjectStatsState createState() => __ProjectStatsState();
}

class __ProjectStatsState extends State<_ProjectStats> {
  late int _completedMilestones;
  late int _totalMilestones;
  late String mileStoneValue;

  @override
  void initState() {
    super.initState();
    // if (widget.project.milestones != null) {
    //   _completedMilestones = widget.project.completedMilestones!.sum();
    //   _totalMilestones = widget.project.milestones!.length;
    //   mileStoneValue = '$_completedMilestones / $_totalMilestones';
    // } else {
    //   mileStoneValue = 'No MileStones Added';
    // }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    final double side = size.width.fifteenPercent;
    final int backIndex = Random().nextInt(kGraphColors.length);
    int foreIndex = Random().nextInt(kGraphColors.length);
    while (backIndex == foreIndex) {
      foreIndex = Random().nextInt(kGraphColors.length);
    }
    final double progress = Random().nextDouble();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: side,
          width: side,
          child: CircularProgressIndicator(
            backgroundColor: kGraphColors[backIndex],
            color: kGraphColors[foreIndex],
            strokeWidth: side.twentyPercent,
            value: progress,
          ),
          // child: _completedMilestones == 0
          //     ? Text(
          //         'No record',
          //         style: Get.textTheme.bodyText2!.copyWith(
          //           color: kTextColor[500],
          //         ),
          //       )
          //     : CircularProgressIndicator(
          //         backgroundColor: kGraphColors[backIndex],
          //         color: kGraphColors[foreIndex],
          //         strokeWidth: side * 0.2,
          //         value: progress,
          //       ),
        ),
        const Text(
          'mileStoneValue',
        ),
      ],
    );
  }
}
