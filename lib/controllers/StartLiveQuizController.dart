import 'package:get/get.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/PlayerModel.dart';
import 'package:quizapp/models/RoomModel.dart';
import 'package:quizapp/views/SolvedQuizzes.dart';
import 'package:quizapp/views/WaitingLobby.dart';

import '../Services/QuizzesWebServices.dart';

class StartLiveQuizController extends GetxController {
  RoomModel room = RoomModel();

  int currentIndex = 0;
  bool loading = false;

  void openAllQuizzes() async {
    var data = await Get.to(
      () => GetQuizzesPage(
        allQuizzes: true,
        hasGrade: false,
        returnQuiz: true,
      ),
    );
    if (data != null && data['Path'] != "" && data['Name'] != "") {
      room.quizName = data['Name'];
      room.quizPath = data['Path'];
      Get.back();
      update(['ListTileBuilder']);
    }
  }

  void makeQuiz() {}

  void goToWaitingLobby() async {
    if (room.quizPath != "" && room.roomName != "" && room.password != "") {
      loading = true;
      update(['CreateRoomButtonBuilder']);

      room.player1.playerPath = "/users/${AppHelper.user!.sId}";
      room.player1.name = AppHelper.user!.username;
      room.player1.host = true;
      room.player1.imageUrl = AppHelper.user!.imageUrl;

      room.host = true;

      room.roomPath = await QuizzesWebServices.makeRoom(room);

      loading = false;
      update(['CreateRoomButtonBuilder']);
      Get.off(
        () => WaitingLobby(
          room: room,
        ),
      );
    } else {
      AppHelper.showPopMessage(
        "Error",
        room.quizPath == ""
            ? "Please Choose Quiz"
            : room.roomName == ""
                ? "Please Enter Room Name"
                : "Please Enter Room Password",
      );
    }
  }

  void goToJoinRoom() {
    currentIndex = 2;
    update(['StackBuilder']);
  }

  void goToCreateRoom() {
    currentIndex = 1;
    update(['StackBuilder']);
  }

  void joinRoom() async {
    if (room.roomPath == "" || room.password == "") {
      AppHelper.showPopMessage("Error", "Please Enter Full Data");
    } else {
      room.host = false;

      room.player2.turn = 2;

      room.player2.playerPath = "/users/${AppHelper.user!.sId}";

      room.player2.name = AppHelper.user!.username;

      room.player2.host = false;

      room.player2.imageUrl = AppHelper.user!.imageUrl;

      RoomModel? model = await QuizzesWebServices.joinRoom(room);

      if (model != null) {
        model.host = false;
        model.player2 = room.player2;
        Get.off(
          () => WaitingLobby(
            room: model,
          ),
        );
      } else {
        AppHelper.showPopMessage("Error", "The Room Does not Exist");
      }
    }
  }
}
