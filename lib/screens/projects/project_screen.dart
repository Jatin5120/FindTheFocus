import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import '../../widgets/widgets.dart';
import 'projects.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          const SearchBar(title: 'Projects'),
          Container(
            decoration: BoxDecoration(
              borderRadius: kChipRadius,
              color: kBackgroundColor[700],
            ),
            constraints: BoxConstraints(maxHeight: size.height * 0.05),
            padding: EdgeInsets.all(size.height * 0.005),
            child: Row(
              children: [
                ProjectChip(index: 0, label: 'Current Project'),
                ProjectChip(index: 1, label: 'All Projects'),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (projectController.selectedIndex == 0) {
                return const CurrentProject();
              } else {
                return const AllProjects();
              }
            }),
          ),
        ],
      ),
    );
  }
}
