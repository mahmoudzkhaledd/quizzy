import '../UserModel.dart';





enum SignupResponseType {
  succefully,
  weakPassword,
  emailExists,
  error,
}



enum VerificationResponse {
  done,
  fail,
}



class LoginResponse {
  late LoginResponseType response;
  late UserModel? user;

  LoginResponse({required this.response, required this.user});
}

enum LoginResponseType {
  done,
  usernameOrPasswordError,
  unVerified,
}

class QuizzesResponse {
  DataResponseType response;
  List<dynamic>? data;

  QuizzesResponse({required this.data, required this.response});
}

enum DataResponseType {
  unauthorized,
  forbidden,
  done,
}
class GradeResponse {
  DataResponseType response;
  double data;

  GradeResponse({required this.data, required this.response});
}


enum QuizPublishResponse{
  done,
  unAuthorized,
  fail
}


