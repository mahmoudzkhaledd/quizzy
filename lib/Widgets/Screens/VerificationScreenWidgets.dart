import 'package:flutter/material.dart';

import '../TextBox.dart';

class VerificationNumberText extends StatelessWidget {
  VerificationNumberText({Key? key,this.isLast,required this.onLast}) : super(key: key){
    isLast = isLast ?? false;
    onLast = onLast ?? (e){};
  }
  ValueChanged<String> onLast;
  bool? isLast;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 74,
      child: InputTextBox(
        isNumber: true,
        onChanged: onLast,
      ),
    );
  }
}
