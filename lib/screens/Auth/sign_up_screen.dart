// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/home/home_screen.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/loading_dialog.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    fullNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(10.w),
            width: 1.sw,
            height: 1.sh,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.18.sh,
                  ),
                  Text(
                    'FastLink',
                    style: largetext,
                  ),
                  Text(
                    'Reminder',
                    style: largetext,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                  //text field for Full Name
                  CustomeTextField(
                    controller: fullNameController,
                    validatorFunction: (value) {
                      return context
                          .read<AuthProvider>()
                          .validationFunction(value, 5, 50);
                    },
                    label: 'Full Name',
                    hintText: 'Enter Your Full Name',
                    prefixIcon: Icon(
                      Icons.person,
                      size: 20.r,
                      color: subcolor.withOpacity(0.4),
                    ),
                  ),

                  //text Field for email
                  CustomeTextField(
                    controller: emailController,
                    validatorFunction: (value) {
                      return context
                          .read<AuthProvider>()
                          .validationFunction(value, 5, 50);
                    },
                    label: 'Enter Your Email',
                    hintText: 'example',
                    prefixIcon: Icon(Icons.email,
                        size: 20.r, color: subcolor.withOpacity(0.4)),
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: Text(
                      '@nawroz.telecom.com',
                      style: subtitle2.copyWith(fontSize: 12.sp),
                    ),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),

                  //signUp Button
                  ElevatedButton(
                    onPressed: () async {
                      if (context
                          .read<AuthProvider>()
                          .checkEmail(emailController.text)) {}
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      await showLoadiongDialog(context);

                      var result = await context
                          .read<AuthProvider>()
                          .signUpMethod(
                              email: emailController.text,
                              fullName: fullNameController.text);
                      Navigator.pop(context);
                      if (result) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        log('error===============================>');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                    ),
                    child: Text('Sign Up', style: buttonTextStyle),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    color: subcolor.withOpacity(0.4),
                    height: 2.w,
                    endIndent: 10.w,
                    indent: 10.w,
                    thickness: 2.r,
                  ),

                  // sign up button and don't have .... text
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: RichText(
                      text: TextSpan(
                        text: 'have an account? ',
                        style: subtitle2,
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: subtitle.copyWith(color: primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
