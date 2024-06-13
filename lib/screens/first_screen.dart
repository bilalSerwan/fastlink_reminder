// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 0.35.sh,
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0.h),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Developed By \n',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 15.sp),
                      ),
                      TextSpan(
                        text: 'Fastlink Team',
                        style: TextStyle(color: Colors.black, fontSize: 17.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

checkToken(BuildContext context) async {
  final userToken = sharedPreferences.getString('user_token');
  if (userToken == null) {
    log('User_Token =======> null ');

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  } else {
    log('User_Token =======> $userToken ');
    final result = await AuthProvider().checkTokenExpiered(userToken);
    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DrawerScreen(),
        ),
      );
    }
  }
}
