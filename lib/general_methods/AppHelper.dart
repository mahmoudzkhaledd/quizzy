import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../models/UserModel.dart';

class AppHelper {
  static UserModel? user;

  static Future<void> showPopMessage(String title, String content) async {
    await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FilledButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  static showToastMessage(String message) async {
    await Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
    );
  }
  static Future<bool> showYesNoMessage(String title,String body) async {
    bool? res = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          FilledButton(
            onPressed: () {
              Get.back<bool>(result: true);
            },
            child: const Text("Yes"),
          ),
          FilledButton(
            onPressed: () {
              Get.back<bool>(result: false);
            },
            child: const Text("NO"),
          ),
        ],
      ),
    );
    return res ?? false;
  }

  static Color mainColor = Colors.white;
  //static Color mainColor = hexColor("#f6f4f0");

  static const int coinsPerExam = 10;
  static const int coinsToMakeExam = 20;
  static const int initialCoins = 100;

  static Color hexColor(String color) {
    color = "FF${color.replaceAll("#", "")}";
    return Color(int.parse(color.toString(), radix: 16));
  }
}
