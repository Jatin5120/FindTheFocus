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
  AllProjects({Key? key}) : super(key: key);

  final AuthenticationController _authenticationController = Get.find();
  final ProjectController projectController = Get.find();
  final ProjectsClient projectsClient = Get.find();

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
                .collection(MyCollections.projects)
                .doc(_authenticationController.googleAccount!.id)
                .collection(MyCollections.all_projects)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Something went wrong');
              if (snapshot.connectionState == ConnectionState.waiting)
                return LoadingScreen('Fetching');
              return projectsClient.projects.length == 0
                  ? NoProjects()
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: projectsClient.projects.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        Project? project;
                        if (index == projectsClient.projects.length)
                          project = null;
                        else
                          project = projectsClient.projects[index];
                        return ProjectCard(project);
                      },
                    );
            }),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  ProjectCard(this.project, {Key? key}) : super(key: key);

  final Project? project;
  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return project == null
        ? SizedBox(height: size.height.tenPercent)
        : GestureDetector(
            onTap: () {
              projectController.currentProject = project;
              projectController.selectedIndex = 0;
              print(projectController.currentProject?.projectName);
            },
            child: Container(
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColors.background[100],
                    borderRadius: Utils.largeRadius,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.projectName!,
          style: Get.textTheme.headline6,
        ),
        if (project.startingDate != null)
          Text(
            'Starting date:  ${project.startingDate!.displayDateMonth()}',
            style: Get.textTheme.caption!.copyWith(color: MyColors.text[700]),
          ),
        Text(
          'Target date:  ${project.targetDate!.displayDateMonth()}',
          // 'Target date:  ${project.targetDate!.displayDateMonth()}',
          style: Get.textTheme.subtitle2!.copyWith(color: MyColors.text[500]),
        ),
        MyButton.outlined(
          label: 'Start',
          onPressed: () {},
          icon: MyIcons.play,
          backgroundColor: MyColors.success,
          buttonSize: ButtonSize.small,
        )
      ],
    );
  }
}

class _ProjectStats extends StatefulWidget {
  _ProjectStats(
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
    if (widget.project.milestones != null) {
      _completedMilestones = widget.project.completedMilestones!.sum();
      _totalMilestones = widget.project.milestones!.length;
      mileStoneValue = '$_completedMilestones / $_totalMilestones';
    } else {
      mileStoneValue = 'No MileStones Added';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    final double side = size.width * 0.2;
    final int backIndex = Random().nextInt(MyColors.graphColors.length);
    int foreIndex = Random().nextInt(MyColors.graphColors.length);
    while (backIndex == foreIndex) {
      foreIndex = Random().nextInt(MyColors.graphColors.length);
    }
    final double progress = Random().nextDouble();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: side,
          width: side,
          alignment: Alignment.center,
          child: _completedMilestones == 0
              ? Text(
                  'No record',
                  style: Get.textTheme.bodyText2!.copyWith(
                    color: MyColors.text[500],
                  ),
                )
              : CircularProgressIndicator(
                  backgroundColor: MyColors.graphColors[backIndex],
                  color: MyColors.graphColors[foreIndex],
                  strokeWidth: side * 0.2,
                  value: progress,
                ),
        ),
        Text(
          mileStoneValue,
        ),
      ],
    );
  }
}
