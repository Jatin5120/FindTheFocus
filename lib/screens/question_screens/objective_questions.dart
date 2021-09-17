import 'package:find_the_focus/constants/colors.dart';
import 'package:find_the_focus/constants/constants.dart';
import 'package:find_the_focus/controllers/controllers.dart';
import 'package:find_the_focus/modals/modals.dart';
import 'package:find_the_focus/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObjectiveQuestions extends StatelessWidget {
  const ObjectiveQuestions({Key? key}) : super(key: key);

  static QuestionsController questionsController = Get.find();
  static PageController pageController = PageController();

  static Curve transitionCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: key,
      body: SafeArea(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: size.height, maxWidth: size.width),
          child: Stack(
            children: [
              const _Line(),
              const _TimeIcon(),
              PageView.builder(
                controller: pageController,
                pageSnapping: true,
                scrollDirection: Axis.vertical,
                itemCount: questionsController.questions.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final QuestionModal questionModal =
                      questionsController.questions[index];
                  return QuestionPage(
                    key: key,
                    number: index + 1,
                    questionModal: questionModal,
                    onOptionSelected: () {
                      pageController.nextPage(
                        duration: kAnimationDuration,
                        curve: transitionCurve,
                      );
                    },
                  );
                },
              ),
              _ArrowButtton(
                onTap: () {
                  pageController.previousPage(
                    duration: kAnimationDuration,
                    curve: transitionCurve,
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

class _ArrowButtton extends StatelessWidget {
  const _ArrowButtton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: size.height * 0.025,
      right: size.width * 0.05,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kBackgroundColor[100],
          ),
          child: const Icon(Icons.arrow_upward_rounded, color: kWhiteColor),
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
      child: const Icon(
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
      child: const VerticalDivider(
        color: kDividerColor,
        width: 16,
      ),
    );
  }
}
