import 'package:get/get.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key, this.message}) : super(key: key);
  final String? message;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: kBackgroundColor[300],
      elevation: kElevation,
      shape: const RoundedRectangleBorder(borderRadius: kLargeRadius),
      child: SizedBox(
        height: size.height.tenPercent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              SizedBox(width: size.width.fivePercent),
              Text(message!, style: Get.textTheme.headline6),
            ],
          ],
        ),
      ),
    );
  }
}
