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
          decoration: BoxDecoration(
            color: Colors.transparent,
            // color: isSelected ? MyColors.background[300] : Colors.transparent,
            // border: Border(
            //   top: isSelected
            //       ? BorderSide(
            //           color: MyColors.white,
            //           width: Utils.largeBorderWidth,
            //         )
            //       : BorderSide(
            //           color: MyColors.background[100]!,
            //           width: Utils.largeBorderWidth,
            //         ),
            // ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: size.height * 0.004,
                width: isSelected ? size.width * 0.075 : 0,
                decoration: BoxDecoration(
                  borderRadius: Utils.smallRadius,
                  color: MyColors.white,
                  // color: isSelected ? MyColors.white : Colors.transparent,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Icon(
                icon,
                color: isSelected ? MyColors.white : MyColors.disabled,
              ),
            ],
          ),
        ),
      );
    });
  }
}
