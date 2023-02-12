import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/QuizzesWebServices.dart';
import 'package:quizapp/models/QuizModel.dart';
import 'package:quizapp/models/RoomModel.dart';

class LiveQuizPageController extends GetxController {
  Quiz quiz;


  int currentSecond = 0;

  late Question currentQuestion;

  late RoomModel room;

  int index = 0;

  bool examEnd = false;

  bool lightTheme = true;

  int fullDuration = 0;

  TextEditingController? completeController;

  Timer? timer;

  double result = 0;

  LiveQuizPageController(this.quiz, this.room) {
    init();
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



  void init() {
    if (quiz.quizType == QuizType.complete) {
      completeController = TextEditingController();
    } else {
      if (completeController != null) {
        completeController!.dispose();
      }
    }
    index = 0;

    currentQuestion = quiz.questions[index];

    fullDuration = Duration(seconds: quiz.questionsTime.second,minutes:quiz.questionsTime.minute,hours: quiz.questionsTime.hour).inSeconds;


    if (quiz.limitedTime) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (time) {
          if (currentSecond < fullDuration) {
            currentSecond++;
          } else {
            nextQuestion();
            currentSecond = 0;
          }
          update();
        },
      );
    }


  }



  void onSelectMcqAnswer(int? value) {
    currentQuestion.solvedAnswer.index = value ?? -1;
    update();
  }



  void onCompleteAnswerChanged(String value) {
    if (currentQuestion.solvedAnswer == null) {
      currentQuestion.solvedAnswer = QuestionAnswerModel(value);
    } else {
      currentQuestion.solvedAnswer!.answer = value;
    }
  }



  void previousQuestion() async {

    if (!examEnd) {
      if (index > 0) {
        index--;
        await QuizzesWebServices.setPlayerCurrentIndex(
          room.host ? 1 : 2 ,
          index + 1,
          room.roomPath,
        );
        currentQuestion = quiz.questions[index];
        updateController();
        update();
      }
    }
  }


  void nextQuestion() async {
    if (!examEnd) {
      if (index + 1 < quiz.questions.length) {
        index++;
        await QuizzesWebServices.setPlayerCurrentIndex(
          room.host ? 1 : 2 ,
          index + 1,
          room.roomPath,
        );
        currentQuestion = quiz.questions[index];
      } else {
        await QuizzesWebServices.setPlayerCurrentIndex(
          room.host ? 1 : 2 ,
          index + 2,
          room.roomPath,
        );
        finishQuiz();
      }
      currentSecond = 0;

      updateController();

      update();
    }
  }


  void updateController() {
    if (completeController != null) {
      if (currentQuestion.solvedAnswer != null) {
        completeController!.text = currentQuestion.solvedAnswer!.answer;
      } else {
        completeController!.text = "";
      }
    }
  }



  void finishQuiz() async {
    validateQuestions();
    examEnd = true;
    if (timer != null) {
      timer?.cancel();
    }
  }


  Stream<DocumentSnapshot<Map<String, dynamic>>> getRoomStream() => QuizzesWebServices.getRoomStream(room.roomPath);


  void validateQuestions() {
    if (currentQuestion.solvedAnswer != null &&
        currentQuestion.solvedAnswer!.answer == currentQuestion.answer!.answer) {
      result += currentQuestion.points;
    }
  }




}
