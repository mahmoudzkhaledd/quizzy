import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/Services/UserServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';

import 'package:quizapp/models/UserModel.dart';

class ProfileSettingsController extends GetxController {
  late UserModel currentUser;
  late UserModel newUser;

  bool submitting = false;

  File? imagePicked;

  void changeImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage;
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagePicked = File(pickedImage.path);
      newUser.imageUrl = pickedImage.path;
      update();
    }
  }

  void changeName(String value) => newUser.name = value;

  void changeUsername(String value) => newUser.username = value;

  void changeEmail(String value) => newUser.email = value;

  void changePhone(String value) => newUser.phone = value;

  Map<String, dynamic> getDataMap() {
    Map<String, dynamic> mp = {};
    if (currentUser.name != newUser.name) mp['Name'] = newUser.name;
    if (currentUser.age != newUser.age) mp['age'] = newUser.age;
    if (currentUser.phone != newUser.phone) mp['Phone'] = newUser.phone;
    if (currentUser.email != newUser.email) mp['email'] = newUser.email;
    if (currentUser.username != newUser.username) mp['Username'] = newUser.username;
    if (currentUser.about != newUser.about) mp['About'] = newUser.about;

    if (currentUser.imageUrl != newUser.imageUrl) {
      mp['imageURL'] = newUser.imageUrl;
    }

    return mp;
  }

  void submitChanges() async {
    Map<String, dynamic> mp = getDataMap();

    if (validateData() && mp.isNotEmpty) {
      submitting = true;
      update();

      await UserWebServices.changeUserProfile(mp);
      submitting = false;

      update();


      AppHelper.user = await UserWebServices.getUserData(AppHelper.user!.sId);

      Get.back();
    } else {
      if (mp.isEmpty) {
        await AppHelper.showPopMessage("Error", "No Change Entered!");

      } else if (!validateEmail()) {
        await AppHelper.showPopMessage("Validation Error", "Please Enter A Valid Email!");
      } else {
        await AppHelper.showPopMessage("Validation Error", "Please Fill All Data Required");
      }
    }
  }

  Future<int> getUserData() async {
    currentUser =
        await UserWebServices.getUserData(FirebaseAuth.instance.currentUser!.uid);
    newUser = currentUser.copy();
    return 1;
  }

  void deleteImage() async {
    newUser.imageUrl = "";
    imagePicked = null;
    update();
  }

  bool validateEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(newUser.email);

  bool validateData() => (newUser.name != "" &&
      newUser.username != "" &&
      newUser.email != "" &&
      newUser.phone != "" &&
      newUser.about != "" &&
      validateEmail());

  void changeAbout(String value) => newUser.about = value;
}
