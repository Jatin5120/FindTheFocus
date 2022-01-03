import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  static ProjectController projectController = Get.find();

  static const List<String> _labels = [
    'Current Project',
    'All Projects',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width.fivePercent),
            child: const SearchBar(title: 'Projects'),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: kChipRadius,
              color: kBackgroundColor[700],
            ),
            // constraints: BoxConstraints(maxHeight: size.height * 0.05),
            height: 48,
            margin: EdgeInsets.symmetric(
              horizontal: size.width.fivePercent,
              vertical: 4,
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                for (int i = 0; i < _labels.length; i++) ...[
                  ProjectChip(index: i, label: _labels[i]),
                ],
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
