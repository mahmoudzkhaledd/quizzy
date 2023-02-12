import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/NoResultFoundWidget.dart';
import 'package:quizapp/Widgets/ViewUserWidget.dart';

import '../controllers/AddFriendController.dart';
import '../general_methods/TextStyles.dart';

class AddFriendPage extends GetView<AddFriendController> {
  AddFriendPage({Key? key}) : super(key: key) {
    Get.put(AddFriendController());
  }

  Widget showPeople(double w) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.85,
        crossAxisCount: 2,
      ),


      // SliverGridDelegateWithMaxCrossAxisExtent(
      //   mainAxisSpacing: 10,
      //   crossAxisSpacing: 10,
      //   childAspectRatio: 9/16,
      //   maxCrossAxisExtent: w/2 + 50,
      // ),
      itemCount: controller.people.length,
      itemBuilder: (BuildContext context, int index) => UserWidget(
        model: controller.people[index],
        onAddFriend: controller.addFriend,
        goToUserProfile: controller.goToUserProfile,
        acceptRequest: controller.acceptRequest,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Add Friend",
          style: TextStyles.appBarStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await controller.refreshList(true),
        child: GetBuilder<AddFriendController>(
          builder: (_) => FutureBuilder<void>(
            future: controller.refreshList(false),
            builder: (ctx, snap) {
              if (snap.hasData) {
                return controller.people.isNotEmpty
                    ? showPeople(w)
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
