import 'package:flutter/material.dart';

InputDecoration decorationConstant({
  required String hintText, //minta hinttext
  String? labelText, //minta label
  IconData? prefixIcon, //minta icon
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
    labelText: labelText,
    prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: Colors.white)
        : null,
    labelStyle: const TextStyle(color: Colors.white),
    floatingLabelStyle: TextStyle(color: Colors.green),
    //border diam
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    //border fokus
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.green, width: 2),
    ),
    //error
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
    ),
    errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 14),
  );
}
