import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/models/UserModel.dart';
import 'package:quizapp/Widgets/ImageLoader.dart';

import '../controllers/StartQuizController.dart';
import '../general_methods/SizedBoxes.dart';
import '../general_methods/TextStyles.dart';
import '../models/QuizModel.dart';
import '../Widgets/LoginButton.dart';

class QuizInformation extends GetView<StartQuizController> {
  bool tryQuiz = false;
  Quiz? quiz;
  String quizPath;
  UserModel? userModel;

  QuizInformation({
    Key? key,
    this.quiz,
    required this.tryQuiz,
    required this.quizPath,
    required this.userModel,
  }) : super(key: key) {
    Get.put(StartQuizController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: FutureBuilder<void>(
        future: controller.getQuiz(quiz, tryQuiz, quizPath, userModel),
        builder: (ctx, snap) {
          if (snap.hasData) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Text(
                  controller.quiz.title,
                  style: TextStyles.titleStyle,
                ),
                Image.asset("assets/images/Thesis-amico.png"),
                Row(
                  children: [
                    GestureDetector(
                      onTap: controller.goToUserProfile,
                      child: ImageLoader(
                        imageUrl: controller.userModel.imageUrl,
                        borderRadius: 200,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        controller.userModel.username,
                        style: TextStyles.listTileTitleStyle,
                      ),
                    ),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                const Text(
                  "Quiz Information",
                  style: TextStyles.listTileTitleStyle,
                ),
                SizedBoxes.heightSizedBox,
                Row(
                  children: [
                    const Icon(Icons.timer_sharp),
                    Text(
                      controller.quiz.limitedTime
                          ? "   Time: ${controller.quiz.questionsTime.hour} hours, ${controller.quiz.questionsTime.minute} minutes\n   ${controller.quiz.questionsTime.second} Seconds for each question."
                          : "   No Limited Time For Each Question.",
                    ),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                Row(
                  children: [
                    const Icon(Icons.refresh_outlined),
                    Text(controller.quiz.canGoBack
                        ? "   You Can Go Back To\n   The Previous Question."
                        : "   You Can not Go Back To\n   The Previous Question."),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                Row(
                  children: [
                    const Icon(Icons.question_answer),
                    Text("   Solved ${controller.quiz.solvedNumber} times"),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                Row(
                  children: [
                    const Icon(Icons.subject),
                    Text("   Subject: ${controller.quiz.subject}."),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                Row(
                  children: [
                    const Icon(Icons.score_outlined),
                    Text(
                        "   Maximum Points: ${controller.quiz.maximumPoints.toStringAsFixed(2)}."),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                Row(
                  children: [
                    const Icon(Icons.numbers),
                    Text(
                        "   Number Of Questions: ${controller.quiz.questionNumber}."),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                Row(
                  children: [
                    const Icon(Icons.question_answer_outlined),
                    Text(
                        "   Quiz Type: ${controller.quiz.quizType == QuizType.mcq ? "Multiple Choice" : "Fill The Blank"}."),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                Center(
                    child: Text(controller.quiz.instructions,
                        textAlign: TextAlign.center)),
                SizedBoxes.heightSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoginButton(
                      onTap: controller.goBack,
                      text: "Close",
                      icon: const Icon(Icons.close),
                    ),
                    LoginButton(
                      onTap: controller.startTheQuiz,
                      text: "Start The Quiz",
                      icon: const Icon(Icons.check_circle_outline),
                      backgroundColor: Colors.amber,
                      borderColor: Colors.transparent,
                    ),
                  ],
                ),
                SizedBoxes.heightSizedBox,
                SizedBoxes.heightSizedBox,
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
