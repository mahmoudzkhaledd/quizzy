class UserShortModel {
  String id = "";
  String username = "";
  String imageUrl = "";
  int solvedQuizzes = 0;
  int makedQuizzes = 0;
  bool pending = false;
  bool sendRequest = false;
  UserShortModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json.containsKey("SendRequest")) sendRequest = json['SendRequest'];
    if (json.containsKey("pending")) pending = json['pending'];
    if (json.containsKey("Username")) username = json['Username'];
    if (json.containsKey("imageURL")) imageUrl = json['imageURL'];
    if (json.containsKey("SolvedQuizzes")) solvedQuizzes = json['SolvedQuizzes'].length;
    if (json.containsKey("MakedQuizzes")) makedQuizzes = json['MakedQuizzes'].length;
  }
}
