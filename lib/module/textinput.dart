import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const TextInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white), // Set text color to white
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(
                90.0), // Set border radius for default state
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(
                90.0), // Set border radius for default state
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.white
                  .withOpacity(0.5)), // Set placeholder color to white
        ),
      ),
    );
  }
}
