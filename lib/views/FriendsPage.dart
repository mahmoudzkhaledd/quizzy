import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/NoResultFoundWidget.dart';
import '../controllers/FriendsPageController.dart';
import '../general_methods/TextStyles.dart';
import '../Widgets/FriendWidget.dart';

class FriendsPage extends GetView<FriendsPageController> {
  FriendsPage({Key? key}) : super(key: key) {
    Get.put(FriendsPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Your Friends",
          style: TextStyles.appBarStyle,
        ),
      ),
      body: GetBuilder<FriendsPageController>(
        builder: (_) => RefreshIndicator(
          onRefresh: controller.getFriends,
          child: FutureBuilder<void>(
            future: controller.getFriends(),
            builder: (_, snap) {
              if (snap.hasData) {
                return controller.friendsList.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.friendsList.length,
                        itemBuilder: (_, i) => FriendWidget(
                          onTap: controller.onTapFriend,
                          onDeleteFriend: controller.onDeleteFriend,
                          model: controller.friendsList[i],
                        ),
                      )
                    : const NoResultFoundWidget();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
