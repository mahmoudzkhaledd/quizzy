import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ViewProfileController.dart';
import '../general_methods/TextStyles.dart';
import '../Widgets/Screens/ViewProfileScreenWidgets.dart';

class ViewProfile extends GetView<ViewProfileController> {
  ViewProfile({Key? key, required this.id}) : super(key: key) {
    Get.put(ViewProfileController());
    controller.init(id);
  }

  final String id ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Info",
          style: TextStyles.appBarStyle,
        ),
      ),
      body: GetBuilder<ViewProfileController>(
        builder: (_) => RefreshIndicator(
          onRefresh: () async {
            await controller.getUser();
            controller.update();
          },
          child: FutureBuilder<void>(
            future: controller.getUser(),
            builder: (ctx, snap) {
              if (snap.hasData) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ViewProfileHeader(
                      onEditProfile: controller.onEditProfile,
                      edit: id == FirebaseAuth.instance.currentUser!.uid,
                      imageUrl: controller.user.imageUrl,
                      name: controller.user.name,
                      username: controller.user.username,
                      email: controller.user.email,
                      phone: controller.user.phone,
                    ),
                    ViewProfileBody(
                      about: controller.user.about,
                      quizzesNumber: controller.user.quizzesNumber,
                      email: controller.user.email,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
