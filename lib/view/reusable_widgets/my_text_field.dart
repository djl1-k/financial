// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

abstract class CustomTextField {
  Widget buildTextField(BuildContext context);
}

class MyTextField extends StatelessWidget implements CustomTextField{
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLine;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.maxLine,
  });

  @override
  Widget buildTextField(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        //border color
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12)
        ),
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12)
        ),
          fillColor: Colors.grey[200],
          filled: true,
    ),
    obscureText: obscureText,
    );
  }
  @override
  Widget build(BuildContext context) {
    // The build method is required by StatelessWidget but can be empty in this case
    return buildTextField(context);
  }
}
