import 'dart:async';
import 'dart:convert';

import 'package:byteliz/src/utils/dialog_utils.dart';
import 'package:byteliz/src/utils/login_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordCodePage extends StatefulWidget {
  const ForgotPasswordCodePage({super.key});

  @override
  State<ForgotPasswordCodePage> createState() => _ForgotPasswordCodePageState();
}

class _ForgotPasswordCodePageState extends State<ForgotPasswordCodePage> {
  final TextEditingController _codeController = TextEditingController();
  bool _isResendButtonEnabled = false;
  int _resendCountdown = 120;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _isResendButtonEnabled = false;
      _resendCountdown = 120;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _isResendButtonEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  Future<void> _forgotPasswordCode(email) async {
    final code = _codeController.text;

    if (code == '') {
      showErrorDialog(context, "Código de validação não informado");
      return;
    }
    
    try {
      final response = await http.post(
        Uri.http('10.0.2.2:9999','/byteliz/forgotpassword/code'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'code': code,
        })
      );

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final data = jsonDecode(response.body);

        Navigator.of(context).pushReplacementNamed('/forgotpassword/newpassword', arguments: email);
      } else {
        showErrorDialog(context, response.body);
      }
    } catch (e) {
      showErrorDialog(context, "Problema de conexão com o servidor!");
    }
  }

  Future<void> _resendCode(String email) async {
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

      if (response.statusCode <= 200 || response.statusCode >= 300) {
        showErrorDialog(context, response.body);
      }
    } catch (e) {
      showErrorDialog(context, "Problema de conexão com o servidor!");
    }

    _startResendCountdown();
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
                  Container(
                    child: Column(
                      children: [
                        Text("Informe o código de verificação enviado.",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 209, 40, 34),
                              fontSize: 15,
                            ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: _codeController,
                          cursorColor: const Color.fromARGB(255, 209, 40, 34),
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputDecorationLogin('Código'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, informe o código.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isResendButtonEnabled
                              ? () => _resendCode(email)
                              : null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              _isResendButtonEnabled
                                  ? const Color.fromARGB(255, 209, 40, 34)
                                  : const Color.fromARGB(255, 209, 40, 34)
                                      .withOpacity(0.5),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              _isResendButtonEnabled
                                  ? 'Reenviar código'
                                  : 'Reenviar em $_resendCountdown s',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _forgotPasswordCode(email);
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 209, 40, 34)),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white)),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Validar código',
                              textAlign: TextAlign.center,
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