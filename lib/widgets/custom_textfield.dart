import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText, labelText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon:  widget.labelText == 'Email'
                    ? Icon(Icons.mail)
                    : widget.labelText == 'Name'
                        ? Icon(Icons.person)
                        : Icon(Icons.search),
            
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
