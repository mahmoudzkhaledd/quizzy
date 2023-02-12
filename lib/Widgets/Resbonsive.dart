import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  Responsive({
    Key? key,
    this.maxWidth,
    required this.child
  }) : super(key: key) {
    maxWidth = maxWidth ?? 550;
  }

  final Widget child;
  late double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth!,
      ),
      child: child,
    );
  }
}
