import 'package:flutter/material.dart';
import 'package:quizapp/general_methods/SizedBoxes.dart';
import '../../../controllers/QuizExamController.dart';
import '../../../general_methods/AppHelper.dart';
import '../../../general_methods/TextStyles.dart';
import '../../../models/QuizModel.dart';

class ExamQuestionHeader extends StatelessWidget {
  const ExamQuestionHeader(
      {Key? key,
      required this.questionText,
      required this.backColor,
      required this.textColor})
      : super(key: key);
  final String questionText;
  final Color backColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: textColor,
          )),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class McqAnswersWidget extends StatelessWidget {
  McqAnswersWidget({
    Key? key,
    required this.answers,
    required this.selectedAnswer,
    required this.onSelectAnswer,
    required this.textColor,
  }) : super(key: key);
  final List<QuestionAnswerModel> answers;
  QuestionAnswerModel selectedAnswer;
  ValueChanged<int?> onSelectAnswer;
  Color textColor;

  Widget _makeMcqAnswer(QuestionAnswerModel answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RadioListTile<int>(
        activeColor: textColor,
        toggleable: true,
        title: Text(
          answer.answer,
          style: TextStyles.listTileTitleStyle.copyWith(
            color: textColor,
            fontSize: 20,
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: textColor),
          borderRadius: BorderRadius.circular(13),
        ),
        value: answer.index,
        groupValue: selectedAnswer.index,
        onChanged: onSelectAnswer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        answers.length,
        (index) => _makeMcqAnswer(answers[index]),
      ),
    );
  }
}

class CompleteAnswersWidget extends StatelessWidget {
  CompleteAnswersWidget(
      {Key? key, required this.onChangedAnswer, required this.controller})
      : super(key: key);

  ValueChanged<String> onChangedAnswer;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      onChanged: onChangedAnswer,
      controller: controller,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          filled: true,
          hintText: "Answer",
          labelText: "Answer",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}

class EndExamBody extends StatelessWidget {
  const EndExamBody({
    Key? key,
    required this.maximumPoints,
    required this.result,
    required this.textColor,
    required this.earn,
  }) : super(key: key);
  final double result;
  final double maximumPoints;
  final Color textColor;
  final bool earn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/Grades-cuate.png"),
        Text(
          "Congratulations",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
        Text(
          "You Have Passed The Quiz",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        Text(
          "Your Final Points Is",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.numbers,
              size: 50,
              color: textColor,
            ),
            Text(
              "${result.toStringAsFixed(2)} Point",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
          ],
        ),
        Text(
          "Out Of ${maximumPoints.toStringAsFixed(2)}\n+ ${earn ? AppHelper.coinsPerExam : 0} Coins",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),

      ],
    );
  }
}

class ExamQuestionBody extends StatelessWidget {
  const ExamQuestionBody({
    Key? key,
    required this.quizType,
    required this.textColor,
    required this.solvedAnswer,
    required this.completeController,
    required this.choices,
    required this.onCompleteAnswerChanged,
    required this.onSelectAnswer,
  }) : super(key: key);

  final QuizType quizType;

  final List<QuestionAnswerModel> choices;
  final void Function(int?) onSelectAnswer;

  final QuestionAnswerModel solvedAnswer;
  final Color textColor;
  final void Function(String) onCompleteAnswerChanged;
  final TextEditingController? completeController;

  @override
  Widget build(BuildContext context) {
    return quizType == QuizType.mcq
        ? McqAnswersWidget(
            answers: choices,
            onSelectAnswer: onSelectAnswer,
            selectedAnswer: solvedAnswer,
            textColor: textColor,
          )
        : CompleteAnswersWidget(
            onChangedAnswer: onCompleteAnswerChanged,
            controller: completeController!,
          );
  }
}
