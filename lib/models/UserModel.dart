import 'package:quizapp/Services/UserServices.dart';

class UserModel {
  String sId = "";
  String name = "";
  String username = "";
  String password = "";
  int age = 0;
  int coins = 0;
  int quizzesNumber = 0;
  String phone = "";
  String email = "";
  String about = "";
  String imageUrl = "";
  List<String> quizzes = [];

  List<String> solvedQuizzes = [];

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    if(json.containsKey("Name")) name = json['Name'];
    if(json.containsKey("age"))  age = int.parse(json['age'].toString());
    if(json.containsKey("Phone"))  phone = json['Phone'];
    if(json.containsKey("email"))  email = json['email'];
    if(json.containsKey("id"))  sId = json['id'];
    if(json.containsKey("Username"))  username = json['Username'];
    if(json.containsKey("password"))  password = json['password'];
    if(json.containsKey("imageURL"))  imageUrl = json['imageURL'];
    if(json.containsKey("About"))  about = json['About'];
    if(json.containsKey("SolvedQuizzesNumber"))  quizzesNumber = int.parse(json['SolvedQuizzesNumber'].toString());
    if(json.containsKey("Coins"))  coins = int.parse(json['Coins'].toString());
  }

  UserModel copy(){
    UserModel model = UserModel();
    model.sId = sId;
    model.name = name;
    model.username = username;
    model.password = password;
    model.age = age;
    model.phone = phone;
    model.email = email;
    model.imageUrl = imageUrl;
    model.about = about;
    return model;
  }

  Future<void> reload() async {
    Map<String,dynamic> json = await UserWebServices.getUserDataAsJson(sId);
    if(json.isNotEmpty){
      if(json.containsKey("Name")) name = json['Name'];
      if(json.containsKey("age"))  age = int.parse(json['age'].toString());
      if(json.containsKey("Phone"))  phone = json['Phone'];
      if(json.containsKey("email"))  email = json['email'];
      if(json.containsKey("id"))  sId = json['id'];
      if(json.containsKey("Username"))  username = json['Username'];
      if(json.containsKey("password"))  password = json['password'];
      if(json.containsKey("imageURL"))  imageUrl = json['imageURL'];
      if(json.containsKey("About"))  about = json['About'];
      if(json.containsKey("SolvedQuizzesNumber"))  quizzesNumber = int.parse(json['SolvedQuizzesNumber'].toString());
      if(json.containsKey("Coins"))  coins = int.parse(json['Coins'].toString());
    }
  }

}
