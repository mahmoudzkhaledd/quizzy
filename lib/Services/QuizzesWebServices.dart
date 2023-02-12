import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/Services/WebServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/PlayerModel.dart';
import 'package:quizapp/models/QuizShortModel.dart';
import 'package:quizapp/models/RoomModel.dart';
import '../models/QuizModel.dart';

class QuizzesWebServices {
  static FirebaseFirestore get _db => WebServices.fireStore;

  static Future<List<QuizShortModel>> getTopQuizzes() async {
    List<QuizShortModel> quizzes = [];
    var data = await _db.collectionGroup("MakedQuizzes").limit(5).get();

    for (var element in data.docs) {
      Map<String, dynamic> mp = element.data();
      mp['id'] = element.id;
      mp['QuizPath'] = "/users/${mp['Userid']}/MakedQuizzes/${mp['id']}";
      try {
        quizzes.add(QuizShortModel.fromJson(mp, false));
      } catch (e) {}
    }

    return quizzes;
  }

  static Future<Quiz> getQuiz(String path) async {
    var data = await _db.doc(path).get();
    if (data.exists) {
      Map<String, dynamic> mp = data.data()!;
      mp['id'] = data.id;
      return Quiz.fromJson(mp);
    } else {
      return Quiz();
    }
  }

  static Future<bool> publishQuiz(Quiz quiz) async {
    quiz.userId = AppHelper.user!.sId;
    WriteBatch batch = _db.batch();
    DocumentReference quizDoc =
        _db.collection("/users/${AppHelper.user!.sId}/MakedQuizzes/").doc();
    DocumentReference userRef = _db.doc("/users/${AppHelper.user!.sId}");
    batch.set(quizDoc, quiz.toJson());

    batch.set(
      userRef, {
        "Coins": FieldValue.increment(AppHelper.coinsToMakeExam * -1),
      },
      SetOptions(merge: true),
    );

    bool published = await batch
        .commit()
        .then<bool>((value) => true)
        .catchError((err) => false);

    return published;
  }

  static Future<bool> finishQuiz(String path, double grade) async {
    DocumentReference solvedQuiz = _db.doc(path);
    DocumentReference myUserSolvedQuizzes = _db.doc("users/${AppHelper.user!.sId}/SolvedQuizzes/${path.split('/').last}");

    DocumentReference user = _db.doc("/users/${AppHelper.user!.sId}");

    WriteBatch writeBatch = WebServices.fireStore.batch();

    writeBatch.set(myUserSolvedQuizzes, {
      "Grade": grade,
      "QuizPath": path,
    });

    writeBatch.set(solvedQuiz, {
        "SolvedNumber": FieldValue.increment(1),
      }, SetOptions(merge: true));

    var solved = await _db.doc("users/${AppHelper.user!.sId}/SolvedQuizzes/${path.split('/').last}").get();

    bool earned = !solved.exists;

    if(earned){
      writeBatch.set(user, {
        "Coins": FieldValue.increment(AppHelper.coinsPerExam),
      }, SetOptions(merge: true));
    }


    await writeBatch.commit().then<bool>((value) => true).catchError((err) => false);

    return earned;
  }

  static Future<List<QuizShortModel>> getSolvedQuizzes() async {
    List<QuizShortModel> quizzes = [];

    var data = await _db
        .collection("/users/${AppHelper.user!.sId}/SolvedQuizzes/")
        .get();

    for (var element in data.docs) {
      QuizShortModel? quizShortModel = await getQuizShortModel(
          element.data()['QuizPath'], element.data()['Grade']);
      if (quizShortModel != null) quizzes.add(quizShortModel);
    }

    return quizzes;
  }

  static Future<List<QuizShortModel>> getAllQuizzes(int page) async {
    List<QuizShortModel> quizzes = [];
    QuerySnapshot snap = await _db.collectionGroup("MakedQuizzes").get();
    for (int i = 0; i < snap.docs.length; i++) {
      Map<String, dynamic> mp = snap.docs[i].data() as Map<String, dynamic>;
      mp['id'] = snap.docs[i].id;
      mp['QuizPath'] = "/users/${mp['Userid']}/MakedQuizzes/${mp['id']}";
      quizzes.add(QuizShortModel.fromJson(mp, false));
      try {} catch (e) {}
    }
    return quizzes;
  }

  static Future<String> makeRoom(RoomModel roomModel) async {
    var room = WebServices.fireStore.collection("Rooms").doc();
    room.set(roomModel.toJson());
    return "/Rooms/${room.id}";
  }

  static Future<Map<String, dynamic>> reloadUsers(String roomId) async {
    var data = await WebServices.fireStore.doc('Rooms/$roomId').get();
    if (data.exists) {
      return data.data()?['Player_2']['id'] == ""
          ? {}
          : data.data()?['Player_2'];
    } else {
      return {};
    }
  }

  static Future<RoomModel?> joinRoom(RoomModel room) async {
    var data = await WebServices.fireStore.doc("Rooms/${room.roomPath}").get();
    Map<String, dynamic> dataMap = data.data()!;
    if (data.exists &&
        dataMap['Password'] == room.password &&
        dataMap['Player_2']['id'] == "") {
      await WebServices.fireStore.doc("/Rooms/${room.roomPath}").update({
        "Player_2": room.player2.toJson(),
      });
      dataMap['RoomPath'] = "/Rooms/${data.id}";
      return RoomModel.fromJson(dataMap);
    } else {
      return null;
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getWaitingSnapShot(
      String roomPath) {
    return WebServices.fireStore.doc(roomPath).snapshots();
  }

  static Future<void> startRoom(String roomPath) async {
    await WebServices.fireStore.doc(roomPath).update({
      "Started": true,
    });
  }

  static Future<void> setPlayerCurrentIndex(
      int playerNumber, int currentQuestion, String roomPath) async {
    await WebServices.fireStore.doc(roomPath).set({
      "Player_$playerNumber": {
        "CurrentQuestion": currentQuestion,
      }
    }, SetOptions(merge: true));
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getRoomStream(
          String roomPath) =>
      WebServices.fireStore.doc(roomPath).snapshots();

  static Future<bool> deleteRoom(String roomPath) async {
    bool done = await WebServices.fireStore
        .doc(roomPath)
        .delete()
        .then<bool>((value) => true)
        .onError((error, stackTrace) => false);
    return done;
  }

  static Future<QuizShortModel?> getQuizShortModel(
      String path, double grade) async {
    var data = await WebServices.fireStore.doc(path).get();
    if (data.exists) {
      Map<String, dynamic> mp = data.data()!;
      mp['QuizPath'] = path;
      mp['grade'] = grade;
      return QuizShortModel.fromJson(mp, grade != -1);
    } else {
      return null;
    }
  }

  static Future<List<QuizShortModel>> getUserQuizzes(String userId) async {
    List<QuizShortModel> quizzes = [];
    var data = await _db.collection("/users/$userId/MakedQuizzes/").get();
    for (int i = 0; i < data.docs.length; i++) {
      Map<String, dynamic> json = data.docs[i].data();
      json['QuizPath'] = "/users/$userId/MakedQuizzes/${data.docs[i].id}";
      quizzes.add(QuizShortModel.fromJson(json, false));
    }
    return quizzes;
  }

  static Future<void> deleteQuiz(String deletedPath) async {
    await WebServices.fireStore.doc(deletedPath).delete();
  }

  static Future<void> exitPlayer(RoomModel room) async {
    await WebServices.fireStore.doc(room.roomPath).set(
      {
        "Player_2": {
          "id": "",
          "imageUrl": "",
          "Name": "",
        },
      },
      SetOptions(merge: true),
    );
  }
}
