// ignore_for_file: avoid_print

import '../modals/modals.dart';
import 'package:flutter/services.dart';
import '../controllers/controllers.dart';
import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final NavBarController navBarController = Get.find();
  final ProjectController projectController = Get.find();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kSecondaryColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kBackgroundColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: _DashboardHeader()),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width.sevenPercent,
                  vertical: size.height.twoPercent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TitleText('Quick cards'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _BuildQuickCard(
                          child: projectController.currentProject == null &&
                                  projectController.projects.isEmpty
                              ? const _NoProjectsCard()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox.shrink(),
                                    Text(
                                      'Recent work',
                                      style: Get.textTheme.caption,
                                    ),
                                    const SizedBox.shrink(),
                                    Text(
                                      '2.3 Hr',
                                      style: Get.textTheme.headline4,
                                    ),
                                    Obx(() {
                                      final LocalProjectModal localProject =
                                          projectController.currentProject ??
                                              projectController.projects[0];
                                      return Text(
                                        localProject.projectName,
                                        style: Get.textTheme.bodyText1,
                                      );
                                    }),
                                    const SizedBox.shrink(),
                                  ],
                                ),
                        ),
                        _BuildQuickCard(
                          child: projectController.currentProject == null &&
                                  projectController.projects.isEmpty
                              ? const _NoProjectsCard()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('All stats'),
                                    Obx(() {
                                      final LocalProjectModal localProject =
                                          projectController.currentProject ??
                                              projectController.projects[0];
                                      return Text(
                                        localProject.projectName,
                                        style: Get.textTheme.headline6,
                                      );
                                    }),
                                    const SizedBox.shrink(),
                                  ],
                                ),
                        ),
                      ],
                    ),
                    const _TitleText('Navigate'),
                    GestureDetector(
                      onTap: () {
                        navBarController.selectedIndex = 1;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: kCardRadius,
                          color: kBackgroundColor[100],
                        ),
                        height: size.height.twentyPercent,
                        width: size.width.fortyPercent,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width.twoPercent,
                          vertical: size.height.twoPercent,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Projects',
                          style: Get.textTheme.headline4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoProjectsCard extends StatelessWidget {
  const _NoProjectsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "You have worked on anything",
        style: Get.textTheme.subtitle1,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width.twoPercent,
        vertical: size.height.twoPercent,
      ),
      child: Text(
        title,
        style: Get.textTheme.headline6,
      ),
    );
  }
}

class _BuildQuickCard extends StatelessWidget {
  const _BuildQuickCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor[100],
        borderRadius: kCardRadius,
      ),
      height: size.height.fifteenPercent,
      width: size.width.fortyPercent,
      padding: EdgeInsets.symmetric(
        horizontal: size.width.twoPercent,
        vertical: size.height.twoPercent,
      ),
      child: child,
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({Key? key}) : super(key: key);

  static UserDataController userDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    final double imageSize = size.height.tenPercent;
    return Container(
      decoration: const BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      height: size.height.thirtyThreePercent,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: size.height.twoPercent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height.onePercent),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width.sevenPercent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: null,
                  child: const Icon(MyIcons.setting, color: kSecondaryColor),
                ),
                ClipRRect(
                  borderRadius: kChipRadius,
                  child: Image.network(
                    userDataController.user.photoURL ?? '',
                    fit: BoxFit.cover,
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Setting");
                  },
                  child: const Icon(MyIcons.setting, color: kBlackColor),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height.onePercent),
          Text(
            userDataController.user.displayName ?? 'User',
            style: Get.textTheme.headline5!.copyWith(
              color: kBlackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: size.height.onePercent),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width.fivePercent),
            child: Obx(
              () => Row(
                children: [
                  _UserStatsElement(
                    value:
                        userDataController.userModal.totalProjects.toString(),
                    title: 'Projects',
                  ),
                  const _ElementDivider(),
                  _UserStatsElement(
                    value: userDataController.userModal.totalWorkDuration
                        .toString(),
                    title: 'Working time',
                  ),
                  const _ElementDivider(),
                  _UserStatsElement(
                    value: userDataController.userModal.level.toString(),
                    title: 'Level',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height.onePercent),
        ],
      ),
    );
  }
}

class _ElementDivider extends StatelessWidget {
  const _ElementDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: size.height.fivePercent,
        child: VerticalDivider(
          color: kTextColor[700],
          width: size.width.tenPercent,
          thickness: 1,
          endIndent: 5,
          indent: 5,
        ),
      ),
    );
  }
}

class _UserStatsElement extends StatelessWidget {
  const _UserStatsElement({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  final String? value;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value!,
            style: Get.textTheme.bodyText1!
                .copyWith(color: kBlackColor, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: size.height.onePercent),
          Text(
            title!,
            style: Get.textTheme.bodyText2!.copyWith(color: kTextColor[900]),
          ),
        ],
      ),
    );
  }
}
