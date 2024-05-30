// ignore_for_file: use_build_context_synchronously

import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/screens/Auth/sign_up_screen.dart';
import 'package:fastlink_reminder/screens/home/home_screen.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                      return context
                          .read<AuthProvider>()
                          .validationFunction(value, 5, 50);
                    },
                    label: 'Enter Your Email',
                    hintText: 'example@nawroz.telecom.com',
                    prefixIcon: Icon(
                      Icons.email,
                      size: 20.r,
                      color: subcolor.withOpacity(0.4),
                    ),
                  ),
                  CustomeTextField(
                    controller: passwordController,
                    validatorFunction: (value) {
                      return context
                          .read<AuthProvider>()
                          .validationFunction(value, 5, 50);
                    },
                    label: 'Enter Your Password',
                    hintText: context.watch<AuthProvider>().showPassword
                        ? '**********'
                        : "Password  ",
                    showPassword: context.watch<AuthProvider>().showPassword,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20.r,
                      color: subcolor.withOpacity(0.4),
                    ),
                    suffixIcon: IconButton(
                      iconSize: 20.r,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        context.read<AuthProvider>().changeShowPassword();
                      },
                      icon: Icon(context.watch<AuthProvider>().showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
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
                            value: context.watch<AuthProvider>().checkBoxValue,
                            side: BorderSide(
                                strokeAlign: 2.r, color: primaryColor),
                            shape: const CircleBorder(),
                            checkColor: Colors.white,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              context
                                  .read<AuthProvider>()
                                  .changeCheckBoxValue();
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
