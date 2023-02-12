class Quiz {
  String path = "";
  bool limitedTime = false;
  bool canGoBack = false;
  String name = "";
  String title = "";
  String userId = "";
  String instructions = "";
  String subject = "";
  late DateTime questionsTime = DateTime(2022, 1, 1, 0, 0, 20);
  double grade = 0.0;

  int get questionNumber => questions.length;

  bool validateQuiz() {
    if (name.isEmpty) return false;
    if (title.isEmpty) return false;
    if (subject.isEmpty) return false;
    if (instructions.isEmpty) return false;
    if (questions.isEmpty) return false;
    if (limitedTime &&
        (questionsTime.hour * 60 * 60 +
                questionsTime.minute * 60 +
                questionsTime.second * 1.0 ==
            0)) return false;
    for (Question q in questions) {
      if (!q.validateQuestion(quizType)) return false;
    }
    return true;
  }

  double get maximumPoints {
    double sum = 0;
    for (Question q in questions) {
      sum += q.points;
    }
    return sum;
  }

  int solvedNumber = 0;

  late QuizType quizType;

  List<Question> questions = [];

  Quiz();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "Name": name,
      "Title": title,
      "Userid": userId,
      "Instructions": instructions,
      "QuestionTime": {
        "Hours": questionsTime.hour,
        "Minutes": questionsTime.minute,
        "Seconds": questionsTime.second
      },
      "Subject": subject,
      "MaximumPoints": maximumPoints,
      "SolvedNumber": solvedNumber,
      "LimitedTime": limitedTime,
      "CanGoBack": canGoBack,
      "QuizType": quizType == QuizType.complete ? "complete" : "MCQ",
      "Questions": questions.map((e) => e.toJson(quizType)).toList()
    };
  }

  double correctQuiz() {
    double res = 0;
    for (Question question in questions) {
      res += question.correctQuestion(quizType);
    }
    return res;
  }

  Quiz.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    subject = json['Subject'];
    title = json['Title'];
    userId = json['Userid'];
    instructions = json['Instructions'];
    solvedNumber = int.parse(json['SolvedNumber'].toString());
    canGoBack = json['CanGoBack'];
    limitedTime = json['LimitedTime'];
    quizType = json['QuizType'] == "complete" ? QuizType.complete : QuizType.mcq;
    questionsTime = DateTime(
      2022,
      1,
      1,
      int.parse(json['QuestionTime']['Hours'].toString()),
      int.parse(json['QuestionTime']['Minutes'].toString()),
      int.parse(json['QuestionTime']['Seconds'].toString()),
    );
    for (int i = 0; i < json['Questions'].length; i++) {
      questions.add(Question.fromJson(json['Questions'][i]));
    }
    path = "/users/$userId/MakedQuizzes/${json['id']}";
  }
}

class Question {
  late String text;
  double points = 0.0;
  QuestionAnswerModel answer = QuestionAnswerModel("");

  QuestionAnswerModel solvedAnswer = QuestionAnswerModel("");

  List<QuestionAnswerModel> choices = [];

  double correctQuestion(QuizType quizType) {
    double res = 0;
    if (quizType == QuizType.mcq) {
      if (answer.index == solvedAnswer.index) res = points;
    } else {
      if (solvedAnswer.answer == answer.answer) res = points;
    }
    return res;
  }

  late List<String> images;

  Question() {
    text = "";
    images = [];
    choices = [];
  }

  bool validateQuestion(QuizType quizType) {
    if (text == "") {
      return false;
    }
    if (quizType == QuizType.mcq) {
      if (answer.index == -1) return false;
    } else {
      if (answer.answer == "") return false;
    }

    if (quizType == QuizType.mcq) {
      if (choices.isEmpty) {
        return false;
      }
      for (QuestionAnswerModel ans in choices) {
        if (ans.answer.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  Question.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    points = double.parse(json['points'].toString());
    answer = QuestionAnswerModel.fromJson(json['answer']);

    for (int i = 0; i < json['choices'].length; i++) {
      choices.add(
        QuestionAnswerModel.fromJson(json['choices'][i]),
      );
    }

    for (int i = 0; i < json['images'].length; i++) {
      images.add(json['images'][i].toString());
    }
  }

  Map<String, dynamic> toJson(QuizType quizType) {
    return <String, dynamic>{
      "points": points,
      "text": text,
      "images": [],
      "answer": answer.toJson(),
      "choices": choices.map((e) => e.toJson()).toList(),
    };
  }
}

class QuestionAnswerModel {
  late String answer;

  int index = -1;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "answer": answer,
      "index": index,
    };
  }
  QuestionAnswerModel.fromJson(Map<String, dynamic> json){
    answer= json["answer"]  ;
    index= json["index"] ;
  }
  QuestionAnswerModel(this.answer);
}

enum QuizType {
  complete,
  mcq,
}
