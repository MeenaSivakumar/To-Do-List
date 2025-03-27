import 'package:flutter/material.dart';
import 'package:to_do_list/utils.dart/theme.dart';

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
