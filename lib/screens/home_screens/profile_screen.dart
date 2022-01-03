import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/controllers.dart';
import '../../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static AuthenticationController authenticationController = Get.find();
  static UserDataController _userDataController = Get.find();
  static NavBarController navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final User? user = _userDataController.user;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 32),
              child: Text('Profile', style: Get.textTheme.headline5),
            ),
            InteractiveViewer(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user?.photoURL ?? ''),
                radius: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user?.displayName ?? 'User',
              style: Get.textTheme.headline5,
            ),
            const SizedBox(height: 8),
            Text(user?.email ?? ''),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  await authenticationController.signOut();
                  navBarController.selectedIndex = 0;
                },
                label: Text('Sign Out', style: Get.textTheme.bodyText1),
                icon: const Icon(Icons.logout_outlined),
                backgroundColor: kAccentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
