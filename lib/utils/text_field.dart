import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.controller,
    required this.validatorFunction,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String? Function(String?) validatorFunction;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: validatorFunction,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: subcolor.withOpacity(0.5), fontSize: 15),
          focusColor: primaryColor,
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor.withOpacity(0.7),
            size: 20,
          ),
          suffix: suffixIcon == null
              ? const SizedBox()
              : Text(
                  '@nawroz.telecom.com',
                  style: subtitle2,
                ),
          labelStyle: subtitle.copyWith(color: subcolor.withOpacity(0.5)),
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: primaryColor,
              strokeAlign: 1.3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: primaryColor,
              strokeAlign: 1.3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: primaryColor,
              strokeAlign: 1.3,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              strokeAlign: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
