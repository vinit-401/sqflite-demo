import 'package:flutter/material.dart';

Color kWhite = Colors.white;
Color kGrey = Colors.grey.shade200;
Color kBlack = Colors.black;

InputDecoration decorationCustom(
  String hintText,
    {
  Widget? suffixIcon,
}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      labelText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      labelStyle: TextStyle(color: Colors.black45),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.black45, width: 0.8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      suffixIcon: suffixIcon);
}
