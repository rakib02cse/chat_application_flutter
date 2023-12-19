import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final bool obsureText;
  const MyTextField({
  super.key,
  required this.controller,
  required this.hinText,
  required this.obsureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField (
      controller: controller,
      obscureText: obsureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey[400],
        filled: true,
        hintText: hinText,
        hintStyle: const TextStyle(color:Colors.grey),

        ),
      );
      
    }
  }
