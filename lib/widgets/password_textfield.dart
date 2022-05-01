import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText, labelText;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    bool passObscure = true;
    toggleview() {
      setState(() {
        passObscure = !passObscure;
      });
    }

    return Container(
        width: 700,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.teal,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: TextFormField(
          obscureText: passObscure,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: () => toggleview(),
              icon: Icon(passObscure ? Icons.visibility : Icons.visibility_off),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: const Color(0xffF5F6FA),
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
  }
}
