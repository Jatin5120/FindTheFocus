import '../controllers/controllers.dart';
import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final AuthenticationController authenticationController = Get.find();
  final NavBarController navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final GoogleSignInAccount? user = authenticationController.googleAccount;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Profile'),
          InteractiveViewer(
            child: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoUrl ?? ''),
              radius: 50,
            ),
          ),
          Text(
            user?.displayName ?? 'User',
            style: Get.textTheme.headline5,
          ),
          Text(
            user?.id ?? 'User',
            style: Get.textTheme.headline5,
          ),
          Text(user?.email ?? ''),
          SizedBox(height: size.height.tenPercent),
          FloatingActionButton.extended(
            onPressed: () async {
              await authenticationController.signOut();
              navBarController.selectedIndex = 0;
            },
            label: Text('Sign Out'),
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
    );
  }
}
