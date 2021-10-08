import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_focus/screens/question_screens/question_screens.dart';
import 'package:find_the_focus/services/services.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import '../constants/constants.dart';
import '../controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({Key? key}) : super(key: key);

  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  final NavBarController navBarController = Get.find();
  final ProjectsClient projectsClient = Get.find();
  final UserDataController userDataController = Get.find();

  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  final List<IconData> _icons = [
    MyIcons.dashboard,
    MyIcons.project,
    MyIcons.stats,
    MyIcons.user,
  ];

  final List<String> _labels = [
    'Dashboard',
    'Projects',
    'Analytics',
    'Profile',
  ];

  final List<Widget> _screens = [
    const Dashboard(),
    ProjectScreen(),
    const AnalyticsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseService.getData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return userDataController.isNewUser
        ? const QuestionsWrapper()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Obx(
              () {
                final bool isDashboard = navBarController.selectedIndex == 0;
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDashboard ? 0 : size.width * 0.05,
                  ),
                  child: _screens[navBarController.selectedIndex],
                );
              },
            ),
            floatingActionButton: Obx(() {
              return navBarController.showFAB
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
          );
  }
}
