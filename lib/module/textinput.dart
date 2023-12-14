import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final void Function(String)? onSubmit;
  final TextInputAction textInputAction;

  const TextInput({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onSubmit,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Text(
            hintText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 5),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(90.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(90.0),
              ),
              labelText: hintText,
              labelStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            onFieldSubmitted: onSubmit,
            textInputAction: textInputAction,
          ),
        ),
      ],
    );
  }
}

