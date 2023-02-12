import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/Widgets/LoginButton.dart';
import '../controllers/VerificationController.dart';
import '../general_methods/SizedBoxes.dart';


class VerificationPage extends GetView<VerificationController> {
  VerificationPage({Key? key}) : super(key: key) {
    Get.put(VerificationController());

  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(

      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: GetBuilder<VerificationController>(
              builder: (_) => !controller.verified
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(
                                "assets/images/Confirmed-cuate.png",
                                width: w / 1.5)),
                        const Text(
                          "Check Verification",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 25),
                        ),
                        SizedBoxes.heightSizedBox,
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Verification Link Has Been Sent To ",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              TextSpan(
                                text:
                                    "${FirebaseAuth.instance.currentUser!.email}\n\n",
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const TextSpan(
                                text: "If You Hasn't Received any emails ",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        SizedBoxes.heightSizedBox,
                        Center(
                          child: FilledButton.icon(
                            label: const Text("Resend Email"),
                            onPressed: controller.resendEmail,
                            icon: !controller.resendingVerification
                                ? const Icon(Icons.email_outlined)
                                : const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.yellow,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBoxes.heightSizedBox,
                        Center(
                          child: LoginButton(
                            onTap: controller.checkVerification,
                            text: "Check Verification",
                            borderColor: Colors.transparent,
                            textColor: Colors.black,
                            icon: !controller.checkingVerification
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.black,
                                  )
                                : const CircularProgressIndicator(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            backgroundColor: Colors.yellow,
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Lottie.asset(
                          'animations/a2.json',
                          repeat: false,
                        ),
                        const Text(
                          "Verification Done",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          "Please Click On The Button Below To Go to home page.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBoxes.heightSizedBox,
                        LoginButton(
                          onTap: controller.goToLogin,
                          text: 'Go to home page',
                          backgroundColor: Colors.yellow,
                          borderColor: Colors.transparent,
                          textColor: Colors.black,
                          icon: const Icon(Icons.check_circle_outline),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
