import 'package:get/get.dart';
import 'package:quizapp/Services/UserServices.dart';
import 'package:quizapp/models/FreindRequestModel.dart';

class FriendRequestsController extends GetxController {
  List<FriendRequestModel> requests = [];

  Future<int> refreshList() async {
    requests.clear();

    requests = await UserWebServices.getFreindRequests();
    return 1;
  }

  void acceptRequest(String acceptedID) async {
    await UserWebServices.acceptRequest(acceptedID);
    update();
  }
}
