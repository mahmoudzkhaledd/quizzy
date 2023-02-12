import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../general_methods/AppHelper.dart';
import '../../models/PlayerModel.dart';
import 'ImageLoader.dart';

class LiveQuizHeader extends StatelessWidget {
  LiveQuizHeader({
    Key? key,
    required this.player1,
    required this.player2,
    required this.questionsNumber,
    required this.stream,
    required this.onRoomDeleted,
    required this.host,
  }) : super(key: key);
  bool host;
  PlayerModel player1;
  PlayerModel player2;
  int questionsNumber;
  VoidCallback onRoomDeleted;
  Stream<DocumentSnapshot<Map<String, dynamic>>> stream;

  Widget playerWidget(PlayerModel player) {
    return Column(
      children: [
        ImageLoader(
          imageUrl: player.imageUrl,
          borderRadius: 200,
          width: 40,
          height: 40,
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          player.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          player.finished
              ? "Finished"
              : player.playerPath != ""
                  ? player.questionIndex.toString()
                  : "Out",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppHelper.mainColor,
      ),
      child: StreamBuilder(
        stream: stream,
        builder: (_, snap) {
          if (snap.hasData && snap.data!.exists && snap.data!.data() != null) {
            Map<String, dynamic> mp = snap.data!.data() as Map<String, dynamic>;
            player1.questionIndex = mp['Player_1']['CurrentQuestion'];
            player2.questionIndex = mp['Player_2']['CurrentQuestion'];
            player1.playerPath = mp['Player_1']['id'];
            player2.playerPath = mp['Player_2']['id'];
            player1.finished = player1.questionIndex == questionsNumber + 1;
            player2.finished = player2.questionIndex == questionsNumber + 1;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: playerWidget(player1),
                ),
                const Flexible(
                  child:  Text(
                    "VS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Expanded(
                  child: playerWidget(player2),
                ),
              ],
            );
          } else {
            if (snap.hasData && !snap.data!.exists && !host) {
              onRoomDeleted();
              return const SizedBox.shrink();
            }

            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
