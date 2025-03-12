import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final TextCapitalization capitalisation;
  final int maxLines;
  final int minLines;
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.inputType,
    required this.capitalisation,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32),
    borderSide: BorderSide(color: white),
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: widget.label,
        labelStyle: TextStyle(color: white),
        focusColor: white,
        focusedBorder: border,
        enabledBorder: border,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: border,
      ),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      keyboardType: widget.inputType,
      textCapitalization: widget.capitalisation,
      style: GoogleFonts.openSans(textStyle: TextStyle(color: white)),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your ${widget.label.toLowerCase()}";
        }
        return null;
      },
    );
  }
}
