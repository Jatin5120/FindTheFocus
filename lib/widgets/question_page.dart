// ignore_for_file: avoid_print

import 'package:find_the_focus/constants/constants.dart';
import 'package:find_the_focus/controllers/controllers.dart';
import 'package:find_the_focus/modals/modals.dart';
import 'package:find_the_focus/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    Key? key,
    required this.number,
    required this.questionModal,
    required this.onOptionSelected,
  }) : super(key: key);

  final int number;
  final QuestionModal questionModal;
  final VoidCallback onOptionSelected;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with SingleTickerProviderStateMixin {
  late List<GlobalKey<ItemFaderState>> keys;
  final Duration delayDuration = const Duration(milliseconds: 50);

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
          ItemFader(
              key: keys[1], child: _Question(widget.questionModal.question)),
          const Spacer(),
          ...widget.questionModal.answers.map((String answer) {
            final int answerIndex =
                widget.questionModal.answers.indexOf(answer);
            final int weightage = widget.questionModal.weightages[answerIndex];
            final int keyIndex = answerIndex + 2;
            return ItemFader(
              key: keys[keyIndex],
              child: _Option(
                answer: answer,
                weightage: weightage,
                // onOptionSelected: onTap,
                onOptionSelected: onTap,
              ),
            );
          }),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}

class _Option extends StatefulWidget {
  const _Option({
    Key? key,
    required this.answer,
    required this.weightage,
    required this.onOptionSelected,
  }) : super(key: key);

  final String answer;
  final int weightage;
  final VoidCallback onOptionSelected;

  @override
  State<_Option> createState() => _OptionState();
}

class _OptionState extends State<_Option> with SingleTickerProviderStateMixin {
  late AnimationController _dotAnimationController;

  final UserDataController _userDataController = Get.find();

  @override
  void initState() {
    super.initState();
    _dotAnimationController = AnimationController(
      vsync: this,
      duration: kAnimationDuration,
    );
  }

  Future<void> animateDot(Offset startingOffset) async {
    widget.onOptionSelected();
    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        double minTop = MediaQuery.of(context).padding.top +
            MediaQuery.of(context).size.height * 0.1;
        return AnimatedBuilder(
          animation: _dotAnimationController,
          child: const Dot(color: kWhiteColor),
          builder: (BuildContext context, Widget? child) {
            final Size size = MediaQuery.of(context).size;
            return Positioned(
              left: size.width * 0.2,
              top: minTop +
                  (startingOffset.dy - minTop) *
                      (1 - _dotAnimationController.value),
              child: child!,
            );
          },
        );
      },
    );
    Overlay.of(context)!.insert(entry);
    await _dotAnimationController.forward(from: 0);
    entry.remove();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        RenderBox box = context.findRenderObject() as RenderBox;
        Offset offset = box.localToGlobal(Offset.zero);
        animateDot(offset);
        print("${widget.weightage} added");
        _userDataController.workTime += widget.weightage;
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.2,
          0,
          size.width * 0.1,
          size.height * 0.075,
        ),
        child: Row(
          children: [
            const Dot(),
            SizedBox(width: size.width * 0.05),
            Expanded(
              child: Text(widget.answer, style: Get.textTheme.headline6),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key, this.color = kDisabledColor}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(
        color: color,
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
