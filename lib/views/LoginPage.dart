import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/Resbonsive.dart';

import '../controllers/LoginPageController.dart';
import '../general_methods/AppHelper.dart';
import '../general_methods/SizedBoxes.dart';
import '../Widgets/LoginButton.dart';
import '../Widgets/TextBox.dart';

class LoginPage extends GetView<LoginPageController> {
  LoginPage({Key? key}) : super(key: key) {
    Get.put(LoginPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leading: IconButton(
          onPressed: controller.goToRegestrationPage,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: GetBuilder<LoginPageController>(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBoxes.heightSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        InputTextBox(
                          hintText: "Email",
                          isEmail: true,
                          image: 'assets/images/account.png',
                          onChanged: controller.setUsername,
                        ),
                        SizedBoxes.heightSizedBox,
                        InputTextBox(
                          image: 'assets/images/fingerprint.png',
                          hintText: "Password",
                          isPassword: !controller.showPassword,
                          onChanged: controller.setPassword,
                          rightIcon: IconButton(
                            onPressed: controller.togglePassword,
                            icon: Icon(
                              !controller.showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBoxes.heightSizedBox,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Colors.black),
                    ),
                    child: MaterialButton(
                      onPressed: controller.login,
                      height: 60,
                      minWidth: double.infinity,
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.loggingIn)
                            const Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                              ],
                            ),
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login.png"),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
