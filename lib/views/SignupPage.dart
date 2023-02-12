import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/general_methods/SizedBoxes.dart';
import 'package:quizapp/Widgets/Resbonsive.dart';
import '../general_methods/AppHelper.dart';
import 'package:quizapp/Widgets/LoginButton.dart';
import 'package:quizapp/Widgets/TextBox.dart';
import '../../controllers/SignUpController.dart';

class SignUpPage extends GetView<SignupController> {
  SignUpPage({Key? key}) : super(key: key) {
    Get.put(SignupController());
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          child: GetBuilder<SignupController>(
            builder: (_) => Center(
              child: Responsive(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Signup",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Welcome to Quizzy",
                      style: TextStyle(
                        fontSize: 35/2,
                        color: Colors.grey[700],
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/Messaging-bro.png",
                        width: w / 1.3,
                      ),
                    ),
                    InputTextBox(
                      image: 'assets/images/account.png',
                      hintText: "Username",
                      onChanged: controller.setUsername,
                    ),
                    SizedBoxes.heightSizedBox,
                    InputTextBox(
                      image: 'assets/images/mail.png',
                      hintText: "Email",
                      isEmail: true,
                      onChanged: controller.setEmail,
                    ),
                    SizedBoxes.heightSizedBox,
                    InputTextBox(
                      image: 'assets/images/fingerprint.png',
                      hintText: "Password",
                      isPassword: !controller.showPassword,
                      onChanged: controller.setPassword,
                      rightIcon: IconButton(
                        onPressed: controller.togglePassword,
                        icon: Icon(!controller.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    SizedBoxes.heightSizedBox,
                    InputTextBox(
                      image: 'assets/images/fingerprint.png',
                      hintText: "Confirm Password",
                      isPassword: !controller.showConfirmPassword,
                      onChanged: controller.setConfirmPassword,
                      rightIcon: IconButton(
                        onPressed: controller.toggleConfirmPassword,
                        icon: Icon(!controller.showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
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
                        onPressed: controller.signUp,
                        height: 60,
                        minWidth: double.infinity,
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.isSignningup)
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
                              "Sign up",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    /*Center(
                      child: LoginButton(
                        icon: !controller.isSignningup?
                        const Icon(Icons.login_outlined,color: Colors.black,):
                        const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                        textColor: Colors.black,
                        borderColor: Colors.transparent,
                        onTap: controller.signUp,
                        text: "Signup",
                        backgroundColor: AppHelper.hexColor("#dbfb50"),
                        borderWidth: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                      ),
                    ),*/
                    SizedBoxes.heightSizedBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
