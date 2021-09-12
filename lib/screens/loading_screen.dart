import 'package:find_the_focus/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size.width.fiftyPercent,
            width: size.width.fiftyPercent,
            child: const CircularProgressIndicator(color: kAccentColor),
          ),
          Text(
            message,
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
