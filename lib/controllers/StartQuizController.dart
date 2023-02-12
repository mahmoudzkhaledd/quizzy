import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/QuizzesWebServices.dart';
import 'package:quizapp/Services/UserServices.dart';
import 'package:quizapp/models/QuizModel.dart';
import 'package:quizapp/models/UserModel.dart';
import 'package:quizapp/views/ViewProfile.dart';
import '../views/ExamQuiz.dart';

class StartQuizController extends GetxController {
  late Quiz quiz;
  late bool tryQuiz;
  late UserModel userModel;

  Future<int> getQuiz(Quiz? givenQuiz, bool tryQuiz, String quizPath, UserModel? user) async {
    this.tryQuiz = tryQuiz;
    if (givenQuiz == null) {
      quiz = await QuizzesWebServices.getQuiz(quizPath);
      quiz.path = quizPath;
    } else {
      quiz = givenQuiz;
    }

    if (user == null) {
      String userId = quiz.path.split('/')[2];
      userModel = await UserWebServices.getUserData(userId);
    } else {
      userModel = user;
    }

    return 1;
  }

  void startTheQuiz() {
    Get.off(() => QuizExam(quiz: quiz, tryQuiz: tryQuiz));
  }

  void goBack() {
    Get.back();
  }

  void goToUserProfile() {
    Get.to(
      () => ViewProfile(id: userModel.sId),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }
}
