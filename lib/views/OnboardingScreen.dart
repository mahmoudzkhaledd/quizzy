import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/Services/StorageServices.dart';
import 'package:quizapp/Widgets/OnBoardPage.dart';
import 'package:quizapp/general_methods/AppHelper.dart';

import 'RegestrationPage.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key) {
    pages = [
      OnboardPageData(
        title: "Welcome To Quizzy",
        subTitle:
            "you can make your own quiz and share it with you friends for free",
        titleColor: AppHelper.hexColor("#e42a71"),
        subTitleColor: Colors.white,
        backgroundColor: AppHelper.hexColor("#000037"),
        image: 'assets/images/planet (1).png',
        backgroundWidget: LottieBuilder.asset("animations/bg-1.json"),
      ),
      OnboardPageData(
        title: "Live Quiz",
        subTitle:
            "you can play live quiz with your friends by on time quiz and see who will win",
        titleColor: AppHelper.hexColor("#7d34ad"),
        subTitleColor: Colors.black,
        backgroundColor: Colors.white,
        image: 'assets/images/planet (2).png',
        backgroundWidget: LottieBuilder.asset("animations/bg-2.json"),
      ),
      OnboardPageData(
        title: "Earn More Points",
        subTitle:
            "you can Earn more points and make more quizzes or play life quiz with your friends",
        titleColor: AppHelper.hexColor("#ee980f"),
        subTitleColor: Colors.white,
        backgroundColor: AppHelper.hexColor("#463975"),
        image: 'assets/images/planet (3).png',
        backgroundWidget: LottieBuilder.asset("animations/bg-3.json"),
      ),
    ];
  }

  List<OnboardPageData> pages = [];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        itemCount: widget.pages.length,
        itemBuilder: (int index) {
          WidgetsBinding.instance.addPostFrameCallback((t) {
            this.index = index;
            setState(() {});
          });

          return OnboardPage(data: widget.pages[index]);
        },
        colors: widget.pages.map((e) => e.backgroundColor).toList(),
        nextButtonBuilder: (ctx) => Icon(
          Icons.arrow_forward_rounded,
          color: index != 0 ? Colors.white : Colors.black,
        ),
        onFinish: () async {
          await StorageServices.doneOnboarding();
          Get.offAll(() => RegestrationPage());
        },
      ),
    );
  }
}
