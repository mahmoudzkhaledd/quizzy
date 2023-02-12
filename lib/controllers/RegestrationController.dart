import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/views/LoginPage.dart';

import '../views/SignupPage.dart';

class LoginController extends GetxController {
  void goToLoginPage() {
    Get.to(
      () => LoginPage(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void goToSignUpPage() {
    Get.to(
      () => SignUpPage(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }
}
