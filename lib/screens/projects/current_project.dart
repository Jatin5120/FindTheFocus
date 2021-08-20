import '../../modals/modals.dart';
import '../../screens/screens.dart';
import '../../widgets/widgets.dart';
import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentProject extends StatelessWidget {
  CurrentProject({Key? key}) : super(key: key);

  final ProjectController projectController = Get.find();
  final ProjectsClient projectsClient = Get.find();

  @override
  Widget build(BuildContext context) {
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
        color: MyColors.background[500],
        alignment: Alignment.center,
        child: Obx(() {
          if (projectController.currentProject == null)
            return ProjectDetailView(projectsClient.projects[0]);
          return ProjectDetailView(projectController.currentProject!);
        }),
      ),
    );
  }
}

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView(this.project, {Key? key}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Column(
      children: [
        Text(
          project.projectName!,
          style: Get.textTheme.headline5,
        ),
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.background[300],
              borderRadius: Utils.largeRadius,
              boxShadow: Utils.largeShadow,
            ),
            margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
            alignment: Alignment.center,
            child: Text('${project.projectName!} Statistics'),
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
              physics: BouncingScrollPhysics(),
              itemCount: project.milestones?.length ?? 0,
              itemBuilder: (_, index) {
                return _MileStoneSection(
                  milestone: project.milestones![index]!,
                  time: 'Time $index',
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyButton.outlined(
            label: 'Start',
            onPressed: () =>
                Get.to(() => WorkingProjectScreen(project: project)),
            icon: MyIcons.play,
            backgroundColor: MyColors.success,
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
