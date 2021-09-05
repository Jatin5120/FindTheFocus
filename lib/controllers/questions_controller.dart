import 'package:find_the_focus/modals/modals.dart';
import 'package:get/get.dart';

final List<QuestionModal> questions = [
  QuestionModal(
    question:
        "Do you get distracted easily (e.g. by background noise, other people's conversations, etc.)?",
    answers: ['Yes', 'Sometimes', 'No'],
    weightages: [1, 2, 3],
  ),
  QuestionModal(
    question: "How often are you late for work or an appointment?",
    answers: ['Quite often', 'Often', 'Sometimes', 'Rarely', 'Almost never'],
    weightages: [],
  ),
  QuestionModal(
    question: "How often do you catch yourself daydreaming at work?",
    answers: ['Quite often', 'Often', 'Sometimes', 'Rarely', 'Almost never'],
    weightages: [5, 4, 3, 2, 1],
  ),
  QuestionModal(
    question:
        "Do you jump from task to task because you just can't seem to focus long enough to finish one completely?",
    answers: ['Yes', 'Sometimes', 'No'],
    weightages: [5, 3, 1],
  ),
  QuestionModal(
    question: "How do you deal with boring, repetitive tasks?",
    answers: [
      "I'm fine with them; I have very little trouble getting them done.",
      "I don't mind them, but I may end up needing a break from time to time.",
      "I can't stand them - they bore me out of my skull.",
    ],
    weightages: [],
  ),
  QuestionModal(
    question:
        "You're on the phone with a friend just as your favorite TV show starts. How difficult would it be for you to pay attention to the conversation?",
    answers: [
      "Extremely difficult",
      "Very difficult",
      "Somewhat difficult",
      "Slightly difficult",
      "Not at all difficult",
    ],
    weightages: [5, 4, 3, 2, 1],
  ),
  QuestionModal(
    question:
        "When reading a book or magazine, how often do you find yourself re-reading the same paragraph or skipping ahead?",
    answers: ['Quite often', 'Often', 'Sometimes', 'Rarely', 'Almost never'],
    weightages: [5, 4, 3, 2, 1],
  ),
  QuestionModal(
    question:
        "Do you have a knack for noticing details (e.g. typos in a document)?",
    answers: ["Yes", "No"],
    weightages: [3, 1],
  ),
  QuestionModal(
    question: "Do you lose your patience easily?",
    answers: ["Yes", "Sometimes", "No"],
    weightages: [3, 2, 1],
  ),
  QuestionModal(
    question: "How often do you interrupt people during conversations?",
    answers: ['Quite often', 'Often', 'Sometimes', 'Rarely', 'Almost never'],
    weightages: [5, 4, 3, 2, 1],
  ),
];

class QuestionsController extends GetxController {}
