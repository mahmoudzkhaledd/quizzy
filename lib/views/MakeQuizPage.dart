import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/QuizModel.dart';
import 'package:quizapp/Widgets/DrawerListTile.dart';
import 'package:quizapp/Widgets/LoginButton.dart';
import 'package:quizapp/Widgets/TextBox.dart';

import '../controllers/MakeQuizController.dart';
import '../general_methods/SizedBoxes.dart';
import '../general_methods/TextStyles.dart';
import '../Widgets/Screens/MakeQuizWidgets.dart';

class MakeQuizPage extends GetView<MakeQuizController> {
  MakeQuizPage({Key? key}) : super(key: key) {
    Get.put(MakeQuizController());
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.popPage,
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBoxes.heightSizedBox,
            const Text(
              "Let's Make a Quiz",
              style: TextStyles.titleStyle,
            ),
            SizedBoxes.heightSizedBox,
            SizedBoxes.heightSizedBox,
            InputTextBox(
              hintText: "Name",
              image: "assets/images/name.png",
              onChanged: (value) => controller.quiz.name = value,
            ),
            SizedBoxes.heightSizedBox,
            InputTextBox(
              hintText: "Title",
              image: "assets/images/386715.png",
              onChanged: (value) => controller.quiz.title = value,
            ),
            SizedBoxes.heightSizedBox,
            InputTextBox(
              hintText: "Subject",
              image: "assets/images/subject.png",
              onChanged: (value) => controller.quiz.subject = value,
            ),
            SizedBoxes.heightSizedBox,
            InputTextBox(
              hintText: "Instructions",
              image: "assets/images/8906100.png",
              onChanged: (value) => controller.quiz.instructions = value,
            ),
            SizedBoxes.heightSizedBox,
            GetBuilder<MakeQuizController>(
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListTile(
                    onTap: controller.goToQuestionsPage,
                    title: "Make Questions",
                    subTitle: "Tap to go to questions page",
                    trailing: "${controller.quiz.questionNumber}\nQuestions",
                    icon: Icons.question_answer_outlined,
                  ),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.all(0),
                    value: controller.quiz.limitedTime,
                    onChanged: controller.setLimitedTime,
                    title: const Text(
                      "Use Limited Time",
                      style: TextStyles.listTileTitleStyle,
                    ),
                    subtitle: const Text(
                      "Make a specific time for each question",
                      style: TextStyles.listTileSubTitleStyle,
                    ),
                    secondary: const Icon(Icons.timelapse_rounded),
                  ),
                  SizedBox(
                    child: controller.quiz.limitedTime
                        ? LimitedTimeQuestion(
                            onTap: controller.chooseTime,
                            time: controller.quiz.questionsTime,
                          )
                        : null,
                  ),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.all(0),
                    value: controller.quiz.canGoBack,
                    onChanged: controller.setCanGoBack,
                    title: const Text(
                      "Can Go Back",
                      style: TextStyles.listTileTitleStyle,
                    ),
                    subtitle: const Text(
                      "Student Can Go To The Previous Question",
                      style: TextStyles.listTileSubTitleStyle,
                    ),
                    secondary: const Icon(Icons.refresh_rounded),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text(
                      "Question Type",
                      style: TextStyles.listTileTitleStyle,
                    ),
                    subtitle: const Text(
                      "Set Question MCQ Or Fill-The-Blank",
                      style: TextStyles.listTileSubTitleStyle,
                    ),
                    trailing: DropdownButton<QuizType>(
                      value: controller.quiz.quizType,
                      onChanged: controller.onTypeSelected,
                      borderRadius: BorderRadius.circular(15),
                      items: const [
                        DropdownMenuItem<QuizType>(
                          value: QuizType.mcq,
                          child: Text("MCQ"),
                        ),
                        DropdownMenuItem<QuizType>(
                          value: QuizType.complete,
                          child: Text("Fill The Blank"),
                        ),
                      ],
                    ),
                  ),
                  SizedBoxes.heightSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoginButton(
                        onTap: controller.tryQuiz,
                        text: "Try Quiz",
                        icon: const Icon(Icons.quiz_outlined),
                      ),
                      LoginButton(
                        onTap: controller.publishQuiz,
                        text: "Publish Quiz",
                        icon: controller.isLoading
                            ? const SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.monetization_on_outlined),
                                  const SizedBox(width: 5,) ,
                                  Text(
                                    AppHelper.coinsToMakeExam.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                        backgroundColor: Colors.amber,
                        borderColor: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBoxes.heightSizedBox,
            SizedBoxes.heightSizedBox,
          ],
        ),
      ),
    );
  }
}
