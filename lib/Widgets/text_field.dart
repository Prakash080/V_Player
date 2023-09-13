// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              // borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      );
}
