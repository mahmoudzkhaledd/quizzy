import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/NoResultFoundWidget.dart';
import '../controllers/FriendRequestsController.dart';
import '../general_methods/TextStyles.dart';
import '../Widgets/FreindRequestWidget.dart';

class FriendRequests extends GetView<FriendRequestsController> {
  FriendRequests({Key? key}) : super(key: key) {
    Get.put(FriendRequestsController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Friend Requests",
          style: TextStyles.appBarStyle,
        ),
      ),
      body: GetBuilder<FriendRequestsController>(
        builder: (_) => RefreshIndicator(
          onRefresh: controller.refreshList,
          child: FutureBuilder<void>(
            future: controller.refreshList(),
            builder: (_, snap) {
              if (snap.hasData) {
                if(controller.requests.isEmpty){
                  return const NoResultFoundWidget();
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) =>
                      FreindRequestWidget(
                    model: controller.requests[index],
                    acceptRequest: controller.acceptRequest,
                  ),
                  itemCount: controller.requests.length,
                );
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
