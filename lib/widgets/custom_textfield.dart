import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText, labelText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          obscureText: labelText == 'Password' ? true : false,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: labelText == 'Password'
                ? Icon(Icons.lock)
                : labelText == 'Email'
                    ? Icon(Icons.mail)
                    : labelText == 'Name'
                        ? Icon(Icons.person)
                        : Icon(Icons.search),
            suffixIcon:
                labelText == 'Password' ? Icon(Icons.remove_red_eye) : null,
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
            hintText: hintText,
            labelText: labelText,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
  }
}
