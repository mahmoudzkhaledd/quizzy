import 'package:flutter/services.dart';
import 'package:quizapp/general_methods/Themes.dart';
import 'package:quizapp/views/OnboardingScreen.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/views/SplashScreen.dart';

void main() async {

  SystemChrome.setSystemUIOverlayStyle(
   const  SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    )
  );
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //WebServices.initDio();
  runApp(const Quizzy());
}

class Quizzy extends StatelessWidget {
  const Quizzy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
