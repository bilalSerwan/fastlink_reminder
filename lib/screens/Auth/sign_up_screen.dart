// ignore_for_file: use_build_context_synchronously

import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/home/home_screen.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                    height: 100.h,
                  ),
                  Text(
                    'FastLink',
                    style: largetext,
                  ),
                  Text(
                    'Reminder',
                    style: largetext,
                  ),
                  CustomeTextField(
                    controller: nameController,
                    validatorFunction: (value) {
                      if (value!.trim().isEmpty ||
                          value.length < 5 ||
                          value.length > 50) {
                        return "the value mut be between 5 to 50 chars";
                      }
                      return null;
                    },
                    label: 'Full Name',
                    hintText: 'Enter Your Full Name',
                    prefixIcon: Icon(
                      Icons.person,
                      size: 20.r,
                      color: subcolor.withOpacity(0.4),
                    ),
                  ),
                  CustomeTextField(
                    controller: emailController,
                    validatorFunction: (value) {
                      if (value!.trim().isEmpty ||
                          value.length < 5 ||
                          value.length > 50) {
                        return "the value mut be between 5 to 50 chars";
                      }
                      return null;
                    },
                    label: 'Enter Your Email',
                    hintText: 'example',
                    prefixIcon: Icon(Icons.email,
                        size: 20.r, color: subcolor.withOpacity(0.4)),
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: Text(
                      '@nawroz.telecom.com',
                      style: subtitle2,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  //signUp Button
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      print('running sign up Method .....................!');
                      print('add user .......................');
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: SizedBox(
                                  width: 100.w,
                                  height: 100.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              ));
                      await Future.delayed(
                        const Duration(seconds: 2),
                      );
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
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
