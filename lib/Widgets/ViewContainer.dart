import 'package:flutter/material.dart';

import '../../general_methods/AppHelper.dart';

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    Key? key,
    required this.imageLoc,
    required this.buttonText,
    required this.mainText,
    required this.buttonOnTap,
    required this.rightMargin,
  }) : super(key: key);

  final String mainText;
  final String buttonText;
  final String imageLoc;
  final void Function() buttonOnTap;
  final bool rightMargin;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        right: rightMargin ? 20:0,
        top: 20,
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppHelper.mainColor,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mainText,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
                FilledButton(
                  onPressed: buttonOnTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppHelper.hexColor("#f9fbfa"),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
          Flexible(
            child: Image.asset(
              imageLoc,
              width: (w - 40) / 2.5,
            ),
          ),
        ],
      ),
    );
  }
}
