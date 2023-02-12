import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextBox extends StatelessWidget {
  InputTextBox({
    Key? key,
    this.image,
    this.hintText,
    this.backgroundColor,
    this.rightIcon,
    this.isPassword,
    required this.onChanged,
    this.isNumber,
    this.initialText,
    this.icon,
    this.controller,
    this.isReadOnly,
    this.isEmail,
  }) : super(key: key) {
    hintText = hintText ?? "";
    isPassword = isPassword ?? false;
    isNumber = isNumber ?? false;
    isReadOnly = isReadOnly ?? false;
    isEmail = isEmail ?? false;
  }

  bool? isEmail = false;
  String? initialText;

  String? image = "";
  ValueChanged<String> onChanged;
  bool? isNumber = false;
  String? hintText = "";
  Widget? rightIcon;
  Color? backgroundColor;
  bool? isPassword;
  Icon? icon;
  TextEditingController? controller = null;
  bool? isReadOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly!,
      controller: controller,
      initialValue: initialText,
      onChanged: onChanged,
      obscureText: isPassword!,
      keyboardType: isNumber!
          ? TextInputType.number
          : isEmail!
              ? TextInputType.emailAddress
              : TextInputType.text,
      textAlign: isNumber! ? TextAlign.center : TextAlign.start,
      inputFormatters: isNumber!
          ? [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      decoration: InputDecoration(
        labelText: hintText,
        suffixIcon: rightIcon,
        prefixIcon: icon ??
            (image == null
                ? null
                : Container(
                    width: 20,
                    height: 20,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      image!,
                    ),
                  )),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
      ),
    );
  }
}
