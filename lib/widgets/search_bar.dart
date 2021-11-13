import 'package:get/get.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, this.title}) : super(key: key);

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
                const IconButton(
                  onPressed: null,
                  icon: Icon(MyIcons.menu, color: kWhiteColor),
                ),
                Text(
                  title ?? '',
                  style: Get.textTheme.headline6,
                ),
                const IconButton(
                  icon: Icon(MyIcons.search, color: kWhiteColor),
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
