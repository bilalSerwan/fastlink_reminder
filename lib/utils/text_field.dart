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
    this.showPassword = false,
  });

  final TextEditingController controller;
  final String? Function(String?) validatorFunction;
  final String label;
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool showPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: TextFormField(
        validator: validatorFunction,
        obscureText: showPassword,
        autocorrect: false,
        obscuringCharacter: '*',
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.w),
          constraints: BoxConstraints(maxHeight: 70.h, maxWidth: 0.9.sw),
          hintText: hintText,
          hintStyle:
              TextStyle(color: subcolor.withOpacity(0.5), fontSize: 15.sp),
          focusColor: primaryColor,
          prefixIcon: prefixIcon,
          suffix: suffixIcon,
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
