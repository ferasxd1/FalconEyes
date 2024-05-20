import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData? suffixIcon;
  final bool readOnly;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  const TextFieldWidget(
      {Key? key,
      required this.hintText,
      this.suffixIcon,
      this.readOnly = true,
      this.textEditingController,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        readOnly: readOnly,
        decoration: InputDecoration(
          border: InputBorder.none, // Hide the default border of TextField
          hintText: hintText, // Add asterisk (*) to indicate required
          hintStyle: TextStyle(
            color: Color(0xffDEDADA),
          ), // Placeholder text style
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
          suffixIcon: suffixIcon != null
              ? Icon(
                  suffixIcon,
                  color: Color(0xffB2B2B2),
                )
              : null, // Padding for the input text
        ),
      ),
    );
  }
}
