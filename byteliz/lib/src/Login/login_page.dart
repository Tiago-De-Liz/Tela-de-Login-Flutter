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
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
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
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(
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
                          cursorColor: Color.fromARGB(255, 209, 40, 34),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecorationLogin('E-mail'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, informe o e-mail.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        PasswordField(controller: _passwordController,),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                          side: BorderSide(
                              color: Color.fromARGB(255, 209, 40, 34),
                              width: 1),
                          value: _manterConectado,
                          activeColor: Color.fromARGB(255, 209, 40, 34),
                          overlayColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 134, 130)),
                          onChanged: (value) {
                            setState(() {
                              _manterConectado = value!;
                            });
                          },
                        ),
                        Text(
                          'Manter conectado?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 209, 40, 34),
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Text(
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
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Entrar',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 209, 40, 34)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Conectar-se com',
                    style: TextStyle(
                      color: Color.fromARGB(255, 209, 40, 34),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/google.png',
                                      scale: 10,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Google',
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black)),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/facebook.png',
                                    scale: 10,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Facebook',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 71, 99, 160)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 255, 255, 255))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Não tem uma conta?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 209, 40, 34),
                              fontSize: 15,
                            )),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: Text('Cadastrar Agora!',
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

InputDecoration InputDecorationLogin(String labeltext, {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: labeltext,
    suffixIcon: suffixIcon,
    labelStyle: TextStyle(
      color: Color.fromARGB(255, 209, 40, 34),
    ),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 209, 40, 34),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 209, 40, 34),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 209, 40, 34),
      ),
    ),
  );
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  String password = '';
  bool _obscureText = true; 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
        password = text;
      },
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecorationLogin(
        'Senha',
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, informe a senha.';
        }
        return null;
      },
    );
  }
}