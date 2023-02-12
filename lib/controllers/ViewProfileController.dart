import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/UserServices.dart';
import 'package:quizapp/models/UserModel.dart';
import 'package:quizapp/views/ProfileSettings.dart';

class ViewProfileController extends GetxController {
  String userID = "";
  late UserModel user;

  void init(String id) {
    userID = id;
  }

  void onEditProfile() async {
    if (userID == FirebaseAuth.instance.currentUser!.uid) {
      await Get.to(
        () => ProfileSettings(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );
      await getUser();
      update();
    }
  }

  Future<int> getUser() async {
    user = await UserWebServices.getUserData(userID);
    return 1;
  }
}
