import 'dart:convert';

import 'package:byteliz/src/utils/dialog_utils.dart';
import 'package:byteliz/src/utils/login_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmeController = TextEditingController();

  Future<void> _register() async {
    final nome = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmePassword = _passwordConfirmeController.text;

    if (nome == '') {
      showErrorDialog(context, "Nome não informado");
      return;
    }  

    if (email != '') {
      if (!(email.contains('@')) || !(email.contains('.com'))) {
        showErrorDialog(context, "E-mail informado não é válido");
        return;
      }
    } else {
      showErrorDialog(context, "E-mail não informado");
      return;
    }

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
      final response = await http.put(
        Uri.http('10.0.2.2:9999','/byteliz/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nome': nome,
          'email': email,
          'password': password
        })
      );

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final data = jsonDecode(response.body);

        Navigator.of(context).pushReplacementNamed('/home', arguments: data['data']);
      } else {
        showErrorDialog(context, response.body);
      }
    } catch (e) {
      showErrorDialog(context, "Problema de conexão com o servidor!");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'Cadastrar-se',
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
                  Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          cursorColor: const Color.fromARGB(255, 209, 40, 34),
                          keyboardType: TextInputType.name,
                          decoration: inputDecorationLogin('Nome'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, informe o Nome.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          cursorColor: const Color.fromARGB(255, 209, 40, 34),
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputDecorationLogin('E-mail'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, informe o e-mail.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        PasswordField(controller: _passwordController, titleField: 'Senha',),
                        const SizedBox(height: 10),
                        PasswordField(controller: _passwordConfirmeController, titleField: 'Confirmar Senha',),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 209, 40, 34)),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white)),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Cadastrar-se',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Cadastrar-se com',
                    style: TextStyle(
                      color: Color.fromARGB(255, 209, 40, 34),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(
                                      Colors.white),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(
                                      Colors.black)),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/google.png',
                                    scale: 10,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Google',
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(
                                      const Color.fromARGB(255, 71, 99, 160)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(
                                      const Color.fromARGB(255, 255, 255, 255))),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/facebook.png',
                                  scale: 10,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Facebook',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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