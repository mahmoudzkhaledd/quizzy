import 'package:flutter/material.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import '../DrawerListTile.dart';
import '../LoginButton.dart';

class LimitedTimeQuestion extends StatelessWidget {
  const LimitedTimeQuestion({Key? key, required this.onTap, required this.time})
      : super(key: key);
  final VoidCallback onTap;
  final DateTime time;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppHelper.mainColor,
      ),
      padding: const EdgeInsets.all(10),
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      child: CustomListTile(
        onTap: onTap,
        title: "Time For Each Question",
        subTitle: "",
        trailing: "${time.hour} Hours\n${time.minute} Minutes\n${time.second} Seconds",
        icon: Icons.access_time,
      ),
    );
  }
}