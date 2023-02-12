import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:quizapp/Services/AuthWebServices.dart';
import 'package:quizapp/Services/WebServices.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/models/FreindRequestModel.dart';
import '../models/UserModel.dart';
import '../models/UserShortModel.dart';

class UserWebServices {
  static Future<String> uploadProfileImage(String path) async {
    File file = File(path);
    String name = basename(path);
    var refStorage = FirebaseStorage.instance
        .ref("ProfileImages/${AuthWebServices.auth.currentUser!.uid}");

    String url = "";

    await refStorage.putFile(file).then((value) async {
      url = await value.ref.getDownloadURL();
    });

    bool done = await WebServices.fireStore
        .collection("users")
        .doc(AuthWebServices.currentUser!.uid)
        .update({"imageURL": url})
        .then<bool>((value) => true)
        .catchError((e) => false);
    if (done) {
      return url;
    } else {
      return "";
    }
  }

  static Future<UserModel> getUserData(String id) async {
    DocumentSnapshot snapshot =
        await WebServices.fireStore.collection("users").doc(id).get();

    var quizSnap = await WebServices.fireStore
        .collection("users")
        .doc(id)
        .collection("SolvedQuizzes")
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> mp = snapshot.data() as Map<String, dynamic>;
      mp['SolvedQuizzesNumber'] = quizSnap.docs.length;
      mp['id'] = id;

      return UserModel.fromJson(mp);
    } else {
      return UserModel();
    }
  }


  static Future<Map<String,dynamic>> getUserDataAsJson(String id) async {
    DocumentSnapshot snapshot =
    await WebServices.fireStore.collection("users").doc(id).get();

    var quizSnap = await WebServices.fireStore
        .collection("users")
        .doc(id)
        .collection("SolvedQuizzes")
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> mp = snapshot.data() as Map<String, dynamic>;
      mp['SolvedQuizzesNumber'] = quizSnap.docs.length;
      mp['id'] = id;

      return mp;
    } else {
      return {};
    }
  }


  static changeUserProfile(Map<String, dynamic> mp) async {
    if (mp.containsKey("imageURL") && mp['imageURL'] != "") {
      mp['imageURL'] = await uploadProfileImage(mp['imageURL']);
    }

    DocumentReference userRef = WebServices.fireStore
        .collection("users")
        .doc(AuthWebServices.currentUser!.uid);

    await userRef.set(
      mp,
      SetOptions(merge: true),
    );
  }

  static Future<List<UserShortModel>> getAllusers() async {
    List<UserShortModel> users = [];
    List<String> addedList = [];
    List<String> pending = [];
    List<String> requestList = [];

    var added = await WebServices.fireStore
        .collection("users/${AppHelper.user!.sId}/Friends/")
        .get();

    var myPendingReqs = await WebServices.fireStore
        .collection("users/${AppHelper.user!.sId}/PendingRequests/")
        .get();

    var requests = await WebServices.fireStore
        .collection("users/${AppHelper.user!.sId}/FriendRequests/")
        .get();

    for (int i = 0; i < myPendingReqs.docs.length; i++) {
      pending.add(myPendingReqs.docs[i].data()['To'].toString());
    }

    for (int i = 0; i < requests.docs.length; i++) {
      requestList.add(requests.docs[i].data()['FromID'].toString());
    }

    for (int i = 0; i < added.docs.length; i++) {
      addedList.add(added.docs[i].data()['AddedId'].toString());
    }

    var usersInternet = await WebServices.fireStore.collection("users").get();

    for (int i = 0; i < usersInternet.docs.length; i++) {
      if (usersInternet.docs[i].id != AppHelper.user!.sId &&
          !addedList.contains(usersInternet.docs[i].id.toString())) {
        Map<String, dynamic> mp = usersInternet.docs[i].data();

        mp['SendRequest'] = requestList.contains(usersInternet.docs[i].id);

        mp['id'] = usersInternet.docs[i].id;

        mp['pending'] = pending.contains(usersInternet.docs[i].id);

        users.add(UserShortModel.fromJson(mp));
      }
    }

    return users;
  }

  static Future<void> addFriend(String toWhoId) async {
    WriteBatch batch = WebServices.fireStore.batch();

    DocumentReference addedtUser = WebServices.fireStore
        .collection("users/$toWhoId/FriendRequests/")
        .doc(AppHelper.user!.sId);

    DocumentReference pendingFriend = WebServices.fireStore
        .collection("/users/${AppHelper.user!.sId}/PendingRequests/")
        .doc(toWhoId);

    batch.set(addedtUser, {
      "FromID": AppHelper.user!.sId,
      "FromName": AppHelper.user!.username,
      "FromImageUrl": AppHelper.user!.imageUrl,
    });

    batch.set(pendingFriend, {
      "To": toWhoId,
    });
    await batch.commit();
  }

  static Future<List<FriendRequestModel>> getFreindRequests() async {
    List<FriendRequestModel> friendRequests = [];
    var reqs = await WebServices.fireStore
        .collection("/users/${AppHelper.user!.sId}/FriendRequests/")
        .get();
    for (int i = 0; i < reqs.docs.length; i++) {
      friendRequests.add(FriendRequestModel.fromJson(reqs.docs[i].data()));
    }
    return friendRequests;
  }

  static Future<void> acceptRequest(String acceptedID) async {
    var myFriendRequests = WebServices.fireStore
        .doc("/users/${AppHelper.user!.sId}/FriendRequests/$acceptedID");

    var hisPending = WebServices.fireStore
        .doc("/users/$acceptedID/PendingRequests/${AppHelper.user!.sId}");

    var myFriends = WebServices.fireStore
        .doc("users/${AppHelper.user!.sId}/Friends/$acceptedID");
    var hisFriends = WebServices.fireStore
        .doc("users/$acceptedID/Friends/${AppHelper.user!.sId}");

    WriteBatch batch = WebServices.fireStore.batch();
    batch.delete(myFriendRequests);
    batch.delete(hisPending);

    batch.set(myFriends, {"AddedId": acceptedID});

    batch.set(hisFriends, {"AddedId": AppHelper.user!.sId});

    await batch.commit().then<bool>((value) => true).catchError((err) => false);
  }

  static Future<List<UserShortModel>> getFriends() async {
    List<UserShortModel> friends = [];
    var data = await WebServices.fireStore
        .collection("users/${AppHelper.user!.sId}/Friends")
        .get();
    for (int i = 0; i < data.docs.length; i++) {
      String id = data.docs[i].data()['AddedId'].toString();
      var userData = await WebServices.fireStore.doc("users/$id").get();
      Map<String, dynamic> mp = userData.data() as Map<String, dynamic>;
      mp["id"] = userData.id;
      friends.add(UserShortModel.fromJson(mp));
    }
    return friends;
  }

  static Future<void> deleteFriend(String id) async {
    DocumentReference myFriends = WebServices.fireStore.doc("users/${AppHelper.user!.sId}/Friends/$id");
    DocumentReference hisFriends = WebServices.fireStore.doc("users/$id/Friends/${AppHelper.user!.sId}");
    WriteBatch batch = WebServices.fireStore.batch();
    batch.delete(myFriends);
    batch.delete(hisFriends);
    await batch.commit();
  }


}
