// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:financial_app/view/reusable_widgets/my_button.dart';
import 'package:financial_app/view/reusable_widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // for taking text
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Login function
  Future login() async{
    showDialog(
      context: context, 
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      )
      );
    try{
      // check email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
      );
      // if current widget is still in the widget tree, circular progress, remove it
      if (context.mounted) Navigator.pop(context);
    }
    // when error occurs, display error code (invalid-login-credentials)
    on FirebaseAuthException catch(e){
      Navigator.pop(context);
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text(e.code),
        ));
    }
  }
  
  @override
  void dispose() {
    //dispose controller
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Icon(
                    Icons.account_balance,
                    size: 100,
                    color: Colors.black,
                    ),
                  SizedBox(height: 25),
                  Text(
                    'G A L A X Y R A Y',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'In House Finance Tracker',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 75),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyTextField(
                        controller: emailController,
                        obscureText: false,
                        hintText: 'Email',
                        maxLine: 1,
                      ),
                    ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyTextField(
                      controller: passwordController,
                      obscureText: true,
                      hintText: 'Password',
                      maxLine: 1,
                      ),
                    ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyButton(onTap: login, text: 'Login',)
                  )
              ],
            ),
          ),
        )
        ),
    );
  }
}