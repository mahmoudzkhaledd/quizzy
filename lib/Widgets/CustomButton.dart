import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.color,
    required this.onTap,
    required this.text,
    this.child,
    this.textColor,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;
  final Color color;
  final Widget? child;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.only(top: 3, left: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        border: Border.all(color: Colors.black),
      ),
      child: MaterialButton(
        onPressed: onTap,
        height: 60,
        minWidth: double.infinity,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200),
        ),
        child: child ?? Text(
          text,
          style:  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
