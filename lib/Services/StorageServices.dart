import 'package:get_storage/get_storage.dart';
import 'package:quizapp/models/LoginModel.dart';

class StorageServices {
  static final GetStorage _storage = GetStorage();

  static Future<int> saveUserData(LoginModel model) async {

    await _storage.write("Email", model.email);
    await _storage.write("Password", model.password);
    return 1;
  }

  static Future<LoginModel> getLoginData() async {
    LoginModel model = LoginModel("", "");
    if (_storage.hasData('Email')) {
      model.email = await _storage.read("Email");
    }
    if (_storage.hasData("Password")) {
      model.password = await _storage.read("Password");
    }
    return model;
  }

  static Future<void> clearUserData() async {
    await _storage.write("Email", "");
    await _storage.write("Password", "");
  }

  static Future<void> doneOnboarding() async {
    await _storage.write("Onboard", true);
  }
  static Future<void> clearOnboardingScreen() async {
    await _storage.write("Onboard", false);
  }
  static Future<bool> checkOnboarding() async {
    bool? done = _storage.read<bool?>("Onboard");
    return done ?? false;
  }

  static Future<void> resetStorage() async {
    await clearUserData();
    await clearOnboardingScreen();
  }


}
