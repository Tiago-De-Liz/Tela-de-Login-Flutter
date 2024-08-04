import 'dart:convert';

import 'package:byteliz/src/utils/dialog_utils.dart';
import 'package:byteliz/src/utils/login_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordNewPasswordPage extends StatefulWidget {
  const ForgotPasswordNewPasswordPage({super.key});

  @override
  State<ForgotPasswordNewPasswordPage> createState() => _ForgotPasswordNewPasswordPageState();
}

class _ForgotPasswordNewPasswordPageState extends State<ForgotPasswordNewPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmeController = TextEditingController();

  Future<void> _forgotPasswordNewPassword(email) async {
    final password = _passwordController.text;
    final confirmePassword = _passwordConfirmeController.text;

    if (password != '' && confirmePassword != '') {
      final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
      if (!passwordRegExp.hasMatch(password)) {
        showErrorDialog(context, "A senha deve ter pelo menos 8 caracteres, incluindo uma letra e um número.");
        return;
      }

      if (password != confirmePassword) {
        showErrorDialog(context, "As senhas não correspondem");
        return;
      }
    } else {
      if (password == '') {
        showErrorDialog(context, "Senha não informada");
        return;
      }

      if (confirmePassword == '') {
        showErrorDialog(context, "Confirmar senha não informado");
        return;
      }
    }
    
    try {
      final response = await http.post(
        Uri.http('10.0.2.2:9999','/byteliz/forgotpassword/email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        })
      );

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        Navigator.of(context).popUntil(ModalRoute.withName('/login'));
      } else {
        showErrorDialog(context, response.body);
      }
    } catch (e) {
      showErrorDialog(context, "Problema de conexão com o servidor!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 209, 40, 34),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/icons/LogoByteLiz.png',
                    scale: 4,
                  ),
                  const Text(
                    'Recuperar Senha',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, bottom: 12.0, top: 20.0),
              child: Column(
                children: [
                  PasswordField(controller: _passwordController, titleField: 'Senha',),
                  const SizedBox(height: 10),
                  PasswordField(controller: _passwordConfirmeController, titleField: 'Confirmar Senha',),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      _forgotPasswordNewPassword(email);
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 209, 40, 34)),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white)),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Alterar Senha',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}