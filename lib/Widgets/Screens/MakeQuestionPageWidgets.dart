import 'package:flutter/material.dart';

import 'package:quizapp/general_methods/SizedBoxes.dart';
import '../TextBox.dart';

import '../../../models/QuizModel.dart';

class McqAnswer extends StatelessWidget {
  McqAnswer(
      {Key? key,
      required this.onDeleted,
      required this.onChanged,
      required this.initialText,
      required this.value,
      required this.groupValue,
      required this.onGroupValueChanged,
      })
      : super(key: key);

  ValueChanged<QuestionAnswerModel?> onGroupValueChanged;

  String initialText;
  VoidCallback onDeleted;
  ValueChanged<String> onChanged;

  QuestionAnswerModel value;

  QuestionAnswerModel? groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<QuestionAnswerModel>(
      key: key,
      contentPadding: const EdgeInsets.all(0),
      title: InputTextBox(
        hintText: "Answer",
        initialText: initialText,
        onChanged: onChanged,
      ),
      secondary: IconButton(
        onPressed: onDeleted,
        icon: const Icon(Icons.clear),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onGroupValueChanged,
    );
  }
}

class CompleteQuestionWidget extends StatelessWidget {
  CompleteQuestionWidget({Key? key, required this.onChanged,required this.answer}) : super(key: key){
    answer = answer ?? "";
  }
  final ValueChanged<String> onChanged;
  String? answer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBoxes.heightSizedBox,
        InputTextBox(
          initialText: answer,
          onChanged: onChanged,
          hintText: "Answer",
          icon: const Icon(Icons.text_snippet_outlined),
        ),
      ],
    );
  }
}
