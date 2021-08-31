import '../constants/constants.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NoProjects extends StatelessWidget {
  const NoProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height.sevenPercent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Looks like you haven't worked on anything yet.",
              style: Get.textTheme.subtitle1,
            ),
            SizedBox(height: size.height.twoPercent),
            SizedBox(
              height: size.width / 2,
              width: size.width / 2,
              child: GestureDetector(
                onTap: () => Get.to(() => AddProject()),
                child: SvgPicture.asset('assets/images/add_files.svg'),
              ),
            ),
            SizedBox(height: size.height.twoPercent),
            Text(
              "Create New Project and start working",
              style: Get.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height.fivePercent),
            MyButton(
              label: 'Create Project',
              onPressed: () => Get.to(() => AddProject()),
              buttonSize: ButtonSize.large,
            ),
          ],
        ),
      ),
    );
  }
}
