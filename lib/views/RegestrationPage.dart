import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/RegestrationController.dart';
import '../general_methods/AppHelper.dart';
import '../Widgets/Resbonsive.dart';
import '../Widgets/Screens/LoginScreenWidgets.dart';

class RegestrationPage extends GetView<LoginController> {
  RegestrationPage({Key? key}) : super(key: key) {
    Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Test yourself and put your own quiz, Go live with your friends now.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/login_2.png",
                width: double.infinity,
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: controller.goToLoginPage,
                    height: 60,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(top: 3,left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Colors.black),
                    ),
                    child: MaterialButton(
                      onPressed: controller.goToSignUpPage ,
                      height: 60,
                      minWidth: double.infinity,
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
