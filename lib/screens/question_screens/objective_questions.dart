import 'package:find_the_focus/constants/colors.dart';
import 'package:find_the_focus/controllers/controllers.dart';
import 'package:find_the_focus/modals/modals.dart';
import 'package:find_the_focus/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObjectiveQuestions extends StatelessWidget {
  const ObjectiveQuestions({Key? key}) : super(key: key);

  static QuestionsController questionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: size.height, maxWidth: size.width),
          child: Stack(
            children: [
              _Line(),
              _TimeIcon(),
              PageView.builder(
                pageSnapping: true,
                scrollDirection: Axis.vertical,
                itemCount: questionsController.questions.length,
                itemBuilder: (_, index) {
                  final QuestionModal questionModal =
                      questionsController.questions[index];
                  return QuestionPage(
                    number: index + 1,
                    question: questionModal.question,
                    answers: questionModal.answers,
                    onOptionSelected: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeIcon extends StatelessWidget {
  const _TimeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      left: size.width * 0.16,
      top: size.height * 0.1,
      child: Icon(
        Icons.hourglass_full_rounded,
        size: 48,
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      bottom: 0,
      left: size.width * 0.2,
      child: VerticalDivider(
        color: kDividerColor,
        width: 16,
      ),
    );
  }
}
