import 'package:find_the_focus/constants/constants.dart';
import 'package:find_the_focus/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/Logo/ftf_name.svg'),
            MyButton(
              label: 'Test',
              onPressed: () {},
              buttonSize: ButtonSize.large,
              isCTA: true,
            ),
            MyButton.secondary(
              label: 'Test',
              onPressed: () {},
              buttonSize: ButtonSize.large,
              isCTA: true,
            ),
            MyButton.outlined(
              label: 'Test',
              onPressed: () {},
              buttonSize: ButtonSize.large,
              isCTA: true,
            ),
            CircleAvatar(
              child: SvgPicture.asset('assets/Logo/google.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
