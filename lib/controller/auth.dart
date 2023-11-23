// ignore_for_file: prefer_const_constructors

import 'package:financial_app/view/pages/home_page.dart';
import 'package:financial_app/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Check if database has the login credentials
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Return homepage if it has
          if (snapshot.hasData){
            return HomePage();
          }
          // Return Loginpage if it doesn't
          else{
            return LoginPage();
          }
        },
      ),
    );
  }
}