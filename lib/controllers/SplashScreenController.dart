import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quizapp/Services/AuthWebServices.dart';
import 'package:quizapp/Services/StorageServices.dart';
import 'package:quizapp/models/LoginModel.dart';
import 'package:quizapp/models/Web_Requests/Web_Request_Models.dart';
import 'package:quizapp/views/MainPage.dart';
import 'package:quizapp/views/OnboardingScreen.dart';
import 'package:quizapp/views/RegestrationPage.dart';

class SplashScreenController extends GetxController {
  Future<Widget> init() async {
    bool boardDone = await StorageServices.checkOnboarding();
    print("Onboard $boardDone");
    late Widget screen;

    if(boardDone){
      LoginModel model = await StorageServices.getLoginData();
      print("Storage $model");
      if (model.hasData()) {
        LoginResponseType response = await AuthWebServices.login(model.email, model.password);
        print("login $response");
        if (response == LoginResponseType.done) {
          screen = HomePage();
        } else {
          screen = RegestrationPage();
        }
      } else {
        screen = RegestrationPage();
      }
    }else{
      screen = OnBoardingScreen();
    }
    await Future.delayed(const Duration(seconds: 5));

    return screen;
  }
}
