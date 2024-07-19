import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validator,
  });
  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: widget.controller, decoration: InputDecoration(labelText: widget.labelText), keyboardType: TextInputType.number, validator: widget.validator);
  }
}
