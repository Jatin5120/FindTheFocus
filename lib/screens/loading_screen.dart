import 'package:find_the_focus/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width.thirtyThreePercent,
          height: size.width.thirtyThreePercent,
          child: Image.asset(
            'assets/Logo/logo.png',
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: kAccentColor),
            const SizedBox(width: 24),
            Text(
              'Setting up',
              style: Get.textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
