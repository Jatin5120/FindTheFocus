import '../constants/constants.dart';
import '../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectChip extends StatelessWidget {
  ProjectChip({
    Key? key,
    required this.index,
    required this.label,
  }) : super(key: key);

  final int index;
  final String label;

  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return GestureDetector(
          onTap: () => projectController.selectedIndex = index,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Utils.chipRadius,
              color: projectController.selectedIndex == index
                  ? MyColors.secondary
                  : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: Get.textTheme.bodyText1!.copyWith(
                color: projectController.selectedIndex == index
                    ? MyColors.accent
                    : MyColors.disabled,
              ),
            ),
          ),
        );
      }),
    );
  }
}
