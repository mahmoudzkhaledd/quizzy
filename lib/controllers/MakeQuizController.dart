import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Services/QuizzesWebServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';

import 'package:quizapp/models/QuizModel.dart';

import 'package:quizapp/views/MakeQuestionsPage.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../views/QuizInformation.dart';

class MakeQuizController extends GetxController {
  final Quiz quiz = Quiz();

  bool isLoading = false;

  void init() {
    quiz.questionsTime = DateTime(2022);
    quiz.quizType = QuizType.mcq;
  }

  Future<void> _showAlertDialog() async {
    await Get.dialog(AlertDialog(
      title: const Text("Warning"),
      content: const Text("Please Fill All Data Required in This Quiz"),
      actions: [
        FilledButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("OK"),
        ),
      ],
    ));
  }

  void tryQuiz() async {
    if (quiz.validateQuiz()) {
      Get.to(
        () => QuizInformation(
          quiz: quiz,
          tryQuiz: true,
          quizPath: "",
          userModel: AppHelper.user,
        ),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );
    } else {
      await _showAlertDialog();
    }
  }

  void publishQuiz() async {
    await AppHelper.user!.reload();
    if(AppHelper.user!.coins < AppHelper.coinsToMakeExam){
      await AppHelper.showPopMessage("Error", "You Don't Have Enough Coins To Make Exam");
      return ;
    }
    bool res = await AppHelper.showYesNoMessage("Warning", "20 coins will be deducted from your total coins, continue ?");
    if(!res) return;

    if (quiz.validateQuiz() && FirebaseAuth.instance.currentUser != null) {
      isLoading = true;
      update();
      bool published = await QuizzesWebServices.publishQuiz(quiz);
      isLoading = false;
      update();

      if (published) {
        Get.back();
      } else {
        await AppHelper.showPopMessage("Failed", "There is a problem in Publishing the quiz");
      }
    } else {
      await _showAlertDialog();
    }
  }

  void setCanGoBack(bool value) {
    quiz.canGoBack = value;
    if(value){
      quiz.limitedTime = false;
    }

    update();
  }

  void chooseTime() async {
    await Get.dialog(AlertDialog(
      title: const Text("Pick Time"),
      content: TimePickerSpinner(
        time: DateTime(2022, 1, 1, 0, 0, 20),
        isShowSeconds: true,
        onTimeChange: (DateTime? date) {
          if (date != null) {
            quiz.questionsTime = date;
          }
        },
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Done"),
        )
      ],
    ));
    update();
  }

  void setLimitedTime(bool value) {
    quiz.limitedTime = value;
    if(value){
      quiz.canGoBack = false;
    }
    update();
  }

  void goToQuestionsPage() async{
    await Get.to(
      () => MakeQuestionPage(
        quizType: quiz.quizType,
        questions: quiz.questions,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
    update();
  }

  void onTypeSelected(QuizType? value) {
    if (value != quiz.quizType) {
      quiz.questions.clear();
    }
    if (value != null) {
      quiz.quizType = value;
    }
    update();
  }


  Future<bool> popPage() async {
    bool done = await AppHelper.showYesNoMessage("Warning", "The Data Will Be Deleted, Tap Yes To Continue");
    return done;
  }
}
