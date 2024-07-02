import 'package:byteliz/src/ForgotPassword/ForgotPassword_page.dart';
import 'package:byteliz/src/Home/home_page.dart';
import 'package:byteliz/src/Login/login_page.dart';
import 'package:byteliz/src/Register/register_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(), 
        '/forgotpassword': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
