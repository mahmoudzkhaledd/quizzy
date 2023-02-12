import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Widgets/ImageLoader.dart';
import 'package:quizapp/Widgets/LoginButton.dart';
import 'package:quizapp/Widgets/TextBox.dart';
import '../controllers/ProfileSettingsController.dart';
import '../general_methods/SizedBoxes.dart';

class ProfileSettings extends GetView<ProfileSettingsController> {
  ProfileSettings({Key? key}) : super(key: key) {
    Get.put(ProfileSettingsController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Your Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: controller.getUserData(),
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            return GetBuilder<ProfileSettingsController>(
              builder: (_) => ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Positioned(
                          child: ImageLoader(
                            imageUrl: controller.newUser.imageUrl,
                            imageProvider: controller.imagePicked != null
                                ? FileImage(controller.imagePicked!)
                                : null,
                            borderRadius: 200,
                            width: 140,
                            height: 140,
                          ),
                        ),

                        /*Positioned(
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: (controller.imagePicked != null
                                      ? FileImage(controller.imagePicked!)
                                      : controller.newUser.imageUrl == ""
                                          ? const AssetImage(
                                              "assets/images/user (4).png")
                                          : NetworkImage(
                                              controller.currentUser.imageUrl,
                                            )) as ImageProvider,
                                ),
                              ),*/

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                              onPressed: controller.deleteImage,
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: CircleAvatar(
                            child: IconButton(
                              onPressed: controller.changeImage,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InputTextBox(
                    onChanged: controller.changeName,
                    hintText: "Name",
                    initialText: controller.currentUser.name,
                    image: "assets/images/name2.png",
                  ),
                  SizedBoxes.heightSizedBox,
                  InputTextBox(
                    onChanged: controller.changeUsername,
                    hintText: "User name",
                    initialText: controller.currentUser.username,
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    ),
                  ),
                  SizedBoxes.heightSizedBox,
                  InputTextBox(
                    onChanged: controller.changeEmail,
                    initialText: controller.currentUser.email,
                    hintText: "Email",
                    icon: const Icon(
                      Icons.email_outlined,
                      size: 30,
                    ),
                  ),
                  SizedBoxes.heightSizedBox,
                  InputTextBox(
                    onChanged: controller.changePhone,
                    initialText: controller.currentUser.phone,
                    hintText: "Phone",
                    image: "assets/images/phone-call.png",
                  ),
                  SizedBoxes.heightSizedBox,
                  TextFormField(
                    onChanged: controller.changeAbout,
                    initialValue: controller.currentUser.about,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "About",
                      labelText: "About",
                      prefixIcon: const Icon(
                        Icons.question_mark_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBoxes.heightSizedBox,
                  Center(
                    child: LoginButton(
                      onTap: controller.submitChanges,
                      text: "Submit Changes",
                      backgroundColor: Colors.amberAccent,
                      icon: controller.submitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator())
                          : const Icon(Icons.check_circle_outline),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
