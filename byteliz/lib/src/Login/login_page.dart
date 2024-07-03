import 'package:byteliz/src/utils/login_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _manterConectado = true;

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
                    'Login',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 209, 40, 34),
                              width: 1),
                          value: _manterConectado,
                          activeColor: const Color.fromARGB(255, 209, 40, 34),
                          overlayColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 134, 130)),
                          onChanged: (value) {
                            setState(() {
                              _manterConectado = value!;
                            });
                          },
                        ),
                        const Text(
                          'Manter conectado?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 209, 40, 34),
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/forgotpassword');
                          },
                          child: const Text(
                            'Esqueceu a Senha?',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 0, 140, 255),
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(255, 0, 140, 255),
                              decorationThickness: 2.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //_login();
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 209, 40, 34)),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white)),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Entrar',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Conectar-se com',
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem uma conta?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 209, 40, 34),
                              fontSize: 15,
                            )),
                        const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: const Text('Cadastrar Agora!',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 140, 255),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(255, 0, 140, 255),
                              decorationThickness: 2.0,
                            ),
                          ),
                        )
                      ],
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