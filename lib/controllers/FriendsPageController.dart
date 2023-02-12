import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/UserServices.dart';
import 'package:quizapp/views/ViewProfile.dart';

import '../general_methods/AppHelper.dart';
import '../models/UserShortModel.dart';

class FriendsPageController extends GetxController {
  List<UserShortModel> friendsList = [];

  Future<int> getFriends() async {
    friendsList = await UserWebServices.getFriends();
    update();
    return 1;
  }

  void onDeleteFriend(String id,String name) async {
    bool res = await AppHelper.showYesNoMessage("Warning", "Are You Sure You Want To Delete $name From Your Friends ?");
    if (res) {
      await UserWebServices.deleteFriend(id);
      update();
    }
  }

  void onTapFriend(String id) {
    Get.to(
      () => ViewProfile(
        id: id,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }
}
