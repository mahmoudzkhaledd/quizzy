import 'package:get/get.dart';
import 'package:quizapp/Services/AuthWebServices.dart';
import '../general_methods/AppHelper.dart';
import '../models/Web_Requests/Web_Request_Models.dart';
import '../views/VerificationPage.dart';

class SignupController extends GetxController {
  bool showPassword = false;
  bool showConfirmPassword = false;
  String userName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  bool isSignningup = false;

  void togglePassword() {
    showPassword = !showPassword;
    update();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  void setUsername(String username) => userName = username;

  void setPassword(String pass) => password = pass;

  void setConfirmPassword(String pass) => confirmPassword = pass;

  void setEmail(String email) => this.email = email;

  bool validateEmail() {
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  bool validateData()  {
    if (userName.isEmpty || password.isEmpty || email.isEmpty) {
      AppHelper.showPopMessage("Error", "Please Fill All data!");
      return false;
    }
    if (!validateEmail()) {
      AppHelper.showPopMessage("Error", "Please Enter a valid Email");
      return false;
    }
    if (password != confirmPassword) {
      AppHelper.showPopMessage("Error", "Password doesn't match");
      return false;
    }

    return true;
  }

  void signUp() async {
    if (validateData()) {
      isSignningup = true;
      update();
      SignupResponseType responseType = await AuthWebServices
          .signUp(email,password,userName);

      if(responseType == SignupResponseType.weakPassword){
        AppHelper.showPopMessage("Sign in Failed", "Password Is Very Weak");

      }else if(responseType == SignupResponseType.emailExists){
        AppHelper.showPopMessage("Sign in Failed", "Email is already in use");

      }else if(responseType == SignupResponseType.error){
        AppHelper.showPopMessage("Sign in Failed", "Error In Signing in");

      }else if(responseType == SignupResponseType.succefully){
        Get.off(()=>VerificationPage());
      }
    }

    isSignningup = false;
    update();

  }
}
