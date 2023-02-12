import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/general_methods/TextStyles.dart';
import 'package:quizapp/models/QuizModel.dart';

import '../../models/QuizShortModel.dart';

class QuizWidget extends StatelessWidget {
  QuizWidget({
    Key? key,
    required this.quiz,
    required this.ontTap,
    required this.hasGrade,
    this.selected,
    this.onDeleteQuiz,
  }) : super(key: key) {
    selected = selected ?? false;
  }

  final QuizShortModel quiz;
  final ValueChanged<String> ontTap;
  final bool hasGrade;
  bool? selected;
  final ValueChanged<String>? onDeleteQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 5,
          bottom: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isThreeLine: true,
        onTap: () => ontTap(quiz.path),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          radius: 25,
          child: Text(
            quiz.questionCount.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        title: Text(
          quiz.name,
          style: TextStyles.listTileTitleStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              " Subject: ${quiz.subject}",
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      size: 20,
                    ),
                    Text(
                      quiz.limitedTime
                          ? " ${Duration(hours: quiz.time.hour, minutes: quiz.time.minute, seconds: quiz.time.second).inSeconds} Seconds"
                          : " No Time Needed",
                      //" ${quiz.time.hour}:${quiz.time.minute}:${quiz.time.second}",
                      style: TextStyles.listTileSubTitleStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
        trailing: onDeleteQuiz != null
            ? IconButton(
                onPressed: () {
                  onDeleteQuiz!(quiz.path);
                },
                icon: const Icon(Icons.remove_circle_outline),
              )
            : selected!
                ? const Icon(Icons.check_circle)
                : hasGrade
                    ? Text(
                        quiz.grade.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
      ),
    );
  }
}
