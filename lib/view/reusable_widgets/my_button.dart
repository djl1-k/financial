// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

abstract class CustomButton {
  Widget buildButton(BuildContext context);
}

class MyButton extends StatelessWidget implements CustomButton{
  final String text;
  final void Function()? onTap;
  const MyButton({
    super.key,
    required this.text,
    required this.onTap
    });

  @override
  Widget buildButton(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12) 
      ),
      child: Center(
        child: Text(
          'Log In',
          style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18
          ),
        ),
      ),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // The build method is required by StatelessWidget but can be empty in this case
    return buildButton(context);
  }
}