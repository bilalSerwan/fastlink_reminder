import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.all(10.r),
      child: TextFormField(
        validator: validatorFunction,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              TextStyle(color: subcolor.withOpacity(0.5), fontSize: 15.sp),
          focusColor: primaryColor,
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor.withOpacity(0.7),
            size: 20.sp,
          ),
          suffix: suffixIcon == null
              ? const SizedBox()
              : Text(
                  '@nawroz.telecom.com',
                  style: subtitle2,
                ),
          labelStyle: subtitle.copyWith(color: subcolor.withOpacity(0.5)),
          label: Text(
            label,
          ),
          border: customeOutlineInputBorder(borderColor: primaryColor),
          enabledBorder: customeOutlineInputBorder(borderColor: primaryColor),
          focusedBorder: customeOutlineInputBorder(borderColor: primaryColor),
          errorBorder: customeOutlineInputBorder(borderColor: Colors.red),
        ),
      ),
    );
  }
}

OutlineInputBorder customeOutlineInputBorder({required Color borderColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      color: primaryColor,
      strokeAlign: 1.3,
    ),
  );
}
