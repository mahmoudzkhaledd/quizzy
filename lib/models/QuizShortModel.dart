extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}


class QuizShortModel {
  String _name = "";
  String get name => _name.toTitleCase();
  set name(val)=> _name = val;
  String path = "";

  String subject = "";

  String title = "";
  bool limitedTime = false;
  late DateTime time;
  int questionCount = 0;
  double grade = 0.0;
  QuizShortModel();
  QuizShortModel.fromJson(Map<String, dynamic> json, bool hasGrade) {
    name = json['Name'];
    questionCount = json['Questions'].length;
    subject = json['Subject'];
    title = json['Title'];
    limitedTime = json['LimitedTime'];
    path = json['QuizPath'];
    time = DateTime(
      2022,
      1,
      1,
      int.parse(json['QuestionTime']['Hours'].toString()),
      int.parse(json['QuestionTime']['Minutes'].toString()),
      int.parse(json['QuestionTime']['Seconds'].toString()),
    );

    if (hasGrade) {
      grade = double.parse(json['grade'].toString());
    }

  }
}
