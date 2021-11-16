import 'package:find_the_focus/screens/question_screens/question_screens.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import '../constants/constants.dart';
import '../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({Key? key}) : super(key: key);

  static final NavBarController _navBarController = Get.find();
  static final UserDataController _userDataController = Get.find();

  static const List<IconData> _icons = [
    MyIcons.dashboard,
    MyIcons.project,
    MyIcons.stats,
    MyIcons.user,
  ];

  static const List<String> _labels = [
    'Dashboard',
    'Projects',
    'Analytics',
    'Profile',
  ];

  static const List<Widget> _screens = [
    Dashboard(),
    ProjectScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _userDataController.isNewUser
          ? const QuestionsWrapper()
          : Scaffold(
              resizeToAvoidBottomInset: false,
              body: Obx(
                () => _screens[_navBarController.selectedIndex],
              ),
              floatingActionButton: Obx(() {
                return _navBarController.showFAB
                    ? FloatingActionButton(
                        backgroundColor: kPrimaryColor,
                        child: const Icon(MyIcons.plus),
                        onPressed: () => Get.to(() => const AddProject()),
                      )
                    : const SizedBox.shrink();
              }),
              bottomNavigationBar: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < _icons.length; i++) ...[
                      NavBarItem(
                        icon: _icons[i],
                        index: i,
                        label: _labels[i],
                      ),
                    ]
                  ],
                ),
              ),
            ),
    );
  }
}
