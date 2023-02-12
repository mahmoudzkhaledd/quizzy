import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    Key? key,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    required this.text,
    this.borderColor,
    this.fontSize,
    this.borderWidth,
    this.padding,
    this.icon,
  }) : super(key: key) {
    backgroundColor = backgroundColor ?? Colors.black;
    textColor = textColor ?? Colors.white;
    borderColor = borderColor ?? Colors.transparent;
    fontSize = fontSize ?? 16;
    borderWidth = borderWidth ?? 0;
    padding = padding ?? EdgeInsets.zero;
  }

  EdgeInsets? padding;
  double? borderWidth;
  VoidCallback onTap;
  Color? borderColor;
  double? fontSize = 16;
  Color? backgroundColor;
  Color? textColor;
  String text = "";
  Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: borderWidth!,
              color: borderColor!,
            ),
          ),
        ),
        child: Padding(
          padding: padding!,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize!),
          ),
        ),
      );
    } else {
      return FilledButton.icon(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: borderWidth!,
              color: borderColor!,
            ),
          ),
        ),
        icon: icon!,
        label: Padding(
          padding: padding!,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize!),
          ),
        ),
      );
    }
  }
}
