import 'package:find_the_focus/modals/modals.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<QuestionModal> _questions = [
  QuestionModal(
    question:
        "Do you get distracted easily (e.g. by background noise, other people's conversations, etc.)?",
    answers: ['Yes', 'Sometimes', 'No'],
    weightages: [-1, 0, 1],
  ),
  QuestionModal(
    question: "How often are you late for work or an appointment?",
    answers: ['Often', 'Sometimes', 'Rarely'],
    weightages: [-1, 0, 1],
  ),
  QuestionModal(
    question: "How often do you catch yourself daydreaming at work?",
    answers: ['Often', 'Sometimes', 'Rarely'],
    weightages: [1, 2, 3],
  ),
  QuestionModal(
    question:
        "Do you jump from task to task because you just can't seem to focus long enough to finish one completely?",
    answers: ['Yes', 'Sometimes', 'No'],
    weightages: [0, 1, 2],
  ),
  QuestionModal(
    question: "How do you deal with boring, repetitive tasks?",
    answers: [
      "I'm fine with them; I have very little trouble getting them done.",
      "I don't mind them, but I may end up needing a break from time to time.",
      "I can't stand them - they bore me out of my skull.",
    ],
    weightages: [1, 0, -1],
  ),
  QuestionModal(
    question:
        "You're on the phone with a friend just as your favorite TV show starts. How difficult would it be for you to pay attention to the conversation?",
    answers: [
      "Very difficult",
      "Somewhat difficult",
      "Not at all difficult",
    ],
    weightages: [-1, 0, 1],
  ),
  QuestionModal(
    question:
        "When reading a book or magazine, how often do you find yourself re-reading the same paragraph or skipping ahead?",
    answers: ['Often', 'Sometimes', 'Rarely'],
    weightages: [1, 2, 3],
  ),
  QuestionModal(
    question:
        "Do you have a knack for noticing details (e.g. typos in a document)?",
    answers: ["Yes", "Sometimes", "No"],
    weightages: [1, 2, 3],
  ),
  QuestionModal(
    question: "Do you lose your patience easily?",
    answers: ["Yes", "Sometimes", "No"],
    weightages: [-1, 0, 1],
  ),
  QuestionModal(
    question: "How often do you interrupt people during conversations?",
    answers: ['Often', 'Sometimes', 'Rarely'],
    weightages: [3, 2, 1],
  ),
];

class QuestionsController extends GetxController {
  List<QuestionModal> questions = _questions;
  final RxBool _isFirstLogin = true.obs;
  late SharedPreferences prefs;
  static const _isFirstLoginKey = 'isFirstLogin';

  Future<bool> checkFirstLogin() async {
    prefs = await SharedPreferences.getInstance();
    isFirstLogin = prefs.getBool(_isFirstLoginKey) ?? false;
    return _isFirstLogin.value;
  }

  Future<void> setFirstLogin() async {
    prefs = await SharedPreferences.getInstance();
    isFirstLogin = false;
    prefs.setBool(_isFirstLoginKey, isFirstLogin);
  }

  bool get isFirstLogin => _isFirstLogin.value;

  set isFirstLogin(bool value) => _isFirstLogin.value = value;
}
