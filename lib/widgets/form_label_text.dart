import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormLabelText extends StatelessWidget {
  const FormLabelText({Key? key, required this.label}) : super(key: key);

  final String? label;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    final double padding = size.width * 0.03;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding / 2,
      ).copyWith(top: padding * 2),
      child: Text(label!, style: Get.textTheme.subtitle1!),
    );
  }
}
