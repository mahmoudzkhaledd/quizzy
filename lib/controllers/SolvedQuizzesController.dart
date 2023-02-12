import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/QuizzesWebServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/QuizShortModel.dart';
import '../models/QuizModel.dart';
import '../views/QuizInformation.dart';

class SolvedQuizzesController extends GetxController {
  List<QuizShortModel> quizzesList = [];
  late bool allQuizzes;
  int selectedIndex = -1;
  String? userId;
  Future<int> getQuizzes() async {
    quizzesList.clear();
    if(userId == null){
      if (allQuizzes) {
        quizzesList = await QuizzesWebServices.getAllQuizzes(0);
      } else {
        quizzesList = await QuizzesWebServices.getSolvedQuizzes();
      }
    }else{
      quizzesList = await QuizzesWebServices.getUserQuizzes(userId!);
    }
    return 0;
  }

  void onTapQuiz(String path) {
    Get.to(
      () => QuizInformation(
        tryQuiz: false,
        quizPath: path,
        userModel: null,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void init(bool allQuizzes,String? userId) {
    this.allQuizzes = allQuizzes;
    this.userId = userId;
  }

  void selectQuiz(int index) {
    if(index == selectedIndex){
      selectedIndex = -1;
    }else{
      selectedIndex = index;
    }
    update();
  }
  void onDeleteQuiz(String deletedPath) async {
    bool res = await AppHelper.showYesNoMessage("Warning", "Are You Sure To Delete The Quiz ?");
    if(res){
      await QuizzesWebServices.deleteQuiz(deletedPath);
      refreshList();
    }
  }
  void backWithQuiz() {
    Get.back<Map<String,String>>(result: {
      "Path": selectedIndex != -1 ? quizzesList[selectedIndex].path : "",
      "Name": selectedIndex != -1 ? quizzesList[selectedIndex].name : "",
    });
  }

  Future<void> refreshList() async {
    await getQuizzes();
    update();
  }
}
