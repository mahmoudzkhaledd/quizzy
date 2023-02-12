import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/QuizzesWebServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/QuizModel.dart';
import 'package:quizapp/models/RoomModel.dart';

class QuizExamController extends GetxController {
  late Quiz quiz;
  late Question currentQuestion;
  int index = 0;
  Timer? timer;
  int fullDuration = 0;
  bool tryQuiz = false;
  double result = 0.0;
  RoomModel? room;
  bool examEnd = false;
  TextEditingController? completeController;

  Color textColor = Colors.black;
  Color containerColor = AppHelper.mainColor;
  Color backgroundColor = Colors.white;
  bool earned = false;
  void resetFullDuration() {
    fullDuration = Duration(
      seconds: quiz.questionsTime.second,
      minutes: quiz.questionsTime.minute,
      hours: quiz.questionsTime.hour,
    ).inSeconds;
  }

  void init(Quiz quiz, bool tryQuiz, RoomModel? room) {
    this.tryQuiz = tryQuiz;
    this.room = room;
    if (quiz.quizType == QuizType.complete) {
      completeController = TextEditingController();
    } else {
      if (completeController != null) {
        completeController!.dispose();
      }
    }
    index = 0;
    this.quiz = quiz;
    currentQuestion = quiz.questions[index];
    resetFullDuration();
    if (quiz.limitedTime) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (time) {
          if (fullDuration != 0) {
            fullDuration--;
          } else {
            nextQuestion();
          }
          update(['TimerBuilder']);
        },
      );
    }
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    if (completeController != null) {
      completeController!.dispose();
    }
    super.onClose();
  }

  void changeTheme() {
    if (textColor == Colors.black) {
      textColor = Colors.white;
      containerColor = AppHelper.hexColor("#262626");
      backgroundColor = AppHelper.hexColor("#303030");
    } else {
      textColor = Colors.black;
      containerColor = AppHelper.mainColor;
      backgroundColor = Colors.white;
    }
    update(['HigherBuilder']);
  }

  void onSelectAnswer(int? value) {
    currentQuestion.solvedAnswer.index = value ?? -1;
    update(['HigherBuilder']);
  }

  Future<void> updatePlayer(bool finish) async {
    if (room != null) {
      await QuizzesWebServices.setPlayerCurrentIndex(
        room!.host ? 1 : 2,
        finish ? index + 2 : index + 1,
        room!.roomPath,
      );
    }
  }

  void previousQuestion() async {
    if (!examEnd) {
      if (index > 0) {
        index--;
        currentQuestion = quiz.questions[index];
        updateController();
        resetFullDuration();
        await updatePlayer(false);
        update(['HigherBuilder']);
      }
    }
  }

  void nextQuestion() async {
    if (!examEnd) {
      if (index + 1 < quiz.questions.length) {
        index++;
        currentQuestion = quiz.questions[index];
        await updatePlayer(false);
      } else {
        finishQuiz();
      }
      resetFullDuration();

      updateController();
      update(['HigherBuilder']);
    }
  }

  Future<bool> popPage() async {
    if(!examEnd){
      bool res = true;
      if(room != null && !examEnd){
        res = await AppHelper.showYesNoMessage(
          "Warning",
          room!.host ? "Are You Sure That You Want To Close The Room ?":"Are You Sure That You Want To Leave?",
        );
      }else if(room == null && !examEnd){
        res = await AppHelper.showYesNoMessage(
          "Warning",
          "Are You Sure That You Want To Leave?",
        );
      }
      if (res) {
        for (Question q in quiz.questions) {
          q.solvedAnswer.index = -1;
          q.solvedAnswer.answer = "";
        }
        examEnd = false;
        result = 0.0;
        resetFullDuration();
        if (room != null) {
          if (room!.host) {
            await QuizzesWebServices.deleteRoom(room!.roomPath);
            if(!examEnd) AppHelper.showToastMessage("The Room Has Been Canceled");
          } else {
            await QuizzesWebServices.exitPlayer(room!);
          }
        }
      }
      return res;
    }
    return true;
  }

  void updateController() {
    if (completeController != null) {
      completeController!.text = currentQuestion.solvedAnswer.answer;
    }
  }

  void finishQuiz() async {
    validateAllQuestions();
    examEnd = true;
    if (timer != null) {
      timer?.cancel();
    }
    if (!tryQuiz && quiz.path != "") {
      earned =  await QuizzesWebServices.finishQuiz(quiz.path, result);
    }
    await updatePlayer(true);
    update(['HigherBuilder']);
  }

  void validateAllQuestions() => result = quiz.correctQuiz();

  void onRoomDeleted() {
    Get.back();
    AppHelper.showToastMessage("Host Has Deleted The Room");
  }
}
