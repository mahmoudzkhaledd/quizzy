import 'package:get/get.dart';
import 'package:quizapp/Services/AuthWebServices.dart';
import 'package:quizapp/views/MainPage.dart';
import '../general_methods/AppHelper.dart';

class VerificationController extends GetxController {
  String userId = "";
  String s1 = "";
  String s2 = "";
  String s3 = "";
  String s4 = "";
  bool checkingVerification = false;
  bool resendingVerification = false;
  bool verified = false;

  bool isEmpty() => s1.isEmpty || s2.isEmpty || s3.isEmpty || s4.isEmpty;

  String fullCode() => (s1 + s2 + s3 + s4);

  void goToLogin() => Get.offAll(() => HomePage());

  void checkVerification() async {
    checkingVerification = true;
    update();

    verified = await AuthWebServices.checkVerification();

    checkingVerification = false;
    update();

    if (!verified) {
      AppHelper.showPopMessage("Verification Error", "You are not verified yet");
    }
  }


  Future<void> resendEmail() async {
    resendingVerification = true;
    update();

    await AuthWebServices.resendVerification();

    resendingVerification = false;
    update();
  }

}
