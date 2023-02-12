import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/CustomButton.dart';
import 'package:quizapp/models/RoomModel.dart';
import 'package:quizapp/Widgets/DrawerListTile.dart';
import 'package:quizapp/Widgets/ImageLoader.dart';
import 'package:quizapp/Widgets/TextBox.dart';

import '../controllers/WaitingLobbyController.dart';
import '../general_methods/TextStyles.dart';

class WaitingLobby extends GetView<WaitingLobbyController> {
  WaitingLobby({
    Key? key,
    required RoomModel room,
  }) : super(key: key) {
    Get.put(WaitingLobbyController(room));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()=> controller.popPage(true),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.popPage(true);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: const Text(
            "Waiting Lobby",
            textAlign: TextAlign.center,
            style: TextStyles.appBarStyle,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<WaitingLobbyController>(
            builder: (_) => Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "${controller.room.roomName} Room",
                    style: TextStyles.titleStyle,
                  ),
                ),
                const SizedBox(height: 20),
                controller.room.host
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: InputTextBox(
                              onChanged: (e) {},
                              isReadOnly: true,
                              initialText: controller.room.getRoomId,
                              hintText: "Room Id",
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: controller.copyRoomID,
                            icon: const Icon(Icons.copy),
                          ),
                          IconButton(
                            onPressed: controller.shareRoomId,
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageLoader(
                            imageUrl: controller.room.player1.imageUrl,
                            borderRadius: 500,
                            width: w / 2 - 70,
                            height: w / 2 - 70,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            controller.room.player1.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageLoader(
                            imageUrl: controller.room.player2.imageUrl,
                            borderRadius: 500,
                            width: w / 2 - 70,
                            height: w / 2 - 70,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            controller.room.player2.name == ""
                                ? "Player 2"
                                : controller.room.player2.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomListTile(
                  onTap: () {},
                  title: "Quiz: ${controller.room.quizName}",
                  subTitle: "The Quiz That You And Your Friend Will Exam",
                  icon: Icons.quiz,
                ),
                const SizedBox(height: 20),
                !controller.room.host
                    ? const Column(
                        children: [
                          Text("Waiting For Host To Start The Quiz"),
                          SizedBox(
                            height: 20,
                          ),
                          CircularProgressIndicator(),
                        ],
                      )
                    : const SizedBox.shrink(),
                controller.room.host
                    ? Column(
                        children: [
                          CustomButtonWidget(
                            onTap: controller.room.player2.playerPath == ""
                                ? controller.reloadPlayers
                                : controller.startRoom,
                            color: Colors.yellowAccent,
                            text: "",
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (controller.loading)
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.yellow,
                                    ),
                                  ),
                                const SizedBox(width: 10),
                                Text(
                                  controller.room.player2.playerPath == ""
                                      ? "Reload Players"
                                      : "Start Room",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtonWidget(
                            color: Colors.redAccent,
                            onTap: controller.deleteRoom,
                            text: "Delete Room",
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
