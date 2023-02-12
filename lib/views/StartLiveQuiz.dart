import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/CustomButton.dart';
import 'package:quizapp/Widgets/TextBox.dart';

import '../controllers/StartLiveQuizController.dart';
import '../general_methods/TextStyles.dart';

class StartLiveQuiz extends GetView<StartLiveQuizController> {
  StartLiveQuiz({Key? key}) : super(key: key) {
    Get.put(StartLiveQuizController());
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Start Live Quiz",
          style: TextStyles.appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/aaa.png",
              width: w / 1.1,
            ),
            GetBuilder<StartLiveQuizController>(
              id: "StackBuilder",
              builder: (_) => IndexedStack(
                index: controller.currentIndex,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonWidget(
                        color: Colors.yellowAccent,
                        onTap: controller.goToJoinRoom,
                        text: "Join Room",
                      ),
                      const SizedBox(height: 20),
                      CustomButtonWidget(
                        color: Colors.greenAccent,
                        onTap: controller.goToCreateRoom,
                        text: "Create Room",
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            InputTextBox(
                              onChanged: (value) =>
                                  controller.room.roomName = value,
                              hintText: "Room Name",
                              icon: const Icon(Icons.drive_file_rename_outline),
                            ),
                            const SizedBox(height: 20),
                            InputTextBox(
                              onChanged: (value) =>
                                  controller.room.password = value,
                              hintText: "Room Password",
                              icon: const Icon(Icons.key),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GetBuilder<StartLiveQuizController>(
                          id: "ListTileBuilder",
                          builder: (_) => ListTile(
                            leading: const Icon(Icons.quiz_outlined),
                            title: Text(
                              controller.room.quizName == ""
                                  ? "No Chosen Quiz"
                                  : controller.room.quizName,
                              style: TextStyles.listTileTitleStyle,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Pick a Quiz",
                            style: TextStyles.listTileTitleStyle,
                          ),
                          subtitle: const Text(
                            "Click To Choose Any Quiz Or Make Your Own",
                            style: TextStyles.listTileSubTitleStyle,
                          ),
                          trailing: FilledButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (ctx) => DraggableScrollableSheet(
                                  expand: false,
                                  initialChildSize: 0.5,
                                  maxChildSize: 0.5,
                                  minChildSize: 0.2,
                                  builder: (ctx, ctrl) => Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: SingleChildScrollView(
                                      controller: ctrl,
                                      child: Column(
                                        children: [
                                          Text(
                                            "How You Want To Pick A Quiz",
                                            style:
                                                TextStyles.titleStyle.copyWith(
                                              fontSize: 25,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          FilledButton.icon(
                                            onPressed:
                                                controller.openAllQuizzes,
                                            label:
                                                const Text("Open All Quizzes"),
                                            icon: const Icon(
                                              Icons.file_open_outlined,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          FilledButton.icon(
                                            onPressed: controller.makeQuiz,
                                            label: const Text("Make One"),
                                            icon:
                                                const Icon(Icons.quiz_outlined),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Choose Quiz"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButtonWidget(
                          color: Colors.blueAccent,
                          onTap: controller.goToWaitingLobby,
                          text: "Create Room",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GetBuilder<StartLiveQuizController>(
                                id: "CreateRoomButtonBuilder",
                                builder: (_) => controller.loading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.yellow,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Create Room",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        InputTextBox(
                          onChanged: (value) =>
                              controller.room.roomPath = value,
                          icon: const Icon(Icons.drive_file_rename_outline),
                          hintText: "Room Id",
                        ),
                        const SizedBox(height: 20),
                        InputTextBox(
                          onChanged: (value) =>
                              controller.room.password = value,
                          hintText: "Room Password",
                          icon: const Icon(Icons.key),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtonWidget(
                          color: Colors.redAccent,
                          onTap: controller.joinRoom,
                          text: 'Join',
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
