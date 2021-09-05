import 'package:get/get.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
      child: Material(
        elevation: 10,
        color: kBackgroundColor[100],
        borderRadius: kLargeRadius,
        child: ClipRRect(
          borderRadius: kLargeRadius,
          child: Container(
            height: size.height * 0.06,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            color: kBackgroundColor[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(MyIcons.menu),
                ),
                Text(
                  title ?? '',
                  style: Get.textTheme.bodyText1,
                ),
                IconButton(
                  icon: Icon(MyIcons.search),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
