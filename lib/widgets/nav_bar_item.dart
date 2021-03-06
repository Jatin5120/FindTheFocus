import '../constants/constants.dart';
import '../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarItem extends StatelessWidget {
  NavBarItem({
    Key? key,
    required this.icon,
    required this.index,
    this.label,
  }) : super(key: key);

  final NavBarController navBarController = Get.find();

  final IconData icon;
  final int index;
  final String? label;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(() {
      final bool isSelected = index == navBarController.selectedIndex;
      return GestureDetector(
        onTap: () {
          navBarController.selectedIndex = index;
        },
        child: Container(
          height: size.height * 0.07,
          width: size.width * 0.25,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: kAnimationDuration,
                curve: Curves.easeInCubic,
                height: size.height * 0.004,
                width: isSelected ? size.width * 0.1 : 0,
                decoration: const BoxDecoration(
                  borderRadius: kSmallRadius,
                  color: kWhiteColor,
                  // color: isSelected ? white : Colors.transparent,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Icon(
                icon,
                color: isSelected ? kWhiteColor : kDisabledColor,
              ),
            ],
          ),
        ),
      );
    });
  }
}
