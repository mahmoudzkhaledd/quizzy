import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar(
      {Key? key,
      required this.icons,
      required this.currentIndex,
      required this.onIndexChanged,
      required this.selectedColor})
      : super(key: key);
  List<Widget> icons = [];
  int currentIndex = 0;
  Color selectedColor;
  ValueChanged<int> onIndexChanged;

  Widget showIcon(Widget icon, index) {

    return Flexible(
      child: GestureDetector(
        onTap: () {
          onIndexChanged(index);
        },
        child: Container(

          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: currentIndex == index ? selectedColor : Colors.transparent,
          ),
          child: SizedBox(
            width: 23,
            height: 23,
            child: icons[index],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          icons.length,
          (index) => showIcon(icons[index], index),
        ),
      ),
    );
  }
}
