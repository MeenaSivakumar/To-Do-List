import 'package:flutter/material.dart';
import 'package:to_do_list/utils.dart/theme.dart';

class TextFields extends StatelessWidget {
  
  final String hintText;
  final IconData? iconButton;
  final VoidCallback onpressed;
  const TextFields(
      {super.key,
       
      required this.iconButton,
      required this.onpressed,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
            borderSide: BorderSide(
              width: 2,
              color: blue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
            borderSide: BorderSide(
              width: 2,
              color: blue,
            ),
          ),
          fillColor: const Color.fromARGB(23, 0, 0, 0),
          filled: true,
          hintText: hintText,
          labelText: hintText,
          
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: black,
          ),
          suffixIcon: IconButton(
            onPressed: onpressed,
            icon: Icon(
              iconButton,
            ),
            color: blue,
          ),
        ),
      ),
    );
  }
}
