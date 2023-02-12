class PlayerModel {
  int turn = 1;
  String name = "";
  String playerPath = "";
  String imageUrl = "";
  int questionIndex = 1;
  bool winner = false;
  bool host = false;
  bool finished = false;
  Map<String, dynamic> toJson() {
    return {
      "id": playerPath,
      "turn":turn,
      "Host":host,
      "Name": name,
      "imageUrl": imageUrl,
      "CurrentQuestion": questionIndex,
      "Winner": winner
    };
  }

  void fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    playerPath = json['id'];
    imageUrl = json['imageUrl'];
    questionIndex = json['CurrentQuestion'];
    winner = json['Winner'];
    turn = json["turn"];
    host = json["Host"];
  }
}
