import 'package:flutter/material.dart';

import '../../general_methods/TextStyles.dart';

class NoResultFoundWidget extends StatelessWidget {
  const NoResultFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/37578.jpg",
            width: w / 1.5,
          ),
           Text(
            "No Results Found!",
            style: TextStyles.listTileSubTitleStyle.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 80,),
        ],
      ),
    );
  }
}
