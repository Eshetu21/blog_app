import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecureText;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObsecureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecureText,
        decoration: InputDecoration(hintText: hintText),
        validator: (value) {
          if (value == null || value.isEmpty) {
            print("$hintText is missing");
            return "$hintText is missing";
          }
          return null;
        },
      ),
    );
  }
}
