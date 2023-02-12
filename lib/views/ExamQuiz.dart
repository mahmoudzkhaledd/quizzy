import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/LiveQuizHeader.dart';
import '../controllers/QuizExamController.dart';
import '../general_methods/SizedBoxes.dart';
import '../general_methods/TextStyles.dart';
import '../models/QuizModel.dart';
import '../models/RoomModel.dart';
import '../Widgets/Screens/ExamQuizWidgets.dart';

class QuizExam extends GetView<QuizExamController> {
  final Quiz quiz;
  final bool tryQuiz;

  QuizExam({
    Key? key,
    required this.quiz,
    required this.tryQuiz,
    RoomModel? room,
  }) : super(key: key) {
    Get.put(QuizExamController());
    controller.init(quiz, tryQuiz,room);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.popPage,
      child: GetBuilder<QuizExamController>(
        id: "HigherBuilder",
        builder: (_) => Scaffold(
          appBar: AppBar(
            backgroundColor: controller.backgroundColor,
            foregroundColor: controller.textColor,
            actions: [
              IconButton(
                onPressed: controller.changeTheme,
                icon: Icon(
                  controller.textColor == Colors.white
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: controller.textColor,
                ),
              )
            ],
            centerTitle: true,
            title: controller.quiz.limitedTime
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(
                        color: controller.textColor,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/clock (1).png",
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        GetBuilder<QuizExamController>(
                          id: "TimerBuilder",
                          builder: (_) => Text(
                            "${controller.fullDuration} Seconds",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: controller.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          backgroundColor: controller.backgroundColor,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: !controller.examEnd
                  ? [
                      quiz.canGoBack
                          ? FloatingActionButton.extended(
                              heroTag: 'floatPrev',
                              onPressed: controller.previousQuestion,
                              icon: const Icon(Icons.arrow_back_rounded),
                              label: const Text("Back"),
                            )
                          : const SizedBox(),
                      FloatingActionButton.extended(
                        heroTag: 'floatNext',
                        onPressed: controller.nextQuestion,
                        icon: const Text("Next"),
                        label: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ]
                  : [
                      const SizedBox(),
                      FloatingActionButton.extended(
                        heroTag: 'floatNext',
                        onPressed: ()async {
                          if(await controller.popPage()){
                            Get.back();
                          }
                        },
                        icon: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        label: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: !controller.examEnd
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.room != null ? LiveQuizHeader(
                          player1: controller.room!.player1,
                          player2: controller.room!.player2,
                          questionsNumber: quiz.questionNumber,
                          stream: controller.room!.snapShot!,
                          onRoomDeleted: controller.onRoomDeleted,
                          host: controller.room!.host,
                        ) : const SizedBox.shrink(),
                        SizedBoxes.heightSizedBox,
                        Text(
                          "Question ${controller.index + 1}",
                          style: TextStyles.titleStyle
                              .copyWith(color: controller.textColor),
                        ),
                        SizedBoxes.heightSizedBox,
                        ExamQuestionHeader(
                          questionText: controller.currentQuestion.text,
                          backColor: controller.containerColor,
                          textColor: controller.textColor,
                        ),
                        SizedBoxes.heightSizedBox,
                        ExamQuestionBody(
                          quizType: controller.quiz.quizType,
                          textColor: controller.textColor,
                          solvedAnswer: controller.currentQuestion.solvedAnswer,
                          completeController: controller.completeController,
                          choices: controller.currentQuestion.choices,
                          onCompleteAnswerChanged:(value)=>controller.currentQuestion.solvedAnswer.answer = value,
                          onSelectAnswer: controller.onSelectAnswer,
                        ),
                        const SizedBox(height: 150),
                      ],
                    )
                  : EndExamBody(
                      maximumPoints: controller.quiz.maximumPoints,
                      result: controller.result,
                      textColor: controller.textColor,
                      earn: controller.earned,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
