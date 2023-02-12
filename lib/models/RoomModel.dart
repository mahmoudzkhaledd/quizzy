import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/models/PlayerModel.dart';

class RoomModel {
  late PlayerModel player1;
  late PlayerModel player2;
  bool host = false;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? snapShot;

  RoomModel() {
    player1 = PlayerModel();
    player2 = PlayerModel();
    player1.turn = 1;
    player1.host = true;
    player2.turn = 2;
  }

  String get getRoomId => roomPath != "" ? roomPath.split("/")[2] : "";
  bool started = false;
  String roomPath = "";
  String roomName = "";
  String password = "";
  String quizName = "";
  String quizPath = "";

  Map<String, dynamic> toJson() {
    return {
      "Name": roomName,
      "Started": started,
      "Password": password,
      "QuizPath": quizPath,
      "QuizName": quizName,
      "Player_1": player1.toJson(),
      "Player_2": player2.toJson(),
    };
  }

  RoomModel.fromJson(Map<String, dynamic> json) {
    player1 = PlayerModel();
    player2 = PlayerModel();
    roomPath = json['RoomPath'];
    started = json['Started'];
    roomName = json['Name'];
    password = json['Password'];
    quizName = json['QuizName'];
    quizPath = json['QuizPath'];
    player1.fromJson(json['Player_1']);
    player2.fromJson(json['Player_2']);
  }
}
