import 'package:cloud_firestore/cloud_firestore.dart';
class WebServices {
  static FirebaseFirestore get fireStore => FirebaseFirestore.instance;
// static String baseUrl = "http://192.168.1.8:3000/";
// static late Dio dio;
// static String accessToken = "";
//
// static void initDio() {
//   BaseOptions options = BaseOptions(
//     baseUrl: baseUrl,
//     receiveTimeout: 20 * 1000,
//     connectTimeout: 20 * 1000,
//   );
//   dio = Dio(options);
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handeler) async {
//         options.headers['authorization'] = 'Bearer $accessToken';
//         return handeler.next(options);
//       },
//       onError: (error, handeler) {
//         print("error");
//       },
//     ),
//   );
// }
//
// static Future<SignupResponse> signup(SignupRequest request) async {
//   Response response = await dio.post(
//     "signup",
//     data: request.toJson(),
//     options: Options(
//       validateStatus: (status) => true,
//     ),
//   );
//
//   if (response.statusCode == 201 &&
//       response.data['result']['acknowledged'] == true &&
//       response.data['verificationInserted'] == true &&
//       response.data['emailSent'] == true) {
//     return SignupResponse(
//         id: response.data['result']['insertedId'].toString(),
//         responseType: SignupResponseType.succefully);
//   } else if (response.statusCode == 409 &&
//       response.data['error']['code'] == 11000) {
//     if (response.data['error']['keyPattern']['username'] == 1) {
//       return SignupResponse(
//           id: "", responseType: SignupResponseType.usernameExists);
//     } else if (response.data['error']['keyPattern']['email'] == 1) {
//       return SignupResponse(
//           id: "", responseType: SignupResponseType.emailExists);
//     }
//   }
//
//   return SignupResponse(id: "", responseType: SignupResponseType.failed);
// }
//
// static Future<VerificationResponse> verifyUser(
//     VerificationRequest request) async {
//   Response response = await dio.post(
//     "verification",
//     data: request.toJson(),
//     options: Options(
//       validateStatus: (status) => true,
//     ),
//   );
//
//   return response.data['response']
//       ? VerificationResponse.done
//       : VerificationResponse.fail;
// }
//
// static Future<LoginResponse> login(LoginRequest request) async {
//   Response response = await dio.post(
//     "login",
//     data: request.toJson(),
//     options: Options(
//       validateStatus: (status) => true,
//     ),
//   );
//
//   if (response.data['user'] != null) {
//     accessToken = response.data['token'];
//
//     return LoginResponse(
//         response: LoginResponseType.done,
//         user: UserModel()..fromJson(response.data['user']));
//   } else {
//     return LoginResponse(response: LoginResponseType.error, user: null);
//   }
// }
//
// static Future<QuizzesResponse> getAllQuizzes() async {
//   Response response = await dio.get(
//     "quizzes?page=0",
//     options: Options(
//       validateStatus: (status) => true,
//     ),
//   );
//   if (response.data.toString() == 'Unauthorized') {
//     return QuizzesResponse(
//       response: DataResponseType.unauthorized,
//       data: null,
//     );
//   } else if (response.data.toString() == 'Forbidden') {
//     return QuizzesResponse(
//       response: DataResponseType.forbidden,
//       data: null,
//     );
//   } else {
//     return QuizzesResponse(
//       response: DataResponseType.forbidden,
//       data: response.data,
//     );
//   }
// }
//
// static Future<QuizPublishResponse> publishQuiz(
//     Map<String, dynamic> quiz) async {
//   quiz['user_id'] = AppHelper.user!.sId;
//   Response response = await dio.post("/publish-quiz",
//       options: Options(
//         validateStatus: (status) => true,
//       ),
//       data: quiz);
//   if (response.statusCode == 401) {
//     return QuizPublishResponse.unAuthorized;
//   }
//   if (response.data['response'] == "updated") {
//     return QuizPublishResponse.done;
//   } else {
//     return QuizPublishResponse.fail;
//   }
// }
//
// static Future<QuizzesResponse> getQuiz(String id) async {
//   Response response = await dio.get(
//     "quiz/$id",
//     options: Options(
//       validateStatus: (status) => true,
//     ),
//   );
//   if (response.data.toString() == 'Unauthorized') {
//     return QuizzesResponse(
//       response: DataResponseType.unauthorized,
//       data: null,
//     );
//   } else if (response.data.toString() == 'Forbidden') {
//     return QuizzesResponse(
//       response: DataResponseType.forbidden,
//       data: null,
//     );
//   } else {
//     return QuizzesResponse(
//       response: DataResponseType.done,
//       data: [response.data],
//     );
//   }
// }
//
// static Future<GradeResponse> getQuizResult(
//     List<QuestionAnswerModel?> answers, String quizId) async {
//   Response response = await dio.post("correct-quiz",
//       options: Options(
//         validateStatus: (status) => true,
//       ),
//       data: <String, dynamic>{
//         'user_id': AppHelper.user.sId,
//         "quiz_id": quizId,
//         "answers": answers.map((e) => e == null ? null : e.toJson()).toList(),
//       });
//   if (response.data.toString() == 'Unauthorized') {
//     return GradeResponse(
//       response: DataResponseType.unauthorized,
//       data: 0,
//     );
//   } else if (response.data.toString() == 'Forbidden') {
//     return GradeResponse(
//       response: DataResponseType.forbidden,
//       data: 0,
//     );
//   } else {
//     return GradeResponse(
//       response: DataResponseType.done,
//       data: double.parse(response.data['grade'].toString()),
//     );
//   }
// }
//
// static Future<QuizzesResponse> getSolvedQuizzes() async {
//   Response response = await dio.get(
//     'user/${AppHelper.user.sId}/solved-quizzes',
//     options: Options(
//       validateStatus: (status) => true,
//     ),
//   );
//
//   if (response.data.toString() == 'Unauthorized') {
//     return QuizzesResponse(
//       response: DataResponseType.unauthorized,
//       data: null,
//     );
//   } else if (response.data.toString() == 'Forbidden') {
//     return QuizzesResponse(
//       response: DataResponseType.forbidden,
//       data: null,
//     );
//   } else {
//     return QuizzesResponse(
//       response: DataResponseType.done,
//       data: response.data[0]['solvedQuizzes'],
//     );
//   }
//
// }
//
}
