import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/general_methods/SizedBoxes.dart';
import '../controllers/SplashScreenController.dart';
import '../general_methods/TextStyles.dart';

class SplashScreen extends GetView<SplashScreenController> {
  SplashScreen({Key? key}) : super(key: key){
    Get.put(SplashScreenController());
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(

      body: FutureBuilder<Widget>(
        future: controller.init(),
        builder: (ctx, snap) {
          if (!snap.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: w / 2.2,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "Quizzy",
                    style: TextStyles.titleStyle.copyWith(fontSize: 33),
                  ),
                  SizedBoxes.heightSizedBox,
                  const CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            return snap.data!;
          }
        },
      ),
    );
  }
}
