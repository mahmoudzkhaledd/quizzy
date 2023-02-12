class FriendRequestModel {
  String fromID = "";

  String fromImageUrl = "";
  String fromName = "";

  FriendRequestModel.fromJson(Map<String, dynamic> json) {
    fromID = json['FromID'];
    fromImageUrl = json['FromImageUrl'];
    fromName = json['FromName'];
  }
}
