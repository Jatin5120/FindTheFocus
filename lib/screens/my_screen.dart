import 'package:flutter/material.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  static final List<Color> _colors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        child: Stack(
          children: [
            PageView(
              children: [
                for (int i = 0; i < 5; i++) ...[
                  Container(
                    height: size.width * 0.5,
                    width: size.width * 0.5,
                    color: _colors[i],
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
