import 'package:byteliz/src/ForgotPassword/ForgotPasswordEmail_page.dart';
import 'package:byteliz/src/ForgotPassword/forgotpasswordcode_page.dart';
import 'package:byteliz/src/ForgotPassword/forgotpasswordnewpassword_page.dart';
import 'package:byteliz/src/Home/home_page.dart';
import 'package:byteliz/src/Login/login_page.dart';
import 'package:byteliz/src/Register/register_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(), 
        '/forgotpassword/email': (context) => ForgotPasswordEmailPage(),
        '/forgotpassword/code': (context) => ForgotPasswordCodePage(),
        '/forgotpassword/newpassword': (context) => ForgotPasswordNewPasswordPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
