import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizapp/models/QuizModel.dart';
import 'package:quizapp/Widgets/DrawerListTile.dart';
import 'package:quizapp/Widgets/QuestionModelWidget.dart';
import '../controllers/MakeQuestionController.dart';
import '../general_methods/SizedBoxes.dart';
import '../general_methods/TextStyles.dart';

class MakeQuestionPage extends GetView<MakeQuestionController> {
  MakeQuestionPage({
    Key? key,
    required QuizType quizType,
    required List<Question> questions,
  }) : super(key: key) {
    Get.put(MakeQuestionController());
    controller.initPage(quizType, questions);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.popPage,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Make Questions",
            style: TextStyles.appBarStyle,
          ),
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                heroTag: 'floatPrev',
                onPressed: controller.previousQuestion,
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text("Back"),

              ),
              FloatingActionButton.extended(
                heroTag: 'floatDone',
                backgroundColor: Colors.yellow,
                onPressed: controller.doneQuestions,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Done"),
                foregroundColor: Colors.black,
              ),
              FloatingActionButton.extended(
                heroTag: 'floatNext',
                onPressed: controller.nextQuestion,
                icon: const Text("Next"),
                label: const Icon(Icons.arrow_forward_rounded),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            const SizedBox(height: 40),
            GetBuilder<MakeQuestionController>(
              id: "Question_Number_Builder",
              builder: (_) => Text(
                "Question ${controller.index + 1}",
                style: TextStyles.titleStyle,
              ),
            ),
            SizedBoxes.heightSizedBox,
            TextField(
              controller: controller.textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (value) => controller.currentQuestion.text = value,
              decoration: InputDecoration(
                filled: true,
                hintText: "Text",
                labelText: "Text",
                prefixIcon: Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/name.png",
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBoxes.heightSizedBox,
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.pointsController,
              textAlign: TextAlign.center,
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                filled: true,
                hintText: "Points",
                labelText: "Points",
                prefixIcon: const Icon(Icons.numbers),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBoxes.heightSizedBox,
            controller.quizType == QuizType.mcq
                ? GetBuilder<MakeQuestionController>(
                    id: "Answers_Builder",
                    builder: (_) => McqAnswerModelWidget(
                      onCorrectAnswerChanged: controller.onCorrectMcqAnswerChanged,
                      groupValue: controller.currentQuestion.answer.index,
                      answers: controller.currentQuestion.choices,
                      onDeleteAnswer: controller.onDeleteMcqAnswer,
                    ),
                  )
                : TextField(
                    onChanged: (value)=>controller.currentQuestion.answer.answer = value,
                    controller: controller.completeController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Correct Answer",
                      prefixIcon: const Icon(Icons.question_answer_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
            controller.quizType == QuizType.mcq
                ? CustomListTile(
                    onTap: controller.onAddAnswer,
                    title: "Add Answer",
                    subTitle: "Add Another Answer To The Current Question",
                    icon: Icons.add_circle_outline,
                  )
                : SizedBoxes.widthSizedBox,
            SizedBoxes.heightSizedBox,
            FilledButton.icon(
              onPressed: controller.deleteCurrentQuestion,
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text("Delete Question"),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}

