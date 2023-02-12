import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/UserServices.dart';
import 'package:quizapp/views/ViewProfile.dart';

import '../models/UserShortModel.dart';

class AddFriendController extends GetxController {
  List<UserShortModel> people = [];

  Future<int> refreshList(bool isUpdaet) async {
    people.clear();
    people = await UserWebServices.getAllusers();
    if (isUpdaet) {
      update();
    }
    return 1;
  }

  void addFriend(String id) async {
    await UserWebServices.addFriend(id);
    update();
  }

  void goToUserProfile(String id) {
    Get.to(
      () => ViewProfile(id: id),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }



  void acceptRequest(String acceptedID) async {
    await UserWebServices.acceptRequest(acceptedID);
    update();
  }
}
