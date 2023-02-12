import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/Widgets/NoResultFoundWidget.dart';
import 'package:quizapp/Widgets/QuizWidget.dart';

import '../controllers/SolvedQuizzesController.dart';
import '../general_methods/TextStyles.dart';

class GetQuizzesPage extends GetView<SolvedQuizzesController> {
  bool allQuizzes;
  bool hasGrade;
  bool returnQuiz;

  GetQuizzesPage({
    Key? key,
    required this.allQuizzes,
    required this.hasGrade,
    required this.returnQuiz,
    String? userId,
  }) : super(key: key) {
    Get.put(SolvedQuizzesController());

    controller.init(allQuizzes, userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.userId != null
              ? "Your Quizzes"
              : allQuizzes
                  ? "All Quizzes"
                  : "Solved Quizzes",
          style: TextStyles.appBarStyle,
        ),
      ),
      floatingActionButton: returnQuiz
          ? FloatingActionButton.extended(
              onPressed: controller.backWithQuiz,
              label: const Icon(Icons.check),
            )
          : null,
      body: FutureBuilder<void>(
        future: controller.getQuizzes(),
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            return GetBuilder<SolvedQuizzesController>(
              builder:(_) => RefreshIndicator(
                onRefresh: controller.refreshList,
                child: controller.quizzesList.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        itemBuilder: (ctx, index) => QuizWidget(
                          hasGrade: hasGrade,
                          quiz: controller.quizzesList[index],
                          ontTap: returnQuiz
                              ? (s) => controller.selectQuiz(index)
                              : controller.onTapQuiz,
                          selected: controller.selectedIndex == index,
                          onDeleteQuiz: controller.userId == AppHelper.user!.sId
                              ? controller.onDeleteQuiz
                              : null,
                        ),
                        itemCount: controller.quizzesList.length,
                      )
                    : const NoResultFoundWidget(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
