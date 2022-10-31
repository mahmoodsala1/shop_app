import 'dart:ui';

import 'package:flutter/material.dart';

TextFormField textFormField(
    {required TextEditingController controller,
    void Function()? onSuffixTap,
    required String? Function(String? value) validate,
    required TextInputType textInputType,
    void Function(String value)? onsubmitted,
    void Function(String value)? onchange,
    obscure = false,
    IconData? suffix,
    required String lable,
    required IconData prefix}) {
  return TextFormField(
    onChanged: onchange,
    onFieldSubmitted: onsubmitted,
    controller: controller,
    validator: validate,
    keyboardType: textInputType,
    obscureText: obscure,
    decoration: InputDecoration(
      label: Text(lable),
      border: OutlineInputBorder(),
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
        onPressed: onSuffixTap,
        icon: Icon(suffix),
      ),
    ),
  );
}

Widget defultButton(
    {required String text,
    double width = double.infinity,
    double? height = 45,
    required Color color,
    Color? textColor,
    required void Function() onpressed}) {
  return Container(
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    height: height,
    width: width,
    alignment: Alignment.center,
    padding: EdgeInsets.all(10),
    child: MaterialButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}
