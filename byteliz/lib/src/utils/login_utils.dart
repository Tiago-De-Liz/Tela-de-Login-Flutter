import 'package:flutter/material.dart';

InputDecoration inputDecorationLogin(String labeltext, {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: labeltext,
    suffixIcon: suffixIcon,
    labelStyle: const TextStyle(
      color: Color.fromARGB(255, 209, 40, 34),
    ),
    border: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 209, 40, 34),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 209, 40, 34),
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 209, 40, 34),
      ),
    ),
    focusColor: Color.fromARGB(255, 209, 40, 34),
  );
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String titleField;

  const PasswordField({super.key, required this.controller, required this.titleField});

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
      decoration: inputDecorationLogin(
        widget.titleField,
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