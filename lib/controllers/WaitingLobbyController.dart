import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/QuizzesWebServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/QuizModel.dart';
import 'package:quizapp/views/ExamQuiz.dart';
import 'package:share_plus/share_plus.dart';
import '../models/RoomModel.dart';

class WaitingLobbyController extends GetxController {
  late RoomModel room;
  bool loading = false;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? waitingStream;

  WaitingLobbyController(this.room) {
    if (room.host) {
      room.player1.name = AppHelper.user!.username;
      room.player1.imageUrl = AppHelper.user!.imageUrl;
      room.player1.playerPath = AppHelper.user!.sId;
    }

    if (!room.host) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          waitingStream =
              QuizzesWebServices.getWaitingSnapShot(room.roomPath).listen(null);
          waitingStream?.onData(
            (data) async {
              if (data.exists) {
                room.started = data.data()?['Started'];
                if (room.started) {
                  waitingStream!.cancel();
                  Quiz quiz = await QuizzesWebServices.getQuiz(room.quizPath);
                  room.snapShot =
                      QuizzesWebServices.getRoomStream(room.roomPath);
                  Get.off(
                    () => QuizExam(
                      quiz: quiz,
                      tryQuiz: false,
                      room: room,
                    ),
                  );
                }
              } else {
                Get.back();
                AppHelper.showToastMessage("The Host has Closed The Room");
              }
            },
          );
        },
      );
    }
  }

  @override
  void onClose() {
    if (waitingStream != null) {
      waitingStream!.cancel();
      waitingStream = null;
    }
    super.onClose();
  }

  void startRoom() async {
    await reloadPlayers();

    if (room.player2.playerPath != "") {
      await QuizzesWebServices.startRoom(room.roomPath);
      Quiz quiz = await QuizzesWebServices.getQuiz(room.quizPath);
      room.snapShot = QuizzesWebServices.getRoomStream(room.roomPath);
      Get.off(
        () => QuizExam(
          quiz: quiz,
          tryQuiz: false,
          room: room,
        ),
      );
    }
  }

  Future<void> reloadPlayers() async {
    Map<String, dynamic> json =
        await QuizzesWebServices.reloadUsers(room.getRoomId);
    if (json.isNotEmpty) {
      room.player2.fromJson(json);
    } else {
      await AppHelper.showToastMessage("No Players yet!");
      room.player2.playerPath = "";
      room.player2.imageUrl = "";
    }
    update();
  }

  void deleteRoom() async {
    bool res = await AppHelper.showYesNoMessage("Warning", "Are you sure to delete the room ?");
    if(res){
      bool done = await QuizzesWebServices.deleteRoom(room.roomPath);
      if (done) {
        Get.back();
        AppHelper.showToastMessage("The Room Has Been Deleted");
      } else {
        AppHelper.showToastMessage("Delete Failed");
      }
    }
  }

  Future<bool> popPage(bool message) async {
    bool res = await AppHelper.showYesNoMessage(
      "Warning",
      room.host
          ? "Are You Sure To Delete The Room ?"
          : "Are You Sure To Exit The Live Quiz?",
    );
    if (res) {
      if (room.host) {
        await QuizzesWebServices.deleteRoom(room.roomPath);
      } else {
        await QuizzesWebServices.exitPlayer(room);
      }
    }
    return res;
  }

  void copyRoomID() async {
    await Clipboard.setData(
      ClipboardData(text: room.getRoomId),
    );
    AppHelper.showToastMessage("Copied To Clipboard");
  }

  void shareRoomId() async {
    await Share.share(room.getRoomId);
  }
}
