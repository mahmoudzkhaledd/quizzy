import 'package:get/get.dart';
import 'package:quizapp/Services/AuthWebServices.dart';
import 'package:quizapp/Services/StorageServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/LoginModel.dart';
import 'package:quizapp/models/Web_Requests/Web_Request_Models.dart';
import 'package:quizapp/views/MainPage.dart';
import 'package:quizapp/views/RegestrationPage.dart';

import '../views/VerificationPage.dart';

class LoginPageController extends GetxController {
  bool showPassword = false;

  String email = "";

  bool loggingIn = false;
  String password = "";

  void setUsername(String user) => email = user;

  void setPassword(String pass) => password = pass;

  bool validate() => email != "" && password != "" && validateEmail();

  bool validateEmail() {
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  void login() async {
    if (validate()) {
      loggingIn = true;
      update();

      LoginResponseType responseType = await AuthWebServices.login(email, password);

      if (responseType == LoginResponseType.done) {
        await StorageServices.saveUserData(LoginModel(email, password));
        Get.offAll(() => HomePage());
      } else if (responseType == LoginResponseType.unVerified) {
        Get.offAll(() => VerificationPage());
      } else if (responseType == LoginResponseType.usernameOrPasswordError) {
        await AppHelper.showPopMessage("Login Failed", "Please Check Email Or Password");
      }

      loggingIn = false;
      update();
    } else {
      await AppHelper.showPopMessage("Warning", "Please Enter Full data.");
    }

    //   LoginResponse response = await WebServices.login(LoginRequest(username: username, password: password));
    //   if (response.response == LoginResponseType.done) {
    //     if (response.user!.verified) {
    //       if (response.user != null) {
    //         AppHelper.user = response.user!;
    //       }
    //       Get.offAll(() => HomePage());
    //     } else {
    //       Get.offAll(() => VerificationPage());
    //     }
    //   } else if (response.response == LoginResponseType.error) {
    //     Get.snackbar("Error", "Incorrect username or password.");
    //   }
    // } else {
    //   Get.snackbar("Warning", "Please Enter Full data.");
    // }
  }

  void goToRegestrationPage() => Get.back();

  void togglePassword() {
    showPassword = !showPassword;
    update();
  }
}
