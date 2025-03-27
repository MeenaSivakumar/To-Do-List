import 'package:flutter/material.dart';
import 'package:to_do_list/utils.dart/theme.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: blue,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: white,
          fontSize: 20,
        ),
      ),
    );
  }
}
