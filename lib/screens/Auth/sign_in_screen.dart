// ignore_for_file: use_build_context_synchronously

import 'package:fastlink_reminder/screens/Auth/sign_up_screen.dart';
import 'package:fastlink_reminder/screens/home/home_screen.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(10.r),
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
                      hintText: 'example@nawroz.telecom.com',
                      prefixIcon: Icons.email),
                  CustomeTextField(
                    controller: passwordController,
                    validatorFunction: (value) {
                      if (value!.trim().isEmpty ||
                          value.length < 5 ||
                          value.length > 50) {
                        return "the value mut be between 8 to 20 chars";
                      }
                      return null;
                    },
                    label: 'Enter Your Password',
                    hintText: '**********',
                    prefixIcon: Icons.password,
                  ),

                  //check box and text
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.w,
                          height: 40.w,
                          child: Checkbox(
                            value: checkBoxValue,
                            side: BorderSide(
                                strokeAlign: 2.r, color: primaryColor),
                            shape: const CircleBorder(),
                            checkColor: Colors.white,
                            activeColor: primaryColor,
                            onChanged: (bool? newValue) {
                              checkBoxValue = newValue ?? false;
                              setState(() {});
                            },
                          ),
                        ),
                        Text(
                          'Keep Me Sign In',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ),

                  //login Button
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      print('running Login Method .....................!');
                      print('check user .......................');
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: SizedBox(
                                  width: 100.w,
                                  height: 100.w,
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
                    child: Text(
                      'Login',
                      style: buttonTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    color: subcolor.withOpacity(0.3),
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
                        text: 'Don\'t have an account? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print(
                                    'running Sign Up Method .....................!');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
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
