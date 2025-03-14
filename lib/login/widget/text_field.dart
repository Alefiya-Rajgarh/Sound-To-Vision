import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField( decoration: InputDecoration(
      border: InputBorder.none,
      filled: true,
      fillColor:Color(0xFFedf0f8),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius.circular(30),
      )
    ),
    );
  }
}
