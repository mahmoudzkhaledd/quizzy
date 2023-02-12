import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/Web_Requests/Web_Request_Models.dart';

class AuthWebServices {
  static FirebaseAuth get auth => FirebaseAuth.instance;

  static User? get currentUser => auth.currentUser;

  static Future<SignupResponseType> signUp(
      String email, String password, String username) async {
    bool created = false;
    try {
      created = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then<bool>((value) async {
        if (value.user != null) {
          bool done = await FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .set({
                "Userid": value.user!.uid,
                "email": email,
                "SolvedQuizzes": [],
                "Username": username,
                "age": 0,
                "Phone": "",
                "password": password,
                "Name": "",
                "imageURL": "",
                "Coins":AppHelper.initialCoins,
              })
              .then<bool>((value) => true)
              .catchError((e) => false);
          return done;
        } else {
          return false;
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return SignupResponseType.weakPassword;
      } else if (e.code == "email-already-in-use") {
        return SignupResponseType.emailExists;
      }
    }

    if (created) {
      return SignupResponseType.succefully;
    } else {
      return SignupResponseType.error;
    }
  }

  static Future<bool> checkVerification() async {
    try {
      await currentUser!.reload();
      return currentUser!.emailVerified;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  static Future<void> resendVerification() async {
    if (currentUser != null) {
      await currentUser!.sendEmailVerification();
    }
  }

  static Future<LoginResponseType> login(String username, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: username, password: password);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {

          return LoginResponseType.done;
        } else {
          return LoginResponseType.unVerified;
        }
      } else {
        return LoginResponseType.usernameOrPasswordError;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == "wrong-password") {
        return LoginResponseType.usernameOrPasswordError;
      }
    }

    return LoginResponseType.done;
  }

  static Future<void> logout() async {
    await auth.signOut();
  }
}
