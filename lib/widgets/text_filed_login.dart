import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;

  const CommonTextFormField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: hintText,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
