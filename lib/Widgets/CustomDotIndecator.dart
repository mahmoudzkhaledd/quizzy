import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({
    Key? key,
    required this.length,
    required this.groupIndex,
  }) : super(key: key);


  final int length;
  final int groupIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.only(right: 10),
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 500),
          width:index == groupIndex ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
