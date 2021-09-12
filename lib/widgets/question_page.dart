import 'package:find_the_focus/constants/constants.dart';
import 'package:find_the_focus/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    Key? key,
    required this.number,
    required this.question,
    required this.answers,
    required this.onOptionSelected,
  }) : super(key: key);

  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<GlobalKey<ItemFaderState>> keys;
  final Duration delayDuration = const Duration(milliseconds: 40);

  @override
  void initState() {
    super.initState();
    keys = List.generate(5, (_) => GlobalKey<ItemFaderState>());
    onInit();
  }

  void onInit() async {
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(delayDuration);
      key.currentState!.show();
    }
  }

  void onTap() async {
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(delayDuration);
      key.currentState!.hide();
    }
    widget.onOptionSelected();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.075),
          ItemFader(key: keys[0], child: _Number(widget.number)),
          ItemFader(key: keys[1], child: _Question(widget.question)),
          const Spacer(),
          ...widget.answers.map((String answer) {
            final int answerIndex = widget.answers.indexOf(answer);
            final int keyIndex = answerIndex + 2;
            return ItemFader(
              key: keys[keyIndex],
              child: _Option(
                answer: answer,
                onOptionSelected: widget.onOptionSelected,
              ),
            );
          }),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    Key? key,
    required this.answer,
    required this.onOptionSelected,
  }) : super(key: key);

  final String answer;
  final VoidCallback onOptionSelected;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        // RenderBox object = context.findAncestorRenderObjectOfType<RenderBox>()!;
        // Offset globalPosition = object.localToGlobal(Offset.zero);
        // onOptionSelected(globalPosition);
        onOptionSelected();
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            size.width * 0.2, 0, size.width * 0.1, size.height * 0.05),
        child: Row(
          children: [
            const Dot(),
            SizedBox(width: size.width * 0.05),
            Expanded(
              child: Text(answer, style: Get.textTheme.headline6),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      decoration: const BoxDecoration(
        color: kWhiteColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Question extends StatelessWidget {
  const _Question(this.question, {Key? key}) : super(key: key);

  final String question;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.3,
        right: size.width * 0.05,
      ),
      alignment: Alignment.centerLeft,
      child: Text(question, style: Get.textTheme.headline5),
    );
  }
}

class _Number extends StatelessWidget {
  const _Number(this.number, {Key? key}) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: size.width * 0.3),
      alignment: Alignment.centerLeft,
      child: Text(
        number < 10 ? '0$number' : '$number',
        style: Get.textTheme.headline1!.copyWith(
          fontWeight: FontWeight.bold,
          color: kTextColor[700],
        ),
      ),
    );
  }
}
