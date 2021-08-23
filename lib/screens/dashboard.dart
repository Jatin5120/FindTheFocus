import '../modals/modals.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controllers/controllers.dart';
import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final NavBarController navBarController = Get.find();
  final ProjectController projectController = Get.find();
  final ProjectsClient projectsClient = Get.find();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: MyColors.secondary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: MyColors.background,
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
          Expanded(child: _DashboardHeader()),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width.sevenPercent,
                  vertical: size.height.twoPercent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleText('Quick cards'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _BuildQuickCard(
                          child: projectController.currentProject == null &&
                                  projectsClient.projects.isEmpty
                              ? _NoProjectsCard()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox.shrink(),
                                    Text(
                                      'Recent work',
                                      style: Get.textTheme.caption,
                                    ),
                                    SizedBox.shrink(),
                                    Text(
                                      '2.3 Hr',
                                      style: Get.textTheme.headline4,
                                    ),
                                    Obx(() {
                                      final Project project =
                                          projectController.currentProject ??
                                              projectsClient.projects[0];
                                      return Text(
                                        project.projectName ?? '',
                                        style: Get.textTheme.bodyText1,
                                      );
                                    }),
                                    SizedBox.shrink(),
                                  ],
                                ),
                        ),
                        _BuildQuickCard(
                          child: projectController.currentProject == null &&
                                  projectsClient.projects.isEmpty
                              ? _NoProjectsCard()
                              : Column(
                                  children: [
                                    Text('All stats'),
                                    Obx(() {
                                      final Project project =
                                          projectController.currentProject ??
                                              projectsClient.projects[0];
                                      return Text(
                                        project.projectName ?? '',
                                        style: Get.textTheme.headline6,
                                      );
                                    }),
                                  ],
                                ),
                        ),
                      ],
                    ),
                    _TitleText('Navigate'),
                    GestureDetector(
                      onTap: () {
                        navBarController.selectedIndex = 1;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: Utils.cardRadius,
                          color: MyColors.background[100],
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
  _TitleText(
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
  _BuildQuickCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Container(
      decoration: BoxDecoration(
          color: MyColors.background[100], borderRadius: Utils.cardRadius),
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
  _DashboardHeader({
    Key? key,
  }) : super(key: key);

  final AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    final double imageSize = 80 * (size.width / 414);
    final GoogleSignInAccount? user = authenticationController.googleAccount;
    return Container(
      decoration: BoxDecoration(
        color: MyColors.secondary,
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
                  child: Icon(MyIcons.setting, color: MyColors.secondary),
                ),
                ClipRRect(
                  borderRadius: Utils.chipRadius,
                  child: Image.network(
                    user?.photoUrl ?? '',
                    fit: BoxFit.cover,
                    // scale: scale,
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Setting");
                  },
                  child: Icon(MyIcons.setting, color: MyColors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height.onePercent),
          Text(
            user?.displayName ?? 'User',
            style: Get.textTheme.headline5!
                .copyWith(color: MyColors.black, fontWeight: FontWeight.w700),
          ),

          /// TODO: Remove Email from Dashboard
          Text(
            user?.email ?? '',
            style: Get.textTheme.subtitle2!.copyWith(color: MyColors.text[900]),
          ),
          SizedBox(height: size.height.onePercent),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width.fivePercent),
            child: Row(
              children: [
                _UserStatsElement(value: '7', title: 'Projects'),
                _ElementDivider(),
                _UserStatsElement(value: '11.6 Hr', title: 'Working time'),
                _ElementDivider(),
                _UserStatsElement(value: '4', title: 'Level'),
              ],
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
          color: MyColors.text[700],
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
                .copyWith(color: MyColors.black, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: size.height.onePercent),
          Text(
            title!,
            style: Get.textTheme.bodyText2!.copyWith(color: MyColors.text[900]),
          ),
        ],
      ),
    );
  }
}

/*

GestureDetector(
  onTap: () {
    navBarController.selectedIndex = 1;
  },
  child: Card(
    shape: RoundedRectangleBorder(borderRadius: Utils.mediumRadius),
    margin: EdgeInsets.symmetric(
      horizontal: padding,
      vertical: padding,
    ),
    child: Container(
      height: size.height * 0.2,
      width: size.height * 0.2,
      alignment: Alignment.center,
      child: Text(
        'Projects',
        style: Get.textTheme.headline4,
      ),
    ),
  ),
),

*/
