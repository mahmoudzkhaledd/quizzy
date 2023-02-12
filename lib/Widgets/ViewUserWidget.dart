import 'package:flutter/material.dart';
import 'package:quizapp/general_methods/TextStyles.dart';
import 'ImageLoader.dart';

import '../../models/UserShortModel.dart';

class UserWidget extends StatelessWidget {
  UserWidget({
    Key? key,
    required this.model,
    required this.onAddFriend,
    required this.goToUserProfile,
    required this.acceptRequest,
  }) : super(key: key);
  UserShortModel model;
  ValueChanged<String> onAddFriend;
  ValueChanged<String> goToUserProfile;
  ValueChanged<String> acceptRequest;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        goToUserProfile(model.id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 9),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageLoader(
                    imageUrl: model.imageUrl,
                    borderRadius: 200,
                    width: 40,
                    height: 40,
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () {
                        if (!model.pending && !model.sendRequest) {
                          onAddFriend(model.id);
                        }
                        if (model.sendRequest) {
                          acceptRequest(model.id);
                        }
                      },
                      style: IconButton.styleFrom(
                        backgroundColor:
                            (model.pending) ? Colors.white : Colors.amber,
                      ),
                      icon: Icon(
                        model.pending
                            ? Icons.access_time_outlined
                            : model.sendRequest
                                ? Icons.check
                                : Icons.add,
                        color: (model.pending) ? Colors.amber : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                model.username,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyles.listTileTitleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Flexible(
              child: Row(
                children: [
                  const Icon(Icons.quiz_outlined),
                  const SizedBox(width: 7),
                  Text(
                    "${model.solvedQuizzes} Solved Quizzes",
                    style: TextStyles.listTileSubTitleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Flexible(
              child: Row(
                children: [
                  const Icon(Icons.numbers_rounded),
                  const SizedBox(width: 7),
                  Text(
                    "${model.makedQuizzes} Owned Quizzes",
                    style: TextStyles.listTileSubTitleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
