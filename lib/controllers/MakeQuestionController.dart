import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/QuizModel.dart';

class MakeQuestionController extends GetxController {
  int index = 0;
  late Question currentQuestion;
  late QuizType quizType;
  late List<Question> questions;

  TextEditingController textController = TextEditingController();
  TextEditingController pointsController = TextEditingController();

  TextEditingController? completeController;

  void initPage(QuizType quizType, List<Question> questions) {
    this.quizType = quizType;

    if (quizType == QuizType.complete) {
      completeController = TextEditingController();
    }

    this.questions = questions;

    if (questions.isNotEmpty) {
      currentQuestion = questions.last;
      index = questions.length - 1;
    } else {
      currentQuestion = Question();
      questions.add(currentQuestion);
      index = 0;
    }

    textController.text = currentQuestion.text;

    pointsController.text = currentQuestion.points.toString();

    if (completeController != null) {
      completeController!.text = currentQuestion.answer.answer;
    }
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
    pointsController.dispose();
    if (completeController != null) {
      completeController!.dispose();
    }
  }

  int? validateAllQuestions() {
    for (int i = 0; i < questions.length; i++) {
      if (!validateQuestion(questions[i])) {
        return i;
      }
    }
    return null;
  }

  bool validateQuestion(Question question) {
    bool chk = question.validateQuestion(quizType);
    try {
      currentQuestion.points = double.parse(pointsController.text.toString());
    } catch (ex) {
      return false;
    }
    return chk;
  }

  Future<void> previousQuestion() async {
    bool discard = false;
    if (!validateQuestion(questions[index])) {
      discard = await _showAlertDialog(false, currentQuestion, index + 1);
      update(['Question_Number_Builder', 'Answers_Builder']);
    }
    if (index > 0 && !discard) {
      index--;
      currentQuestion = questions[index];

      updateControllers();

      update(['Question_Number_Builder', 'Answers_Builder']);
    }
  }

  void doneQuestions() {
    int? deleted = validateAllQuestions();
    if (deleted == null) {
      Get.back();
    } else {
      _showAlertDialog(true, questions[deleted], deleted + 1);
    }
  }

  void nextQuestion() {
    if (validateQuestion(questions[index])) {
      if (index == questions.length - 1) {
        currentQuestion = Question();
        questions.add(currentQuestion);
      } else {
        currentQuestion = questions[index + 1];
      }

      updateControllers();

      index++;
    } else {
      _showAlertDialog(false, null, index + 1);
    }
    update(['Question_Number_Builder', 'Answers_Builder']);
  }

  void onDeleteMcqAnswer(QuestionAnswerModel answerModel) {
    if (answerModel.index == currentQuestion.answer.index) {
      currentQuestion.answer.index = -1;
    }
    currentQuestion.choices.remove(answerModel);
    update(['Answers_Builder']);
  }

  void onAddAnswer() {
    currentQuestion.choices.add(QuestionAnswerModel(""));
    update(['Answers_Builder']);
  }

  void onCorrectMcqAnswerChanged(int? index) {
    currentQuestion.answer.index = index!;
    update(['Answers_Builder']);
  }

  Future<bool> _showAlertDialog(
      bool back, Question? removedQuestion, int deletedIndex) async {
    bool? ok = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Warning"),
        content:
            Text("Please Fill All Data Required in Question $deletedIndex"),
        actions: [
          FilledButton(
            onPressed: () {
              Get.back<bool>(result: true);
            },
            child: const Text("OK"),
          ),
          SizedBox(
            child: removedQuestion == null
                ? null
                : FilledButton(
                    onPressed: () {
                      questions.remove(removedQuestion);
                      Get.back<bool>(result: false);
                      if (back) {
                        Get.back();
                      } else {
                        update(['Question_Number_Builder', 'Answers_Builder']);
                      }
                    },
                    child: const Text("Discard"),
                  ),
          )
        ],
      ),
    );
    return ok ?? true;
  }

  Future<bool> popPage() async {
    int? deleted = validateAllQuestions();
    if (deleted == null) {
      return true;
    } else {
      await _showAlertDialog(true, questions[deleted], deleted + 1);
      return false;
    }
  }

  void deleteCurrentQuestion() {
    questions.remove(currentQuestion);
    if (index > 0) {
      index--;
      currentQuestion = questions[index];
      updateControllers();
      update(['Question_Number_Builder', 'Answers_Builder']);
    } else {
      Get.back();
    }
  }

  void updateControllers() {
    textController.text = currentQuestion.text;
    pointsController.text = currentQuestion.points.toString();
    if (completeController != null) {
      completeController!.text = currentQuestion.answer.answer;
    }
  }
}
