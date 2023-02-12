import 'package:flutter/material.dart';
import 'package:quizapp/models/UserShortModel.dart';
import 'ImageLoader.dart';

import '../../general_methods/TextStyles.dart';

class FriendWidget extends StatelessWidget {
  FriendWidget({
    Key? key,
    required this.model,
    required this.onTap,
    required this.onDeleteFriend
  }) : super(key: key);
  UserShortModel model;
  ValueChanged<String> onTap;
  void Function(String,String) onDeleteFriend;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap(model.id);
      },
      title: Text(
        model.username,
        style: TextStyles.listTileTitleStyle,
      ),
      leading: ImageLoader(
        imageUrl: model.imageUrl,
        borderRadius: 200,
        width: 50,
        height: 50,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${model.solvedQuizzes} Solved Quizzes",
            style: TextStyles.listTileSubTitleStyle,
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: (){
          onDeleteFriend(model.id,model.username);
        },
        icon: const Icon(Icons.remove_circle_outline),
      ),
    );
  }
}
