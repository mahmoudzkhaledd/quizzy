import 'package:flutter/material.dart';

class SlideContainer extends StatelessWidget {
  SlideContainer(
      {Key? key,
      required this.backgroundColor,
      required this.image,
      required this.text,
      required this.onTap,
      })
      : super(key: key);
  Color backgroundColor;

  String image;
  String text;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 1,
            color: Colors.black,
          )
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 100,
              height: 80,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
