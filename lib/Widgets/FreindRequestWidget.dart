import 'package:flutter/material.dart';
import 'package:quizapp/models/FreindRequestModel.dart';
import 'ImageLoader.dart';

class FreindRequestWidget extends StatelessWidget {
  FreindRequestWidget(
      {super.key, required this.model, required this.acceptRequest});

  FriendRequestModel model;
  ValueChanged<String> acceptRequest;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: const Border.fromBorderSide(
          BorderSide(
            width: 2,
            color: Colors.black38,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageLoader(
            imageUrl: model.fromImageUrl,
            borderRadius: 200,
            width: w / 6,
            height: w / 6,
          ),
          Flexible(
            child: Text(
              model.fromName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Flexible(
            child: FilledButton(
              onPressed: () {
                acceptRequest(model.fromID);
              },
              child: const Text("Accept"),
            ),
          )
        ],
      ),
    );
  }
}
