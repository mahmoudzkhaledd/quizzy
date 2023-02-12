import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/AuthWebServices.dart';
import 'package:quizapp/Services/QuizzesWebServices.dart';
import 'package:quizapp/Services/StorageServices.dart';

import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/views/FreindRequests.dart';
import 'package:quizapp/views/FriendsPage.dart';

import 'package:quizapp/views/MakeQuizPage.dart';
import 'package:quizapp/views/ProfileSettings.dart';
import 'package:quizapp/views/RegestrationPage.dart';
import 'package:quizapp/views/SolvedQuizzes.dart';
import 'package:quizapp/views/QuizInformation.dart';
import 'package:quizapp/views/ViewProfile.dart';

import '../Services/UserServices.dart';
import '../models/QuizShortModel.dart';
import '../views/AddFriendPage.dart';
import '../views/StartLiveQuiz.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;

  List<QuizShortModel> quizzes = [];

  void goToMakeQuizPage() async {
    await Get.to(
        () => MakeQuizPage(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );
  }

  void friendsOnTap() => Get.to(
        () => FriendsPage(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );

  void showSolved() => Get.to(
        () => GetQuizzesPage(
          allQuizzes: false,
          hasGrade:true,
          returnQuiz: false,
        ),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );

  Future<int> refreshPage() async {
    quizzes.clear();
    quizzes = await QuizzesWebServices.getTopQuizzes();
    await AppHelper.user!.reload();

    update(['Top_Quizzes_List_Builder', 'Drawer_Builder']);
    return 1;
  }

  void onTapQuiz(String path) async {
    Get.to(
      () => QuizInformation(
        quiz: null,
        quizPath: path,
        tryQuiz: false,
        userModel: null,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void logOut() async {
    bool res= await AppHelper.showYesNoMessage("Warning", "Are You Sure To Logout ?");
    if (res && AppHelper.user != null) {
      await AuthWebServices.logout();
      await StorageServices.clearUserData();
      Get.offAll(() => RegestrationPage());
      AppHelper.user = null;
    }
  }

  void viewProfile() async {
    if (AppHelper.user != null) {
      await Get.to(
        () => ViewProfile(id: FirebaseAuth.instance.currentUser!.uid),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );

      update(['Drawer_Builder']);
    }
  }

  void goToProfileSettings() async {
    await Get.to(
      () => ProfileSettings(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );

    update(['Drawer_Builder']);
  }

  Future<int> init() async {
    AppHelper.user = await UserWebServices.getUserData(
        FirebaseAuth.instance.currentUser!.uid);
    await refreshPage();

    return 1;
  }

  void allQuizzesPage() {
    Get.to(
      () => GetQuizzesPage(
        allQuizzes: true,
        hasGrade:false,
        returnQuiz: false,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }



  void goToAddFriendPage() {
    Get.to(
      () => AddFriendPage(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void goToFriendRequests() {
    Get.to(
      () => FriendRequests(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void startLiveQuiz() {
    Get.to(
      () => StartLiveQuiz(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void goToYourQuizzes() {
    Get.to(
      () => GetQuizzesPage(
        allQuizzes: false,
        hasGrade:false,
        returnQuiz: false,
        userId: AppHelper.user!.sId,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }



  void onIndexValueChanged(int value) {
    currentIndex = value;
    update(['DotBuilder']);
  }

  void resetApp() async  {
    await StorageServices.resetStorage();
  }
}
