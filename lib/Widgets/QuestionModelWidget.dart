import 'package:flutter/material.dart';
import 'package:quizapp/models/QuizModel.dart';
import 'TextBox.dart';

class McqAnswerModelWidget extends StatelessWidget {
  const McqAnswerModelWidget({
    Key? key,
    required this.answers,
    required this.onDeleteAnswer,
    required this.groupValue,
    required this.onCorrectAnswerChanged,
  }) : super(key: key);

  final List<QuestionAnswerModel> answers;

  final ValueChanged<QuestionAnswerModel> onDeleteAnswer;

  final ValueChanged<int?> onCorrectAnswerChanged;

  final int groupValue;

  Widget _makeQuestion(QuestionAnswerModel answerModel,int index) {
    answerModel.index = index;
    return RadioListTile<int>(
      value: answerModel.index,
      groupValue: groupValue,
      key: ValueKey(answerModel),
      contentPadding: const EdgeInsets.all(0),
      title: InputTextBox(
        onChanged: (val) => answerModel.answer = val,
        hintText: "Answer",
        initialText: answerModel.answer,
      ),
      secondary: IconButton(
        onPressed: () => onDeleteAnswer(answerModel),
        icon: const Icon(Icons.remove_circle),
        color: Colors.redAccent,
      ),
      onChanged: onCorrectAnswerChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        answers.length,
        (index) => _makeQuestion(answers[index],index),
      ),
    );
  }
}
